import json
from pathlib import Path
from typing import List, Dict, Any
from pathlib import Path
import subprocess
import boto3
import shutil
import os
from botocore.exceptions import ClientError
import time
from ollama import chat
from ollama import ChatResponse
import re

DAFNY_PATH = "/Users/stefanze/Downloads/dafny-4.10.0/dafny"
CLIENT = boto3.client("bedrock-runtime",  region_name="us-east-1")
SONNET_BEDROCK_MODEL_ID = "arn:aws:bedrock:us-east-1:730335450364:inference-profile/us.anthropic.claude-3-7-sonnet-20250219-v1:0"
LLAMA_BEDROCK_MODEL_ID = "arn:aws:bedrock:us-east-1:730335450364:inference-profile/us.meta.llama3-3-70b-instruct-v1:0"
NOVA_BEDROCK_ID = "arn:aws:bedrock:us-east-1:730335450364:inference-profile/us.amazon.nova-pro-v1:0"
UTILS_FILE_PATH = "./dataset/utils.dfy"
PROMPT_FILE_PATH = "./eval/prompt.txt"
VALID_FOLDER_PATH = "./dataset/valid"
TEST_FOLDER_PATH = "./dataset/test"
RESULTS_PATH = "results"
N = 32
TEMPERATURE = 0.5
TOP_P = 0.9
MAX_GEN_LEN = 4000

def create_test_result(id: str, result: str) -> Dict[str, str]:
  return {"id": id, "result": result}

def write_test_results(results: List[Dict[str, Any]], results_file_path: Path, indent: int = 4) -> None:
  results_file_path.parent.mkdir(parents=True, exist_ok=True)
  with results_file_path.open('w') as file:
    json.dump(results, file, indent=indent)

def extract_lang(s: str) -> str:
  try:
    return s.split(f'```dafny')[1].split('```')[0].strip()
  except:
    return ''

def evaluate(type: str, model: str, service: str) -> None:
  if type == "valid":
    folder_path = Path(VALID_FOLDER_PATH)
  if type == "test":
    folder_path = Path(TEST_FOLDER_PATH)
  results = []
  results_file_path = Path(f"{RESULTS_PATH}/{model}/{type}/results.json")
  with open(UTILS_FILE_PATH, 'r') as file:
    utils_file_content = file.read()
  # Loop over every file in folder_path
  for incomplete_dafny_file in folder_path.iterdir():
    if incomplete_dafny_file.is_file():
      # Create traces folder and copy utils file into it
      if model != "dafny":
        traces_utils_path = f"traces/{model}"
        traces_results_path = f"traces/{model}/{type}"
        os.makedirs(traces_results_path, exist_ok=True)
        shutil.copy2(UTILS_FILE_PATH, traces_utils_path)
      # Remove {} on last line of problem file
      incomplete_dafny_file_path = f"{folder_path}/{incomplete_dafny_file.name}"
      with open(incomplete_dafny_file_path, 'r') as file:
        lines = file.readlines()
      lines = lines[:-1]
      incomplete_dafny_file_content = ''.join(lines)
      print(incomplete_dafny_file_content)
      incomplete_dafny_file_line_count = len(incomplete_dafny_file_content.splitlines())
      print(incomplete_dafny_file_line_count)
      with open(PROMPT_FILE_PATH) as f:
        prompts = list(map(lambda s: s.strip(), ''.join(f.readlines()).split('\n---\n')))
      sys_prompt = prompts[0].format(utils_file_content=utils_file_content)
      user_prompt = prompts[1].format(incomplete_dafny_file_content=incomplete_dafny_file_content)
      # Set verified to false
      verified = False
      # Loop until verified or i >= N
      i = 0
      while (not verified) and (i < N):
        # Empty completion
        if model == "dafny":
          completion = "{}"
          i = N
        else:
          if i == 0:
            completion = "{}"
          else:
            if service == "bedrock":
              completion = extract_lang(call_bedrock(sys_prompt, user_prompt, model))
            if service == "ollama":
              completion = extract_lang(call_ollama(sys_prompt, user_prompt, model))
            print(str(completion))
            completion = '\n'.join(str(completion).splitlines()[incomplete_dafny_file_line_count:])
        # Add completion
        complete_dafny_file_content = incomplete_dafny_file_content + completion
        # Write completed file
        if model != "dafny":
          complete_dafny_file_path = traces_results_path + f"/{incomplete_dafny_file.stem}_{i}.dfy"
          with open(complete_dafny_file_path, "w") as f:
              f.write(complete_dafny_file_content)
          s0 = subprocess.run(
              [DAFNY_PATH, "format", complete_dafny_file_path],
              shell=False,
              capture_output=False,
              timeout=15,
          )
        # Verify completed file
        if model == "dafny":
          _, verified = verify_dafny_file(incomplete_dafny_file_path)
        else:
          _, verified = verify_dafny_file(complete_dafny_file_path)
        # Add positive verification result
        if verified:
          if model == "dafny":
            results.append(create_test_result(incomplete_dafny_file_path, "verified"))
          else:
            results.append(create_test_result(incomplete_dafny_file_path, f"verified at iteration {i+1}"))
          write_test_results(results, results_file_path)
        # Increase counter
        i += 1
      # Add negative verification result
      if not verified:
        if model == "dafny":
          results.append(create_test_result(incomplete_dafny_file_path, "failed"))
        else: 
          results.append(create_test_result(incomplete_dafny_file_path, f"failed after {N} iterations"))
      write_test_results(results, results_file_path)


def call_bedrock(sys_prompt: str, user_prompt: str, model_id: str) -> str:
  if model_id == SONNET_BEDROCK_MODEL_ID:
    body = json.dumps({
      "system": sys_prompt,
      "anthropic_version": "bedrock-2023-05-31",
      "max_tokens": MAX_GEN_LEN,
      "messages": [
          {
              "role": "user",
              "content": [
                  {
                      "type": "text",
                      "text": user_prompt
                  }
              ]
          }
      ],
      "temperature": TEMPERATURE,
      "top_p": TOP_P
    })
    try:
      response = CLIENT.invoke_model(body=body, modelId=model_id)
    except (ClientError, Exception) as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      exit(1)
    response_body = json.loads(response.get('body').read())
    response_text = response_body["content"][0]["text"]
  
  if model_id == LLAMA_BEDROCK_MODEL_ID:
    formatted_prompt = f"""
    <|begin_of_text|><|start_header_id|>system<|end_header_id|>
    {sys_prompt}
    <|begin_of_text|><|start_header_id|>user<|end_header_id|>
    {user_prompt}
    <|eot_id|>
    <|start_header_id|>assistant<|end_header_id|>
    """
    native_request = {
        "prompt": formatted_prompt,
        "max_gen_len": MAX_GEN_LEN,
        "temperature": TEMPERATURE,
        "top_p": TOP_P
    }
    body = json.dumps(native_request)
    try:
      response = CLIENT.invoke_model(body=body, modelId=model_id)
    except (ClientError, Exception) as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      exit(1)
    response_body = json.loads(response.get('body').read())
    response_text = response_body["generation"]

  if model_id == NOVA_BEDROCK_ID:
    body = json.dumps({
      "system": sys_prompt,
      "messages": [
          {
            "role": "user",
            "content": [
              {
                "text": user_prompt
              }
            ]
          }
        ],
      "inferenceConfig": {
        "maxTokens": MAX_GEN_LEN,
        "temperature": TEMPERATURE,
        "topP": TOP_P
      }
    })
    try:
      response = CLIENT.invoke_model(body=body, modelId=model_id)
    except (ClientError, Exception) as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      exit(1)
    response_body = json.loads(response.get('body').read())
    response_text = response_body["output"]["message"]["content"][0]["text"]

  return response_text

def call_ollama(sys_prompt: str, user_prompt: str, model_id: str) -> str:
  response: ChatResponse = chat(
    model=model_id, 
    messages=[
      {
        'role': 'user',
        'content': sys_prompt + user_prompt,
      },
    ], 
    options={
      'temperature': TEMPERATURE,
      'top_p': TOP_P,
      'num_ctx': MAX_GEN_LEN
    }
  )
  response_content = response['message']['content']
  #response_content = re.sub(r"<think>.*?</think>\n?", "", response_content, flags=re.DOTALL)
  return response_content                        

def verify_dafny_file(file, silent=False):
  try:
    s = subprocess.run(
      [DAFNY_PATH, "verify", file, *(['--show-snippets', 'False'] if silent else [])],
      shell=False,
      capture_output=True,
      timeout=15,
    )
    
    output = s.stdout.decode('utf-8') + s.stderr.decode('utf-8')
    return output, (
      s.returncode == 0 and \
      "verified, 0 errors" in output and \
      "File contains no code" not in output
    )
  except subprocess.TimeoutExpired:
      return "Timed out after 15 seconds", False
    
def main() -> None:
  #evaluate("valid", "codestral", "ollama")
  evaluate("valid", "llama3.2", "ollama")
  #evaluate("valid", LLAMA_BEDROCK_MODEL_ID, "bedrock")
  #evaluate("valid", NOVA_BEDROCK_ID, "bedrock")
  #evaluate("valid", SONNET_BEDROCK_MODEL_ID, "bedrock")

if __name__ == "__main__":
  main()