#!/usr/bin/env python3
"""Test both error correction modes: append conversation vs new conversation"""
import sys
sys.path.insert(0, '../../eval')

from results import evaluate_parallel, evaluate_with_context_parallel, SONNET_4_BEDROCK_MODEL_ID, OPUS_4_BEDROCK_MODEL_ID, NOVA_PREMIER_BEDROCK_ID, GPT_OSS_20B_BEDROCK_ID, QWEN3_CODER_30B_BEDROCK_ID, QWEN3_32B_BEDROCK_ID
import shutil
from pathlib import Path

if __name__ == '__main__':
    models = [(SONNET_4_BEDROCK_MODEL_ID, "sonnet4"), (OPUS_4_BEDROCK_MODEL_ID, "opus4"), (NOVA_PREMIER_BEDROCK_ID, "nova_premier"), (GPT_OSS_20B_BEDROCK_ID, "gpt_oss_20b"), (QWEN3_CODER_30B_BEDROCK_ID, "qwen3_coder_30b"), (QWEN3_32B_BEDROCK_ID, "qwen3_32b")]
    
    for model_id, model_name in models:
        print("\n" + "="*80)
        print(f"TESTING {model_name.upper()} (25 problems, n_workers=5, E=3)")
        print("="*80)

        print("\n" + "="*80)
        print("TEST 1: CONVERSATIONAL MODE (append to conversation)")
        print("="*80)
        evaluate_parallel("test", model_id, "bedrock", max_workers=5, num_samples=25)
        shutil.move(f"results/{model_id}/test", f"results/conversational_mode_{model_name}")
        
        print("\n" + "="*80)
        print("TEST 2: NEW CONVERSATION MODE (single-shot with full context)")
        print("="*80)
        evaluate_with_context_parallel("test", model_id, "bedrock", max_workers=5, num_samples=25)
        shutil.move(f"results/{model_id}/test", f"results/new_conversation_mode_{model_name}")
    
    print("\n" + "="*80)
    print("SUMMARY")
    print("="*80)
    print("\nResults saved:")
    for _, model_name in models:
        print(f"  - {model_name} Conversational: results/conversational_mode_{model_name}/")
        print(f"  - {model_name} New conversation: results/new_conversation_mode_{model_name}/")
