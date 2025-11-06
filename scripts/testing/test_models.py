#!/usr/bin/env python3
"""Test each model with error correction on a single problem"""
import sys
sys.path.insert(0, '../../eval')
from pathlib import Path

from results import (
    evaluate_single_file,
    SONNET_4_BEDROCK_MODEL_ID, 
    OPUS_4_BEDROCK_MODEL_ID, 
    NOVA_PREMIER_BEDROCK_ID,
    GPT_OSS_20B_BEDROCK_ID,
    QWEN3_CODER_30B_BEDROCK_ID,
    QWEN3_32B_BEDROCK_ID,
    DEEPSEEK_R1_BEDROCK_ID
)

models = [
    (GPT_OSS_20B_BEDROCK_ID, "GPT OSS 20B"),
    (QWEN3_CODER_30B_BEDROCK_ID, "Qwen3 Coder 30B"),
    (QWEN3_32B_BEDROCK_ID, "Qwen3 32B"),
    (DEEPSEEK_R1_BEDROCK_ID, "DeepSeek R1")
]

test_file = Path("./dataset/test/aime_1983_p1.dfy")

for model_id, model_name in models:
    print(f"\n{'='*80}")
    print(f"Testing: {model_name}")
    print(f"{'='*80}")
    result = evaluate_single_file(test_file, "test", model_id, "bedrock")
    print(f"Result: {result['result']}\n")
