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

DAFNY_PATH = "/Users/stefanze/Downloads/dafny-4.10.0/dafny"
CLIENT = boto3.client("bedrock-runtime",  region_name="us-east-1")
SONNET_MODEL_ID = "arn:aws:bedrock:us-east-1:730335450364:inference-profile/us.anthropic.claude-3-5-sonnet-20241022-v2:0"
#DEEPSEEK_MODEL_ID =
LLAMA_MODEL_ID = "arn:aws:bedrock:us-east-1:730335450364:inference-profile/us.meta.llama3-3-70b-instruct-v1:0"
UTILS_FILE_PATH = "./dataset/utils.dfy"
VALID_FOLDER_PATH = "./dataset/valid"
TEST_FOLDER_PATH = "./dataset/test"
RESULTS_PATH = "results"
N = 5
TEMPERATURE = 0.5
TOP_P = 0.9
MAX_GEN_LEN = 2048

def create_test_result(id: str, result: str) -> Dict[str, str]:
  return {"id": id, "result": result}

def write_test_results(results: List[Dict[str, Any]], results_file_path: Path, indent: int = 4) -> None:
  results_file_path.parent.mkdir(parents=True, exist_ok=True)
  with results_file_path.open('w') as file:
    json.dump(results, file, indent=indent)

def evaluate(type: str, model: str) -> None:
  if type == "valid":
    folder_path = Path(VALID_FOLDER_PATH)
  if type == "test":
    folder_path = Path(TEST_FOLDER_PATH)
  results = []
  results_file_path = Path(f"{RESULTS_PATH}/{model}/results.json")
  # Loop over every file in folder_path
  for incomplete_dafny_file in folder_path.iterdir():
    if incomplete_dafny_file.is_file():
      # Create traces folder and copy utils file into it
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
      # Set verified to false
      verified = False
      # Loop until verified or i >= N
      i = 0
      while (not verified) and (i < N):
        # Empty completion
        if model == "dafny":
          completion = "{}"
        # Sonnet completion
        if model == "sonnet":
          if i == 0:
            completion = "{}"
          else:
            completion = call_bedrock(incomplete_dafny_file_content, SONNET_MODEL_ID)
            time.sleep(7) # sleep to avoid throttling exception
            print("sleeping")
        # Llama completion
        if model == "llama":
          if i == 0:
            completion = "{}"
          else:
            completion =  call_bedrock(incomplete_dafny_file_content, LLAMA_MODEL_ID)
        # Add completion
        complete_dafny_file_content = incomplete_dafny_file_content + str(completion)
        print(complete_dafny_file_content)
        # Write completed file
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
        _, verified = verify_dafny_file(complete_dafny_file_path)
        # Add positive verification result
        if verified:
          results.append(create_test_result(incomplete_dafny_file_path, f"verified at iteration {i+1}"))
          write_test_results(results, results_file_path)
        # Increase counter
        i += 1
      # Add negative verification result
      if not verified:
        results.append(create_test_result(incomplete_dafny_file_path, f"failed after {N} iterations"))
      write_test_results(results, results_file_path)


def call_bedrock(incomplete_dafny_file_content: str, model_id: str) -> str:
  with open(UTILS_FILE_PATH, 'r') as file:
    utils_file_content = file.read()

  prompt = "The Dafny file 'utils.dfy' has the following content: \n\n" + utils_file_content + "\n\n\n Please append to the following Dafny file so that it verifies: \n\n" + incomplete_dafny_file_content + "\n\n Only return the part that you want to append. Do not return anything else."

  if model_id == SONNET_MODEL_ID:
    body = json.dumps({
      "anthropic_version": "bedrock-2023-05-31",
      "max_tokens": MAX_GEN_LEN,
      "messages": [
          {
              "role": "user",
              "content": [
                  {
                      "type": "text",
                      "text": prompt
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
  
  if model_id == LLAMA_MODEL_ID:
    formatted_prompt = f"""
    <|begin_of_text|><|start_header_id|>user<|end_header_id|>
    {prompt}
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

  return response_text


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
  evaluate("valid", "llama")

if __name__ == "__main__":
    main()
  