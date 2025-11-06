#!/usr/bin/env python3
"""Test all models in parallel with N=4, E=3"""
import sys
import os
import argparse
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '../../eval'))

parser = argparse.ArgumentParser(description='Test all models')
parser.add_argument('--debug', action='store_true', help='Run on 1 problem only for debugging')
args = parser.parse_args()

import results as results_module
from results import (
    evaluate_parallel,
    SONNET_37_BEDROCK_MODEL_ID,
    SONNET_4_BEDROCK_MODEL_ID,
    SONNET_45_BEDROCK_MODEL_ID,
    OPUS_4_BEDROCK_MODEL_ID,
    OPUS_4_NEW_BEDROCK_MODEL_ID,
    HAIKU_45_BEDROCK_MODEL_ID,
    LLAMA_BEDROCK_MODEL_ID,
    LLAMA4_MAVERICK_BEDROCK_ID,
    GPT_OSS_120B_BEDROCK_ID,
    GPT_OSS_20B_BEDROCK_ID,
    QWEN3_CODER_30B_BEDROCK_ID,
    QWEN3_32B_BEDROCK_ID,
    NOVA_PRO_BEDROCK_ID,
    NOVA_PREMIER_BEDROCK_ID,
    DEEPSEEK_R1_BEDROCK_ID,
    DEEPSEEK_V3_BEDROCK_ID,
    QWEN3_235B_MOE_BEDROCK_ID,
    QWEN3_CODER_480B_MOE_BEDROCK_ID
)


results_module.UTILS_FILE_PATH = "./dataset/definitions.dfy"
results_module.LEMMAS_FILE_PATH = "./dataset/library.dfy"
results_module.TRACES_PATH = "traces_debug" if args.debug else "traces"
results_module.RESULTS_PATH = "results_debug" if args.debug else "results"

# Copy Dafny baseline results to debug folder if in debug mode
if args.debug:
    import shutil
    for dataset in ["test", "valid"]:
        src = Path(f"results/dafny/{dataset}/results.json")
        dst = Path(f"results_debug/dafny/{dataset}/results.json")
        if src.exists():
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, dst)
            print(f"Copied Dafny baseline: {src} -> {dst}")

# Override N and E globally
original_N = results_module.N
original_E = results_module.E
results_module.N = 4
results_module.E = 3
print(f"Set N={results_module.N}, E={results_module.E}")

MODELS = [
    ("Claude 3.7 Sonnet", SONNET_37_BEDROCK_MODEL_ID),
    ("Claude Sonnet 4", SONNET_4_BEDROCK_MODEL_ID),
    ("Claude Sonnet 4.5", SONNET_45_BEDROCK_MODEL_ID),
    ("Claude Opus 4", OPUS_4_BEDROCK_MODEL_ID),
    ("Claude Opus 4 New", OPUS_4_NEW_BEDROCK_MODEL_ID),
    ("Claude Haiku 4.5", HAIKU_45_BEDROCK_MODEL_ID),
    ("Llama 3.3 70B", LLAMA_BEDROCK_MODEL_ID),
    ("Llama 4 Maverick 17B", LLAMA4_MAVERICK_BEDROCK_ID),
    ("GPT-OSS 120B", GPT_OSS_120B_BEDROCK_ID),
    ("GPT-OSS 20B", GPT_OSS_20B_BEDROCK_ID),
    ("Qwen3 Coder 30B", QWEN3_CODER_30B_BEDROCK_ID),
    ("Qwen3 32B", QWEN3_32B_BEDROCK_ID),
    ("Nova Pro", NOVA_PRO_BEDROCK_ID),
    ("Nova Premier", NOVA_PREMIER_BEDROCK_ID),
    ("DeepSeek R1", DEEPSEEK_R1_BEDROCK_ID),
    ("DeepSeek V3", DEEPSEEK_V3_BEDROCK_ID),
    ("Qwen3 235B MoE", QWEN3_235B_MOE_BEDROCK_ID),
    ("Qwen3 Coder 480B MoE", QWEN3_CODER_480B_MOE_BEDROCK_ID)
]

def run_model(name, model_id):
    """Run evaluation for a single model on both valid and test sets"""
    import time
    start = time.time()
    try:
        # Evaluate test set first
        print(f"[{name}] Evaluating test set...")
        evaluate_parallel("test", model_id, "bedrock", max_workers=2, skip_verified=True, num_samples=1 if args.debug else None)
        
        if not args.debug:
            # Evaluate valid set
            print(f"[{name}] Evaluating valid set...")
            evaluate_parallel("valid", model_id, "bedrock", max_workers=2, skip_verified=True, num_samples=None)
        
        elapsed = time.time() - start
        print(f"[{name}] ✓ Completed in {elapsed:.1f}s")
        return {"model": name, "status": "success", "time": elapsed}
    except Exception as e:
        elapsed = time.time() - start
        print(f"[{name}] ✗ Failed after {elapsed:.1f}s: {e}")
        return {"model": name, "status": "failed", "error": str(e), "time": elapsed}

print("="*70)
print("PARALLEL MODEL EVALUATION - VALID & TEST SETS")
if args.debug:
    print("DEBUG MODE: Testing with 1 problem only")
print(f"Configuration: {len(MODELS)} models in parallel")
print(f"Total concurrent workers: {len(MODELS) * 2} ({len(MODELS)} models × 2 workers)")
print(f"Models: {len(MODELS)}")
print("="*70)

results = []
with ThreadPoolExecutor(max_workers=len(MODELS)) as executor:
    futures = {executor.submit(run_model, name, model_id): name for name, model_id in MODELS}
    
    for future in as_completed(futures):
        try:
            result = future.result(timeout=600)  # 10 min timeout per model
            results.append(result)
            print(f"\n{result['model']}: {result['status']}")
        except Exception as e:
            model_name = futures[future]
            print(f"\n{model_name}: timeout or error - {e}")
            results.append({"model": model_name, "status": "timeout", "error": str(e)})

print("\n" + "="*70)
print("ALL MODELS COMPLETED")
print("="*70)
total = len(MODELS)
print(f"\nSuccess: {sum(1 for r in results if r['status'] == 'success')}/{total}")
print(f"Failed: {sum(1 for r in results if r['status'] == 'failed')}/{total}")
print(f"Timeout: {sum(1 for r in results if r['status'] == 'timeout')}/{total}")

# Restore original values
results_module.N = original_N
results_module.E = original_E
