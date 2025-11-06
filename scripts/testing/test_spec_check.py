#!/usr/bin/env python3

import random
import csv
import subprocess
import os
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
sys.path.insert(0, '../../eval')
from verify import verify_file, verify_with_spec_check, setup_dafny_path

def raw_dafny_verify(file_path):
    """Run raw dafny verify command and check for errors"""
    try:
        setup_dafny_path()
        dafny_cmd = os.environ.get('DAFNY_PATH', 'dafny')
        result = subprocess.run(
            [dafny_cmd, 'verify', '--allow-warnings', file_path],
            capture_output=True, text=True, timeout=60
        )
        # Check if output contains "0 errors"
        output = result.stdout + result.stderr
        return '0 errors' in output and result.returncode == 0
    except Exception:
        return False

def test_single_file(file_path):
    """Test a single file with all three methods"""
    try:
        raw_result = raw_dafny_verify(str(file_path))
        verify_result = verify_file(str(file_path))
        spec_result = verify_with_spec_check(str(file_path), str(file_path), debug=False)
        
        return {
            'file': file_path.name,
            'raw_dafny': raw_result,
            'verify': verify_result,
            'spec_check': spec_result,
            'all_consistent': raw_result == verify_result == spec_result,
            'error': None
        }
    except Exception as e:
        return {
            'file': file_path.name,
            'raw_dafny': False,
            'verify': False,
            'spec_check': False,
            'all_consistent': False,
            'error': str(e)
        }

def test_spec_check_parallel(num_files=None, max_workers=16, output_file='eval/verification_comparison.csv', dataset_dirs=None):
    """Test all three verification methods in parallel"""
    
    if dataset_dirs is None:
        dataset_dirs = ['dataset/valid']
    
    dfy_files = []
    for dir_path in dataset_dirs:
        dir_obj = Path(dir_path)
        dfy_files.extend([f for f in dir_obj.glob("*.dfy") if "modified" not in f.name])
    
    if num_files:
        test_files = random.sample(dfy_files, min(num_files, len(dfy_files)))
    else:
        test_files = dfy_files
    
    print(f"Testing {len(test_files)} files in parallel (workers={max_workers})\n")
    
    results = []
    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        futures = {executor.submit(test_single_file, f): f for f in test_files}
        
        for future in as_completed(futures):
            result = future.result()
            results.append(result)
            
            status = "✓" if result['all_consistent'] else "✗"
            print(f"{status} {result['file']}: raw={result['raw_dafny']}, verify={result['verify']}, spec={result['spec_check']}")
    
    # Save to CSV
    with open(output_file, 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['file', 'raw_dafny', 'verify', 'spec_check', 'all_consistent', 'error'])
        writer.writeheader()
        writer.writerows(results)
    
    print(f"\nResults saved to {output_file}")
    
    # Summary
    consistent = sum(1 for r in results if r['all_consistent'])
    inconsistent = sum(1 for r in results if not r['all_consistent'])
    errors = sum(1 for r in results if r['error'])
    
    print(f"\n{'='*60}")
    print(f"Results: {consistent} consistent, {inconsistent} inconsistent, {errors} errors")
    print(f"{'='*60}")
    
    if inconsistent > 0:
        print("\nInconsistencies found:")
        for r in results:
            if not r['all_consistent']:
                print(f"  {r['file']}: raw={r['raw_dafny']}, verify={r['verify']}, spec={r['spec_check']}")

if __name__ == "__main__":
    import sys
    
    # Run on all files in valid and test
    if len(sys.argv) > 1 and sys.argv[1] == '--all':
        test_spec_check_parallel(
            num_files=None, 
            max_workers=16, 
            output_file='eval/verification_comparison_all.csv',
            dataset_dirs=['dataset/valid', 'dataset/test']
        )
    else:
        # Default: 100 random files from valid
        test_spec_check_parallel(100, 16, 'eval/verification_comparison.csv')
