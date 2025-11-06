#!/usr/bin/env python3
import sys
sys.path.insert(0, '../../eval')

from results import evaluate_single_file, write_test_results, SONNET_4_BEDROCK_MODEL_ID
from pathlib import Path

if __name__ == '__main__':
    test_file = Path("dataset/test/aime_1983_p1.dfy")
    result = evaluate_single_file(test_file, "test", SONNET_4_BEDROCK_MODEL_ID, "bedrock")
    print(f"\n{result}")
    
    results_path = Path("results/single_test/results.json")
    write_test_results([result], results_path)
    print(f"\nSaved to {results_path}")
