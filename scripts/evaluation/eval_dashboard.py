#!/usr/bin/env python3
import json
import time
import os
from pathlib import Path
from collections import defaultdict

def clear_screen():
    try:
        os.system('clear')
    except:
        pass

def get_stats():
    traces_dir = Path("/home/ubuntu/miniF2F/traces")
    results_dir = Path("/home/ubuntu/miniF2F/results")
    dataset_test = Path("/home/ubuntu/miniF2F/dataset/test")
    dataset_valid = Path("/home/ubuntu/miniF2F/dataset/valid")

    total_test_problems = len(list(dataset_test.glob("*.dfy")))
    total_valid_problems = len(list(dataset_valid.glob("*.dfy")))
    
    # Load baseline
    test_baseline = 0
    valid_baseline = 0
    
    baseline_test_file = results_dir / "dafny" / "test" / "results.json"
    if baseline_test_file.exists():
        try:
            with open(baseline_test_file) as f:
                results = json.load(f)
            test_baseline = sum(1 for item in results if item.get("attempt") == 1 and item.get("status") == "verified")
        except:
            pass
    
    baseline_valid_file = results_dir / "dafny" / "valid" / "results.json"
    if baseline_valid_file.exists():
        try:
            with open(baseline_valid_file) as f:
                results = json.load(f)
            valid_baseline = sum(1 for item in results if item.get("attempt") == 1 and item.get("status") == "verified")
        except:
            pass

    models = sorted([d.name for d in traces_dir.iterdir() if d.is_dir()])
    
    stats = []
    for model_name in models:
        model_dir = traces_dir / model_name
        
        test_problems = set()
        test_solved = set()
        valid_problems = set()
        valid_solved = set()
        
        # Scan all files to find problems in progress
        for file in model_dir.rglob("*.dfy"):
            file_stem = file.stem
            # Remove pass and ec suffixes to get problem name
            problem_name = file_stem.rsplit("_pass_", 1)[0]
            
            if "/test/" in str(file):
                test_problems.add(problem_name)
            elif "/valid/" in str(file):
                valid_problems.add(problem_name)
        
        # Check log files for solved problems
        for log_file in model_dir.rglob("*_log.json"):
            try:
                with open(log_file) as f:
                    data = json.load(f)
                
                log_name = log_file.stem
                problem_name = log_name.replace("_log", "").rsplit("_pass_", 1)[0]
                
                if isinstance(data, list) and len(data) > 0:
                    last_entry = data[-1]
                    if "verification" in last_entry:
                        if last_entry["verification"].get("verified") == True:
                            if "/test/" in str(log_file):
                                test_solved.add(problem_name)
                            elif "/valid/" in str(log_file):
                                valid_solved.add(problem_name)
            except:
                continue
        
        stats.append({
            "model": model_name,
            "test_in_progress": len(test_problems),
            "test_solved": len(test_solved),
            "test_total": total_test_problems - test_baseline,
            "valid_in_progress": len(valid_problems),
            "valid_solved": len(valid_solved),
            "valid_total": total_valid_problems - valid_baseline
        })
    
    return stats, test_baseline, valid_baseline

def display_dashboard():
    while True:
        clear_screen()
        stats, test_baseline, valid_baseline = get_stats()
        
        print(f"{'='*120}")
        print(f"MINIF2F EVALUATION DASHBOARD - {time.strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"Baseline solved: Test={test_baseline}/244, Valid={valid_baseline}/243")
        print(f"{'='*120}")
        print(f"{'Model':<50} {'Test Solved':>15} {'Test Progress':>18} {'Valid Solved':>15} {'Valid Progress':>18}")
        print(f"{'='*120}")
        
        for s in stats:
            test_progress_pct = (s["test_in_progress"] / s["test_total"] * 100) if s["test_total"] > 0 else 0
            valid_progress_pct = (s["valid_in_progress"] / s["valid_total"] * 100) if s["valid_total"] > 0 else 0
            
            print(f"{s['model']:<50} "
                  f"{s['test_solved']:>3}/{s['test_total']:<3} ({s['test_solved']/s['test_total']*100:5.1f}%)  "
                  f"{s['test_in_progress']:>3}/{s['test_total']:<3} ({test_progress_pct:5.1f}%)  "
                  f"{s['valid_solved']:>3}/{s['valid_total']:<3} ({s['valid_solved']/s['valid_total']*100:5.1f}%)  "
                  f"{s['valid_in_progress']:>3}/{s['valid_total']:<3} ({valid_progress_pct:5.1f}%)")
        
        print(f"{'='*120}")
        print(f"Refreshing in 10 seconds... (Press Ctrl+C to exit)")
        print(f"{'='*120}")
        
        time.sleep(10)

if __name__ == "__main__":
    try:
        display_dashboard()
    except KeyboardInterrupt:
        print("\nDashboard stopped.")
