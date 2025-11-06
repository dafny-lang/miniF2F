#!/usr/bin/env python3
"""Test 9 models on IMO problems with optional v2 files"""
import sys
import os
import argparse
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor, as_completed
from tqdm import tqdm

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '../../eval'))

import results
from results import (
    SONNET_37_BEDROCK_MODEL_ID,
    SONNET_4_BEDROCK_MODEL_ID,
    SONNET_45_BEDROCK_MODEL_ID,
    OPUS_4_BEDROCK_MODEL_ID,
    GPT_OSS_120B_BEDROCK_ID,
    GPT_OSS_20B_BEDROCK_ID,
    QWEN3_CODER_30B_BEDROCK_ID,
    NOVA_PREMIER_BEDROCK_ID,
    DEEPSEEK_R1_BEDROCK_ID
)

MODELS = [
    ("Claude 3.7 Sonnet", SONNET_37_BEDROCK_MODEL_ID),
    ("Claude Sonnet 4", SONNET_4_BEDROCK_MODEL_ID),
    ("Claude Sonnet 4.5", SONNET_45_BEDROCK_MODEL_ID),
    ("Claude Opus 4", OPUS_4_BEDROCK_MODEL_ID),
    ("GPT-OSS 120B", GPT_OSS_120B_BEDROCK_ID),
    ("GPT-OSS 20B", GPT_OSS_20B_BEDROCK_ID),
    ("Qwen3 Coder 30B", QWEN3_CODER_30B_BEDROCK_ID),
    ("Nova Premier", NOVA_PREMIER_BEDROCK_ID),
    ("DeepSeek R1", DEEPSEEK_R1_BEDROCK_ID)
]

def run_model(name, model_id, use_v2, max_workers=2):
    """Run evaluation for a single model on IMO problems"""
    import time
    
    # Get IMO problems
    folder_path = Path(results.TEST_FOLDER_PATH)
    imo_files = sorted([f for f in folder_path.iterdir() if f.is_file() and f.name.startswith('imo_')])
    
    print(f"\n[{name}] Starting evaluation on {len(imo_files)} IMO problems with {max_workers} workers")
    start = time.time()
    
    try:
        eval_results = []
        with ProcessPoolExecutor(max_workers=max_workers) as executor:
            futures = [executor.submit(results.evaluate_single_file, f, "test", model_id, "bedrock", results.PROMPT_CONTEXT_FILE_PATH, True) for f in imo_files]
            
            for future in tqdm(as_completed(futures), total=len(futures), desc=f"[{name}]", position=0, leave=False):
                result = future.result()
                eval_results.append(result)
        
        # Save results
        suffix = "_v2" if use_v2 else ""
        results_file_path = Path(f"{results.RESULTS_PATH}/{model_id}/test/results_imo{suffix}.json")
        results.write_test_results(eval_results, results_file_path)
        
        elapsed = time.time() - start
        verified = sum(1 for r in eval_results if r['status'] == 'verified')
        print(f"[{name}] ✓ Completed in {elapsed:.1f}s - {verified}/{len(imo_files)} verified")
        return {"model": name, "status": "success", "time": elapsed, "verified": verified, "total": len(imo_files)}
    except Exception as e:
        elapsed = time.time() - start
        print(f"[{name}] ✗ Failed after {elapsed:.1f}s: {e}")
        return {"model": name, "status": "failed", "error": str(e), "time": elapsed}

def main():
    parser = argparse.ArgumentParser(description='Test all models on IMO problems')
    parser.add_argument('--use-v2', action='store_true', help='Use utils_v2.dfy and lemmas_v2.dfy')
    parser.add_argument('--workers', type=int, default=2, help='Workers per model (default: 2)')
    args = parser.parse_args()
    
    # Configure paths based on flag
    if args.use_v2:
        results.UTILS_FILE_PATH = "./dataset/utils_v2.dfy"
        results.LEMMAS_FILE_PATH = "./dataset/lemmas_v2.dfy"
        results.TRACES_PATH = "traces_updated"
        results.RESULTS_PATH = "results_updated"
        print("Using utils_v2.dfy and lemmas_v2.dfy")
        print(f"Traces: traces_updated/, Results: results_updated/")
    else:
        print("Using utils.dfy and lemmas.dfy")
        print(f"Traces: traces/, Results: results/")
    
    print("="*70)
    print("PARALLEL MODEL EVALUATION - IMO PROBLEMS")
    print(f"Configuration: {args.workers} workers per model, 9 models in parallel")
    print("="*70)
    
    eval_results = []
    with ThreadPoolExecutor(max_workers=9) as executor:
        futures = {executor.submit(run_model, name, model_id, args.use_v2, args.workers): name for name, model_id in MODELS}
        
        for future in as_completed(futures):
            try:
                result = future.result(timeout=3600)  # 1 hour timeout per model
                eval_results.append(result)
            except Exception as e:
                model_name = futures[future]
                print(f"\n{model_name}: timeout or error - {e}")
                eval_results.append({"model": model_name, "status": "timeout", "error": str(e)})
    
    print("\n" + "="*70)
    print("ALL MODELS COMPLETED")
    print("="*70)
    
    success_count = sum(1 for r in eval_results if r['status'] == 'success')
    print(f"\nSuccess: {success_count}/9")
    print(f"Failed: {sum(1 for r in eval_results if r['status'] == 'failed')}/9")
    print(f"Timeout: {sum(1 for r in eval_results if r['status'] == 'timeout')}/9")
    
    if success_count > 0:
        print("\nVerification Results:")
        for r in eval_results:
            if r['status'] == 'success':
                print(f"  {r['model']}: {r['verified']}/{r['total']} verified ({r['verified']/r['total']*100:.1f}%)")

if __name__ == "__main__":
    main()
