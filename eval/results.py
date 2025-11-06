import json
from pathlib import Path
from typing import List, Dict, Any
from pathlib import Path
import subprocess
import boto3
from botocore.config import Config
import shutil
import os
import sys
from botocore.exceptions import ClientError
import time
from ollama import chat
from ollama import ChatResponse
import re
from concurrent.futures import ProcessPoolExecutor, as_completed
from tqdm import tqdm
import multiprocessing
from verify import verify_with_spec_check, setup_dafny_path
setup_dafny_path()
DAFNY_PATH = os.environ.get('DAFNY_PATH', 'dafny')

config = Config(
  retries={'max_attempts': 10, 'mode': 'adaptive'},
  read_timeout=3600
)
CLIENT = boto3.client("bedrock-runtime", region_name="us-east-2", config=config)
SONNET_37_BEDROCK_MODEL_ID = "us.anthropic.claude-3-7-sonnet-20250219-v1:0"
SONNET_4_BEDROCK_MODEL_ID = "us.anthropic.claude-sonnet-4-20250514-v1:0"
SONNET_45_BEDROCK_MODEL_ID = "us.anthropic.claude-sonnet-4-5-20250929-v1:0"
OPUS_4_BEDROCK_MODEL_ID = "us.anthropic.claude-opus-4-1-20250805-v1:0"
OPUS_4_NEW_BEDROCK_MODEL_ID = "us.anthropic.claude-opus-4-20250514-v1:0"
HAIKU_45_BEDROCK_MODEL_ID = "us.anthropic.claude-haiku-4-5-20251001-v1:0"
LLAMA_BEDROCK_MODEL_ID = "us.meta.llama3-3-70b-instruct-v1:0"
LLAMA4_MAVERICK_BEDROCK_ID = "us.meta.llama4-maverick-17b-instruct-v1:0"
GPT_OSS_120B_BEDROCK_ID = "openai.gpt-oss-120b-1:0"
GPT_OSS_20B_BEDROCK_ID = "openai.gpt-oss-20b-1:0"
QWEN3_CODER_30B_BEDROCK_ID = "qwen.qwen3-coder-30b-a3b-v1:0"
QWEN3_32B_BEDROCK_ID = "qwen.qwen3-32b-v1:0"
NOVA_PRO_BEDROCK_ID = "us.amazon.nova-pro-v1:0"
NOVA_PREMIER_BEDROCK_ID = "us.amazon.nova-premier-v1:0"
DEEPSEEK_R1_BEDROCK_ID = "us.deepseek.r1-v1:0"
DEEPSEEK_V3_BEDROCK_ID = "deepseek.v3-v1:0"
QWEN3_235B_MOE_BEDROCK_ID = "qwen.qwen3-235b-a22b-2507-v1:0"
QWEN3_CODER_480B_MOE_BEDROCK_ID = "qwen.qwen3-coder-480b-a35b-v1:0"

CLAUDE_MODELS = {SONNET_37_BEDROCK_MODEL_ID, SONNET_4_BEDROCK_MODEL_ID, SONNET_45_BEDROCK_MODEL_ID, OPUS_4_BEDROCK_MODEL_ID, OPUS_4_NEW_BEDROCK_MODEL_ID, HAIKU_45_BEDROCK_MODEL_ID}
CONVERSE_API_MODELS = {NOVA_PREMIER_BEDROCK_ID, NOVA_PRO_BEDROCK_ID, GPT_OSS_120B_BEDROCK_ID, GPT_OSS_20B_BEDROCK_ID, QWEN3_CODER_30B_BEDROCK_ID, QWEN3_32B_BEDROCK_ID, DEEPSEEK_R1_BEDROCK_ID, DEEPSEEK_V3_BEDROCK_ID, QWEN3_235B_MOE_BEDROCK_ID, QWEN3_CODER_480B_MOE_BEDROCK_ID, LLAMA4_MAVERICK_BEDROCK_ID}
UTILS_FILE_PATH = "./dataset/definitions.dfy"
LEMMAS_FILE_PATH = "./dataset/library.dfy"
PROMPT_FILE_PATH = "./eval/prompt.txt"
PROMPT_CONTEXT_FILE_PATH = "./eval/prompt_context.txt"
ERROR_CORRECTION_PROMPT_APPEND_CONVERSATION_FILE_PATH = "./eval/error_correction_prompt_append_conversation.txt"
ERROR_CORRECTION_PROMPT_NEW_CONVERSATION_FILE_PATH = "./eval/error_correction_prompt_new_conversation.txt"
VALID_FOLDER_PATH = "./dataset/valid"
TEST_FOLDER_PATH = "./dataset/test"
RESULTS_PATH = "results"
TRACES_PATH = "traces"
N = 4
E = 3
TEMPERATURE = 0.5
MAX_GEN_LEN = 8192

def create_test_result(id: str, status: str, attempt: int, error_corrections: int) -> Dict[str, Any]:
  return {"id": id, "result": f"{status} at attempt {attempt}, error corrections: {error_corrections}", "status": status, "attempt": attempt, "error_corrections": error_corrections}

def write_test_results(results: List[Dict[str, Any]], results_file_path: Path, indent: int = 4) -> None:
  results_file_path.parent.mkdir(parents=True, exist_ok=True)
  with results_file_path.open('w') as file:
    json.dump(results, file, indent=indent)

def extract_lang(s: str) -> str:
  try:
    return s.split(f'```dafny')[1].split('```')[0].strip()
  except:
    return ''

def call_bedrock_conversational(sys_prompt: str, user_prompt: str, model_id: str, messages: list) -> str:
  """Call Bedrock with conversational history."""
  messages_to_send = messages
  
  if model_id in CLAUDE_MODELS:
    body = json.dumps({
      "system": sys_prompt,
      "anthropic_version": "bedrock-2023-05-31",
      "max_tokens": MAX_GEN_LEN,
      "messages": messages_to_send,
      "temperature": TEMPERATURE
    })
    try:
      response = CLIENT.invoke_model(body=body, modelId=model_id)
    except ClientError as e:
      if e.response['Error']['Code'] == 'ThrottlingException':
        print(f"Rate limit hit. Waiting 300 seconds...")
        time.sleep(300)
        response = CLIENT.invoke_model(body=body, modelId=model_id)
      else:
        print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
        raise
    except Exception as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      raise
    response_body = json.loads(response.get('body').read())
    if "content" in response_body and len(response_body["content"]) > 0:
      response_text = response_body["content"][0]["text"]
      return response_text
    else:
      print(f"ERROR: Unexpected response format: {response_body}")
      return ""
  
  if model_id in CONVERSE_API_MODELS:
    try:
      response = CLIENT.converse(
        modelId=model_id,
        messages=messages_to_send,
        system=[{"text": sys_prompt}],
        inferenceConfig={"maxTokens": MAX_GEN_LEN, "temperature": TEMPERATURE}
      )
    except ClientError as e:
      if e.response['Error']['Code'] == 'ThrottlingException':
        print(f"Rate limit hit. Waiting 60 seconds...")
        time.sleep(60)
        response = CLIENT.converse(
          modelId=model_id,
          messages=messages_to_send,
          system=[{"text": sys_prompt}],
          inferenceConfig={"maxTokens": MAX_GEN_LEN, "temperature": TEMPERATURE}
        )
      else:
        print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
        raise
    except Exception as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      raise
    content = response["output"]["message"]["content"]
    text = next((item["text"] for item in content if "text" in item), None)
    if text is None:
      return "", []
    return text, content
  
  # For non-Claude models, fall back to stateless call
  return call_bedrock(sys_prompt, user_prompt, model_id)

def call_bedrock(sys_prompt: str, user_prompt: str, model_id: str) -> str:
  if model_id in CLAUDE_MODELS:
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
      "temperature": TEMPERATURE
    })
    try:
      response = CLIENT.invoke_model(body=body, modelId=model_id)
    except ClientError as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      raise
    except Exception as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      raise
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
        "temperature": TEMPERATURE
    }
    body = json.dumps(native_request)
    try:
      response = CLIENT.invoke_model(body=body, modelId=model_id)
    except (ClientError, Exception) as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      raise
    response_body = json.loads(response.get('body').read())
    response_text = response_body["generation"]

  if model_id in CONVERSE_API_MODELS:
    # DeepSeek R1 requires additionalModelRequestFields to enable reasoning
    additional_fields = {}
    if model_id == DEEPSEEK_R1_BEDROCK_ID:
      additional_fields = {"reasoning_content": {"type": "enabled"}}
    
    try:
      response = CLIENT.converse(
        modelId=model_id,
        messages=[{"role": "user", "content": [{"text": user_prompt}]}],
        system=[{"text": sys_prompt}],
        inferenceConfig={"maxTokens": MAX_GEN_LEN, "temperature": TEMPERATURE},
        additionalModelRequestFields=additional_fields if additional_fields else None
      )
    except ClientError as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      raise
    except Exception as e:
      print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
      raise
    content = response["output"]["message"]["content"]
    response_text = next((item["text"] for item in content if "text" in item), None)
    if response_text is None:
      raise ValueError(f"No text content found in response")

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
      'num_ctx': MAX_GEN_LEN
    }
  )
  response_content = response['message']['content']
  #response_content = re.sub(r"<think>.*?</think>\n?", "", response_content, flags=re.DOTALL)
  return response_content                        

def verify_dafny_baseline(incomplete_dafny_file_path: str, utils_file: str, lemmas_file: str, max_attempts: int = 5, timeout: int = 30) -> bool:
  """Try verifying file with Dafny multiple times with timeout"""
  for attempt in range(max_attempts):
    try:
      verified, errors = verify_with_spec_check(incomplete_dafny_file_path, incomplete_dafny_file_path, 
                                                return_errors=True, utils_file=utils_file, 
                                                lemmas_file=lemmas_file, timeout=timeout)
      if verified:
        return True
      if errors and "timed out" not in errors.lower():
        return False
    except Exception:
      continue
  return False

def _verify_single_file(args):
  """Helper function for parallel verification"""
  f, folder_path = args
  file_path = f"{folder_path}/{f.name}"
  with open(file_path, 'r') as file:
    file_content = file.read()
  utils_file = 'definitions.dfy' if 'definitions.dfy' in file_content else 'utils.dfy'
  lemmas_file = 'library.dfy' if 'library.dfy' in file_content else 'lemmas.dfy'
  
  verified = verify_dafny_baseline(file_path, utils_file, lemmas_file)
  status = "verified" if verified else "failed"
  return create_test_result(file_path, status, 1, 0), verified, file_path

def run_dafny_baseline(type: str, max_workers: int = None) -> set:
  """Run Dafny verification baseline and return set of verified file paths"""
  if max_workers is None:
    max_workers = multiprocessing.cpu_count()
  
  folder_path = Path(VALID_FOLDER_PATH if type == "valid" else TEST_FOLDER_PATH)
  files = sorted([f for f in folder_path.iterdir() if f.is_file()])
  
  results = []
  verified_files = set()
  
  with ProcessPoolExecutor(max_workers=max_workers) as executor:
    futures = [executor.submit(_verify_single_file, (f, folder_path)) for f in files]
    
    for future in tqdm(as_completed(futures), total=len(futures), desc=f"Dafny baseline {type}", position=0, leave=True):
      result, verified, file_path = future.result()
      results.append(result)
      if verified:
        verified_files.add(file_path)
  
  results_file_path = Path(f"{RESULTS_PATH}/dafny/{type}/results.json")
  write_test_results(results, results_file_path)
  return verified_files

def evaluate_parallel(type: str, model: str, service: str, max_workers: int = None, prompt_file: str = PROMPT_CONTEXT_FILE_PATH, num_samples: int = None, skip_verified: bool = True) -> None:
  if max_workers is None:
    max_workers = multiprocessing.cpu_count()
  
  verified_files = set()
  if skip_verified:
    dafny_results_path = Path(f"{RESULTS_PATH}/dafny/{type}/results.json")
    if dafny_results_path.exists():
      with open(dafny_results_path, 'r') as f:
        dafny_results = json.load(f)
        verified_files = {r['id'] for r in dafny_results if r['status'] == 'verified'}
    else:
      verified_files = run_dafny_baseline(type, max_workers)
  
  folder_path = Path(VALID_FOLDER_PATH if type == "valid" else TEST_FOLDER_PATH)
  files = sorted([f for f in folder_path.iterdir() if f.is_file()])
  
  if skip_verified:
    files = [f for f in files if f"{folder_path}/{f.name}" not in verified_files]
  
  if num_samples is not None:
    files = files[:num_samples]
  
  results = []
  results_file_path = Path(f"{RESULTS_PATH}/{model}/{type}/results.json")
  
  with ProcessPoolExecutor(max_workers=max_workers) as executor:
    futures = [executor.submit(evaluate_single_file, f, type, model, service, prompt_file, True) for f in files]
    
    for future in tqdm(as_completed(futures), total=len(futures), desc=f"Evaluating {type} with {model}", position=0, leave=True):
      result = future.result()
      results.append(result)
  
  write_test_results(results, results_file_path)



def evaluate_single_pass(incomplete_dafny_file, type: str, model: str, service: str, pass_num: int, messages: list, sys_prompt: str, user_prompt: str, incomplete_dafny_file_path: str, incomplete_dafny_file_content: str, utils_file: str, lemmas_file: str, silent: bool = False):
  """Evaluate a single pass with up to E error corrections"""
  ec_counter = 0
  pass_log = []
  
  # Generate solution with LLM
  if service == "bedrock":
    result = call_bedrock_conversational(sys_prompt, user_prompt, model, messages)
    if model in CONVERSE_API_MODELS:
      raw, full_content = result
      complete_dafny_file_content = extract_lang(raw)
      pass_log.append({"ec": ec_counter, "input": messages[-1], "output": raw})
      if full_content:
        # Strip reasoning content for DeepSeek R1 to avoid API errors
        if model == DEEPSEEK_R1_BEDROCK_ID:
          content_to_add = [{"text": item["text"]} for item in full_content if "text" in item]
        else:
          content_to_add = full_content
        messages.append({"role": "assistant", "content": content_to_add})
    else:
      raw = result
      complete_dafny_file_content = extract_lang(raw)
      pass_log.append({"ec": ec_counter, "input": messages[-1], "output": raw})
      messages.append({"role": "assistant", "content": [{"type": "text", "text": raw}]})
  elif service == "ollama":
    raw = call_ollama(sys_prompt, user_prompt, model)
    complete_dafny_file_content = extract_lang(raw)
  
  # Save attempt
  complete_dafny_file_path = f"{TRACES_PATH}/{model}/{type}/{incomplete_dafny_file.stem}_pass_{pass_num}_ec_{ec_counter}.dfy"
  with open(complete_dafny_file_path, "w") as f:
    f.write(complete_dafny_file_content)
  subprocess.run([DAFNY_PATH, "format", complete_dafny_file_path], shell=False, capture_output=True, timeout=15)
  
  # Verify
  verified, errors = verify_with_spec_check(incomplete_dafny_file_path, complete_dafny_file_path, return_errors=True, utils_file=utils_file, lemmas_file=lemmas_file)
  
  # Add verification result to log
  pass_log[-1]["verification"] = {"verified": verified, "errors": errors if not verified else None}
  
  if verified:
    return True, 0, pass_log
  
  # Error correction loop
  error_corrections = 0
  while error_corrections < E and errors:
    ec_counter += 1
    error_corrections += 1
    
    with open(ERROR_CORRECTION_PROMPT_APPEND_CONVERSATION_FILE_PATH) as f:
      error_prompt = f.read().strip()
    error_message = error_prompt.replace('{errors}', errors).replace('{incomplete_dafny_file_content}', incomplete_dafny_file_content)
    
    if model in CLAUDE_MODELS:
      messages.append({"role": "user", "content": [{"type": "text", "text": error_message}]})
    else:
      messages.append({"role": "user", "content": [{"text": error_message}]})
    
    # Generate corrected solution
    if service == "bedrock":
      result = call_bedrock_conversational(sys_prompt, user_prompt, model, messages)
      if model in CONVERSE_API_MODELS:
        raw, full_content = result
        complete_dafny_file_content = extract_lang(raw)
        pass_log.append({"ec": ec_counter, "input": messages[-1], "output": raw})
        if full_content:
          # Strip reasoning content for DeepSeek R1 to avoid API errors
          if model == DEEPSEEK_R1_BEDROCK_ID:
            content_to_add = [{"text": item["text"]} for item in full_content if "text" in item]
          else:
            content_to_add = full_content
          messages.append({"role": "assistant", "content": content_to_add})
      else:
        raw = result
        complete_dafny_file_content = extract_lang(raw)
        pass_log.append({"ec": ec_counter, "input": messages[-1], "output": raw})
        messages.append({"role": "assistant", "content": [{"type": "text", "text": raw}]})
    elif service == "ollama":
      raw = call_ollama(sys_prompt, user_prompt, model)
      complete_dafny_file_content = extract_lang(raw)
    
    # Save corrected attempt
    complete_dafny_file_path = f"{TRACES_PATH}/{model}/{type}/{incomplete_dafny_file.stem}_pass_{pass_num}_ec_{ec_counter}.dfy"
    with open(complete_dafny_file_path, "w") as f:
      f.write(complete_dafny_file_content)
    subprocess.run([DAFNY_PATH, "format", complete_dafny_file_path], shell=False, capture_output=True, timeout=15)
    
    # Verify corrected solution
    verified, errors = verify_with_spec_check(incomplete_dafny_file_path, complete_dafny_file_path, return_errors=True, utils_file=utils_file, lemmas_file=lemmas_file)
    
    # Add verification result to log
    if pass_log:
      pass_log[-1]["verification"] = {"verified": verified, "errors": errors if not verified else None}
    
    if verified:
      return True, error_corrections, pass_log
  
  return False, error_corrections, pass_log

def evaluate_single_file(incomplete_dafny_file, type: str, model: str, service: str, prompt_file: str = PROMPT_CONTEXT_FILE_PATH, silent: bool = False):
  folder_path = Path(VALID_FOLDER_PATH if type == "valid" else TEST_FOLDER_PATH)
  results_file_path = Path(f"{RESULTS_PATH}/{model}/{type}/results.json")
  
  # Detect which utils and lemmas files are being used
  incomplete_dafny_file_path = f"{folder_path}/{incomplete_dafny_file.name}"
  with open(incomplete_dafny_file_path, 'r') as file:
    file_content = file.read()
  
  utils_file = 'definitions.dfy' if 'definitions.dfy' in file_content else 'utils.dfy'
  lemmas_file = 'library.dfy' if 'library.dfy' in file_content else 'lemmas.dfy'
  
  utils_file_path = f"./dataset/{utils_file}"
  lemmas_file_path = f"./dataset/{lemmas_file}"
  
  with open(utils_file_path, 'r') as file:
    utils_file_content = file.read()
  
  if model != "dafny":
    traces_model_path = f"{TRACES_PATH}/{model}"
    traces_results_path = f"{TRACES_PATH}/{model}/{type}"
    os.makedirs(traces_model_path, exist_ok=True)
    os.makedirs(traces_results_path, exist_ok=True)
    shutil.copy2(utils_file_path, traces_model_path)
    shutil.copy2(lemmas_file_path, traces_model_path)
  
  with open(incomplete_dafny_file_path, 'r') as file:
    lines = file.readlines()
  lines = lines[:-1]
  incomplete_dafny_file_content = ''.join(lines)
  incomplete_dafny_file_line_count = len(incomplete_dafny_file_content.splitlines())
  
  with open(lemmas_file_path, 'r') as file:
    lemmas_file_content = file.read()
  with open(prompt_file) as f:
    prompts = list(map(lambda s: s.strip(), ''.join(f.readlines()).split('\n---\n')))
  
  sys_prompt = prompts[0].replace('{definitions_file_content}', utils_file_content).replace('{libraries_file_content}', lemmas_file_content)
  if model in {GPT_OSS_120B_BEDROCK_ID, GPT_OSS_20B_BEDROCK_ID}:
    sys_prompt += "\n\nIMPORTANT: You must complete your response within the token limit. Provide a concise, complete solution."
  user_prompt = prompts[1].replace('{incomplete_dafny_file_content}', incomplete_dafny_file_content)
  
  # Initialize conversation messages with initial user prompt
  if model in CLAUDE_MODELS:
    messages = [{"role": "user", "content": [{"type": "text", "text": user_prompt}]}]
  else:
    messages = [{"role": "user", "content": [{"text": user_prompt}]}]
  
  for pass_num in range(N):
    # Reset messages for each pass
    if model in CLAUDE_MODELS:
      messages = [{"role": "user", "content": [{"type": "text", "text": user_prompt}]}]
    else:
      messages = [{"role": "user", "content": [{"text": user_prompt}]}]
    
    try:
      verified, error_corrections, pass_log = evaluate_single_pass(
        incomplete_dafny_file, type, model, service, pass_num, messages,
        sys_prompt, user_prompt, incomplete_dafny_file_path,
        incomplete_dafny_file_content, utils_file, lemmas_file, silent
      )
    except Exception as e:
      if not silent:
        print(f"✗ {incomplete_dafny_file.name}: error at pass {pass_num+1}: {e}")
      continue
    
    # Save pass log
    if model != "dafny" and pass_log:
      log_path = f"{TRACES_PATH}/{model}/{type}/{incomplete_dafny_file.stem}_pass_{pass_num}_log.json"
      with open(log_path, "w") as f:
        json.dump(pass_log, f, indent=2)
    
    if verified:
      if not silent:
        print(f"✓ {incomplete_dafny_file.name}: verified at pass {pass_num+1}, error corrections: {error_corrections}")
      return create_test_result(incomplete_dafny_file_path, "verified", pass_num+1, error_corrections)
    
    if model == "dafny":
      break
  
  if not silent:
    print(f"✗ {incomplete_dafny_file.name}: failed after {N} passes")
  return create_test_result(incomplete_dafny_file_path, "failed", N, 0)

def evaluate_single_file_new_conversation(incomplete_dafny_file, type: str, model: str, service: str, prompt_file: str = PROMPT_CONTEXT_FILE_PATH, silent: bool = False):
  folder_path = Path(VALID_FOLDER_PATH if type == "valid" else TEST_FOLDER_PATH)
  
  with open(UTILS_FILE_PATH, 'r') as file:
    utils_file_content = file.read()
  
  if model != "dafny":
    traces_model_path = f"{TRACES_PATH}/{model}"
    traces_results_path = f"{TRACES_PATH}/{model}/{type}"
    os.makedirs(traces_model_path, exist_ok=True)
    os.makedirs(traces_results_path, exist_ok=True)
    shutil.copy2(UTILS_FILE_PATH, traces_model_path)
    shutil.copy2(LEMMAS_FILE_PATH, traces_model_path)
  
  incomplete_dafny_file_path = f"{folder_path}/{incomplete_dafny_file.name}"
  with open(incomplete_dafny_file_path, 'r') as file:
    lines = file.readlines()
  lines = lines[:-1]
  incomplete_dafny_file_content = ''.join(lines)
  incomplete_dafny_file_line_count = len(incomplete_dafny_file_content.splitlines())
  
  with open(LEMMAS_FILE_PATH, 'r') as file:
    lemmas_file_content = file.read()
  with open(prompt_file) as f:
    prompts = list(map(lambda s: s.strip(), ''.join(f.readlines()).split('\n---\n')))
  sys_prompt = prompts[0].replace('{definitions_file_content}', utils_file_content).replace('{libraries_file_content}', lemmas_file_content)
  if model in {GPT_OSS_120B_BEDROCK_ID, GPT_OSS_20B_BEDROCK_ID}:
    sys_prompt += "\n\nIMPORTANT: You must complete your response within the token limit. Provide a concise, complete solution."
  user_prompt = prompts[1].replace('{incomplete_dafny_file_content}', incomplete_dafny_file_content)
  
  verified = False
  i = 0
  interaction_log = []
  total_error_corrections = 0
  
  while (not verified) and (i < N):
    error_corrections = 0
    ec_counter = 0
    if model == "dafny":
      complete_dafny_file_content = incomplete_dafny_file_content + "{}"
      i = N
    else:
      if i == 0:
        complete_dafny_file_content = incomplete_dafny_file_content + "{}"
      else:
        if service == "bedrock":
          raw = call_bedrock(sys_prompt, user_prompt, model)
          complete_dafny_file_content = extract_lang(raw)
          interaction_log.append({"input": {"system": sys_prompt, "user": user_prompt}, "output": raw})
        if service == "ollama":
          raw = call_ollama(sys_prompt, user_prompt, model)
          complete_dafny_file_content = extract_lang(raw)
    
    if model != "dafny":
      complete_dafny_file_path = f"{TRACES_PATH}/{model}/{type}/{incomplete_dafny_file.stem}_pass_{i}_ec_{ec_counter}.dfy"
      with open(complete_dafny_file_path, "w") as f:
        f.write(complete_dafny_file_content)
      subprocess.run([DAFNY_PATH, "format", complete_dafny_file_path], shell=False, capture_output=True, timeout=15)
      ec_counter += 1
    
    if model == "dafny":
      verified, errors = verify_with_spec_check(incomplete_dafny_file_path, incomplete_dafny_file_path, return_errors=True)
    else:
      verified, errors = verify_with_spec_check(incomplete_dafny_file_path, complete_dafny_file_path, return_errors=True)
    
    if verified:
      if not silent:
        print(f"✓ {incomplete_dafny_file.name}: verified at attempt {i+1}, error corrections: {error_corrections}")
      log_path = f"{TRACES_PATH}/{model}/{type}/{incomplete_dafny_file.stem}_log.json"
      with open(log_path, "w") as f:
        json.dump(interaction_log, f, indent=2)
      return create_test_result(incomplete_dafny_file_path, "verified", i+1, total_error_corrections + error_corrections)
    
    if not verified and error_corrections < E and model != "dafny" and errors and i > 0:
      if "timed out" in errors.lower():
        i += 1
        continue
      error_corrections += 1
      total_error_corrections += 1
      with open(ERROR_CORRECTION_PROMPT_NEW_CONVERSATION_FILE_PATH) as f:
        error_prompts = list(map(lambda s: s.strip(), ''.join(f.readlines()).split('\n---\n')))
      sys_prompt = error_prompts[0].replace('{errors}', errors).replace('{definitions_file_content}', utils_file_content).replace('{libraries_file_content}', lemmas_file_content).replace('{incomplete_dafny_file_content}', incomplete_dafny_file_content).replace('{complete_dafny_file_content}', complete_dafny_file_content)
      user_prompt = error_prompts[1] if len(error_prompts) > 1 else "Fix the errors."
      continue
    
    i += 1
  
  if not silent:
    print(f"✗ {incomplete_dafny_file.name}: failed after {N} attempts, error corrections: {total_error_corrections}")
  if model != "dafny":
    log_path = f"{TRACES_PATH}/{model}/{type}/{incomplete_dafny_file.stem}_log.json"
    with open(log_path, "w") as f:
      json.dump(interaction_log, f, indent=2)
  return create_test_result(incomplete_dafny_file_path, "failed", N, total_error_corrections)

def main() -> None:
  run_dafny_baseline("test", max_workers=8)
  run_dafny_baseline("valid", max_workers=8)
  
  evaluate_parallel("test", SONNET_4_BEDROCK_MODEL_ID, "bedrock", max_workers=8, skip_verified=True)
  evaluate_parallel("test", SONNET_45_BEDROCK_MODEL_ID, "bedrock", max_workers=8, skip_verified=True)

if __name__ == "__main__":
  main()