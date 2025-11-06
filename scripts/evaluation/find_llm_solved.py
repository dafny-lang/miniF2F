#!/usr/bin/env python3
import json
from pathlib import Path
from collections import defaultdict

traces_dir = Path("/home/ubuntu/miniF2F/traces")
log_files = list(traces_dir.rglob("*_log.json"))

llm_solved_by_model = defaultdict(list)

for log_file in log_files:
    try:
        with open(log_file) as f:
            data = json.load(f)
            
        if isinstance(data, list) and len(data) > 0:
            last_entry = data[-1]
            if "verification" in last_entry:
                verification = last_entry["verification"]
                if verification.get("verified") == True:
                    log_name = log_file.stem
                    
                    parts = log_file.parts
                    model_idx = parts.index("traces") + 1
                    model_name = parts[model_idx]
                    
                    problem_name = log_name.replace("_log", "").rsplit("_pass_", 1)[0]
                    
                    if "/test/" in str(log_file):
                        dataset_type = "test"
                        problem_path = f"dataset/test/{problem_name}.dfy"
                    elif "/valid/" in str(log_file):
                        dataset_type = "valid"
                        problem_path = f"dataset/valid/{problem_name}.dfy"
                    else:
                        continue
                    
                    pass_parts = log_name.split("_pass_")
                    if len(pass_parts) == 2:
                        pass_num = pass_parts[1].replace("_log", "")
                    else:
                        pass_num = "unknown"
                    
                    ec_num = last_entry.get("ec", "unknown")
                    
                    solution_dir = log_file.parent
                    solution_file = solution_dir / f"{problem_name}_pass_{pass_num}_ec_{ec_num}.dfy"
                    
                    llm_solved_by_model[model_name].append({
                        "problem_path": problem_path,
                        "problem_name": problem_name,
                        "dataset_type": dataset_type,
                        "pass": pass_num,
                        "ec": ec_num,
                        "solution": str(solution_file) if solution_file.exists() else None
                    })
    except Exception as e:
        continue

for model_name in sorted(llm_solved_by_model.keys()):
    problems = llm_solved_by_model[model_name]
    
    seen = set()
    unique_problems = []
    for item in problems:
        if item["problem_name"] not in seen:
            seen.add(item["problem_name"])
            unique_problems.append(item)
    
    unique_problems.sort(key=lambda x: (x["dataset_type"], x["problem_name"]))
    
    print(f"\n{'='*80}")
    print(f"Model: {model_name}")
    print(f"{'='*80}")
    print(f"Found {len(unique_problems)} problems solved by LLM:\n")
    
    for item in unique_problems:
        problem_abs_path = f"/home/ubuntu/miniF2F/{item['problem_path']}"
        print(f"Problem: {item['problem_name']}")
        print(f"  Original: {problem_abs_path}")
        
        if item["solution"]:
            print(f"  Solution: {item['solution']}:1:1")
        
        print(f"  Pass: {item['pass']}, Error Corrections: {item['ec']}")
        print()
