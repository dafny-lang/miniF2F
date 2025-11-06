#!/usr/bin/env python3
"""Re-verify all solutions in traces folder and update logs with current verification status"""
import json
import subprocess
from pathlib import Path
from concurrent.futures import ProcessPoolExecutor, as_completed
from tqdm import tqdm

def verify_file(dfy_path):
    """Run Dafny verification on a file"""
    try:
        result = subprocess.run(
            ['python3', 'eval/verify.py', str(dfy_path)],
            capture_output=True,
            text=True,
            timeout=30
        )
        verified = 'verification failed' not in result.stdout.lower()
        errors = result.stdout if not verified else None
        return str(dfy_path), verified, errors
    except Exception as e:
        return str(dfy_path), False, str(e)

def update_trace_logs(traces_dir, max_workers=8):
    """Update all log files with current verification status"""
    traces_path = Path(traces_dir)
    models = sorted([d.name for d in traces_path.iterdir() if d.is_dir()])
    
    for model in models:
        print(f"\n{'='*80}")
        print(f"Processing model: {model}")
        print(f"{'='*80}")
        
        for dataset in ["test", "valid"]:
            trace_path = traces_path / model / dataset
            if not trace_path.exists():
                continue
            
            log_files = list(trace_path.glob("*_log.json"))
            print(f"\n{dataset}: {len(log_files)} problems")
            
            # Collect all files to verify
            verify_tasks = []
            for log_file in log_files:
                with open(log_file) as f:
                    trace_data = json.load(f)
                
                for entry in trace_data:
                    ec = entry.get("ec", 0)
                    parts = log_file.stem.split("_pass_")
                    problem_name = parts[0]
                    pass_num = int(parts[1].split("_")[0])
                    dfy_file = trace_path / f"{problem_name}_pass_{pass_num}_ec_{ec}.dfy"
                    
                    if dfy_file.exists():
                        verify_tasks.append((log_file, dfy_file, ec))
            
            # Verify in parallel
            results = {}
            with ProcessPoolExecutor(max_workers=max_workers) as executor:
                futures = {executor.submit(verify_file, dfy): (log, dfy, ec) 
                          for log, dfy, ec in verify_tasks}
                
                for future in tqdm(as_completed(futures), total=len(futures), desc=f"{dataset}"):
                    dfy_path, verified, errors = future.result()
                    results[dfy_path] = (verified, errors)
            
            # Update logs
            for log_file in log_files:
                with open(log_file) as f:
                    trace_data = json.load(f)
                
                updated = False
                for entry in trace_data:
                    ec = entry.get("ec", 0)
                    parts = log_file.stem.split("_pass_")
                    problem_name = parts[0]
                    pass_num = int(parts[1].split("_")[0])
                    dfy_file = trace_path / f"{problem_name}_pass_{pass_num}_ec_{ec}.dfy"
                    
                    if str(dfy_file) in results:
                        verified, errors = results[str(dfy_file)]
                        
                        if "verification" not in entry:
                            entry["verification"] = {}
                        
                        old_status = entry["verification"].get("verified", None)
                        entry["verification"]["verified"] = verified
                        entry["verification"]["errors"] = errors
                        
                        if old_status != verified:
                            updated = True
                
                if updated:
                    with open(log_file, 'w') as f:
                        json.dump(trace_data, f, indent=2)

if __name__ == "__main__":
    update_trace_logs("traces_initial", max_workers=64)
    print("\n✓ Verification complete!")
