#!/usr/bin/env python3
"""Track and display verification results from traces_updated logs."""

import json
import os
from pathlib import Path
from collections import defaultdict

def load_trace_logs(traces_dir):
    """Load results from trace log files."""
    results = {}
    
    if not os.path.exists(traces_dir):
        return results
    
    for model_dir in Path(traces_dir).iterdir():
        if not model_dir.is_dir():
            continue
        
        model_name = model_dir.name
        results[model_name] = {'test': {}, 'valid': {}}
        
        for dataset_type in ['test', 'valid']:
            dataset_dir = model_dir / dataset_type
            if not dataset_dir.exists():
                continue
            
            # Group log files by problem (without pass number)
            problems = defaultdict(list)
            for log_file in dataset_dir.glob('*_log.json'):
                # Extract problem name and pass number
                # Format: problemname_pass_N_log.json
                stem = log_file.stem  # removes .json
                parts = stem.split('_pass_')
                if len(parts) == 2:
                    problem_name = parts[0]
                    pass_num = int(parts[1].split('_')[0])
                    problems[problem_name].append((pass_num, log_file))
            
            # Process each problem
            for problem_name, log_files in problems.items():
                verified_pass0 = False
                verified_other = False
                
                for pass_num, log_file in log_files:
                    with open(log_file) as f:
                        log_data = json.load(f)
                    
                    # Check if any attempt in this pass was verified
                    for entry in log_data:
                        if entry.get('verification', {}).get('verified', False):
                            if pass_num == 0:
                                verified_pass0 = True
                            else:
                                verified_other = True
                            break
                
                results[model_name][dataset_type][problem_name] = {
                    'pass0': verified_pass0,
                    'other': verified_other
                }
    
    return results

def display_tracker(results):
    """Display a formatted tracker of results."""
    print("\n" + "="*80)
    print("miniF2F Traces Verification Tracker")
    print("="*80 + "\n")
    
    if not results:
        print("No traces found in traces_updated/ directory")
        return
    
    # Sort models by name
    sorted_models = sorted(results.keys())
    
    for model_name in sorted_models:
        print(f"\n📊 {model_name}")
        print("-" * 80)
        
        model_data = results[model_name]
        
        for dataset_type in ['valid', 'test']:
            data = model_data.get(dataset_type, {})
            if data:
                # Count problems verified in pass0 vs other passes
                pass0_only = sum(1 for v in data.values() if v['pass0'] and not v['other'])
                other_only = sum(1 for v in data.values() if v['other'] and not v['pass0'])
                both = sum(1 for v in data.values() if v['pass0'] and v['other'])
                total_verified = pass0_only + other_only + both
                total = len(data)
                percentage = (total_verified / total * 100) if total > 0 else 0
                
                bar_length = 40
                filled = int(bar_length * total_verified / total) if total > 0 else 0
                bar = '█' * filled + '░' * (bar_length - filled)
                
                print(f"  {dataset_type.upper():5s}: [{bar}] {total_verified:3d}/{total:3d} ({percentage:5.1f}%)")
                print(f"         Pass 0 (verifier): {pass0_only:3d}  |  LLM passes: {other_only:3d}  |  Both: {both:3d}")
        
        print()
    
    # Summary
    print("="*80)
    print("Summary")
    print("="*80)
    print(f"{'Model':<50} {'Total':<12} {'Pass0':<8} {'LLM':<8}")
    print("-" * 80)
    
    for model_name in sorted_models:
        valid_data = results[model_name].get('valid', {})
        test_data = results[model_name].get('test', {})
        all_data = {**valid_data, **test_data}
        
        pass0_count = sum(1 for v in all_data.values() if v['pass0'])
        llm_count = sum(1 for v in all_data.values() if v['other'])
        total_verified = sum(1 for v in all_data.values() if v['pass0'] or v['other'])
        total = len(all_data)
        
        if total > 0:
            print(f"{model_name:<50} {total_verified:3d}/{total:3d} ({total_verified/total*100:4.1f}%)  {pass0_count:3d}      {llm_count:3d}")

if __name__ == '__main__':
    import sys
    traces_dir = Path(__file__).parent.parent.parent / 'traces_updated'
    
    # Allow specifying traces directory as argument
    if len(sys.argv) > 1:
        traces_dir = Path(sys.argv[1])
    
    results = load_trace_logs(traces_dir)
    display_tracker(results)
