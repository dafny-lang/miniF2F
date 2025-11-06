#!/usr/bin/env python3
import json
from pathlib import Path
from collections import defaultdict

traces_dir = Path("traces")
baseline = 99
total_test = 244

models = [
    "deepseek.v3-v1:0",
    "openai.gpt-oss-120b-1:0",
    "openai.gpt-oss-20b-1:0",
    "qwen.qwen3-235b-a22b-2507-v1:0",
    "qwen.qwen3-32b-v1:0",
    "qwen.qwen3-coder-30b-a3b-v1:0",
    "qwen.qwen3-coder-480b-a35b-v1:0",
    "us.amazon.nova-premier-v1:0",
    "us.amazon.nova-pro-v1:0",
    "us.anthropic.claude-3-7-sonnet-20250219-v1:0",
    "us.anthropic.claude-haiku-4-5-20251001-v1:0",
    "us.anthropic.claude-opus-4-1-20250805-v1:0",
    "us.anthropic.claude-sonnet-4-20250514-v1:0",
    "us.anthropic.claude-sonnet-4-5-20250929-v1:0",
    "us.meta.llama4-maverick-17b-instruct-v1:0",
]

name_map = {
    "us.anthropic.claude-opus-4-1-20250805-v1:0": "Claude Opus 4.1",
    "us.anthropic.claude-3-7-sonnet-20250219-v1:0": "Claude 3.7 Sonnet",
    "us.anthropic.claude-sonnet-4-5-20250929-v1:0": "Claude Sonnet 4.5",
    "us.anthropic.claude-sonnet-4-20250514-v1:0": "Claude Sonnet 4",
    "us.anthropic.claude-opus-4-20250514-v1:0": "Claude Opus 4",
    "us.anthropic.claude-haiku-4-5-20251001-v1:0": "Claude Haiku 4.5",
    "us.amazon.nova-premier-v1:0": "Amazon Nova Premier",
    "us.amazon.nova-pro-v1:0": "Amazon Nova Pro",
    "deepseek.v3-v1:0": "DeepSeek V3.1",
    "us.deepseek.r1-v1:0": "DeepSeek R1",
    "us.meta.llama4-maverick-17b-instruct-v1:0": "Llama 4 Maverick 17B",
    "us.meta.llama3-3-70b-instruct-v1:0": "Llama 3.3 70B",
    "openai.gpt-oss-120b-1:0": "GPT-OSS 120B",
    "openai.gpt-oss-20b-1:0": "GPT-OSS 20B",
    "qwen.qwen3-235b-a22b-2507-v1:0": "Qwen 3 235B A22B",
    "qwen.qwen3-coder-480b-a35b-v1:0": "Qwen 3 Coder 480B A35B",
    "qwen.qwen3-32b-v1:0": "Qwen 3 32B",
    "qwen.qwen3-coder-30b-a3b-v1:0": "Qwen 3 Coder 30B",
}

results = []
for model in models:
    test_dir = traces_dir / model / "test"
    if not test_dir.exists():
        continue
    
    # Count problems attempted and solved at each attempt
    problems_attempted = set()
    solved_at_attempt = {}
    
    # A problem is attempted if there is any .dfy file with its name
    for dfy_file in test_dir.glob("*.dfy"):
        file_stem = dfy_file.stem
        if "_pass_" in file_stem:
            base_name = file_stem.rsplit("_pass_", 1)[0]
            problems_attempted.add(base_name)
    
    # Check which problems were solved and at which attempt
    for log_file in test_dir.glob("*_log.json"):
        try:
            with open(log_file) as f:
                data = json.load(f)
            
            log_name = log_file.stem
            problem_name = log_name.replace("_log", "")
            
            # Extract pass number from filename
            if "_pass_" in problem_name:
                base_name = problem_name.rsplit("_pass_", 1)[0]
                pass_num = int(problem_name.rsplit("_pass_", 1)[1])
            else:
                continue
            
            # Check if this pass was verified
            if isinstance(data, list) and len(data) > 0:
                last_entry = data[-1]
                if "verification" in last_entry:
                    if last_entry["verification"].get("verified") == True:
                        if base_name not in solved_at_attempt:
                            solved_at_attempt[base_name] = pass_num + 1
                        else:
                            solved_at_attempt[base_name] = min(solved_at_attempt[base_name], pass_num + 1)
        except:
            continue
    
    # Count Pass@1, Pass@2, Pass@4
    pass_at_1 = sum(1 for p, a in solved_at_attempt.items() if a == 1)
    pass_at_2 = sum(1 for p, a in solved_at_attempt.items() if a <= 2)
    pass_at_4 = sum(1 for p, a in solved_at_attempt.items() if a <= 4)
    
    # Extrapolate to 100%
    attempted = len(problems_attempted)
    total_non_baseline = total_test - baseline
    
    if attempted > 0:
        extrap_1 = (pass_at_1 / attempted) * total_non_baseline
        extrap_2 = (pass_at_2 / attempted) * total_non_baseline
        extrap_4 = (pass_at_4 / attempted) * total_non_baseline
    else:
        extrap_1 = extrap_2 = extrap_4 = 0
    
    results.append({
        "model": model,
        "attempted": attempted,
        "pass_at_1": extrap_1,
        "pass_at_2": extrap_2,
        "pass_at_4": extrap_4
    })

# Sort by Pass@4
results.sort(key=lambda x: x["pass_at_4"], reverse=True)

print("\\begin{table}[t]")
print("    \\centering")
print("    \\small")
print("\\begin{tabular}{@{}lrrrr@{}}")
print("\\toprule")
print("\\textbf{Model} & \\textbf{\\#Prob} & \\textbf{Pass@1\\protect\\footnotemark[1]} & \\textbf{Pass@2\\protect\\footnotemark[1]} & \\textbf{Pass@4\\protect\\footnotemark[1]} \\\\")
print("\\midrule")

anthropic = [r for r in results if "anthropic" in r["model"] and "opus-4-20250514" not in r["model"]]
amazon = [r for r in results if "amazon" in r["model"]]
deepseek = [r for r in results if "deepseek.v3" in r["model"]]
llama = [r for r in results if "llama4" in r["model"]]
gpt_oss = [r for r in results if "gpt-oss" in r["model"]]
qwen = [r for r in results if "qwen" in r["model"]]

def print_group(group):
    for r in group:
        name = name_map.get(r["model"], r["model"])
        pct_1 = ((baseline + r["pass_at_1"]) / total_test) * 100
        pct_2 = ((baseline + r["pass_at_2"]) / total_test) * 100
        pct_4 = ((baseline + r["pass_at_4"]) / total_test) * 100
        print(f"{name} & {r['attempted'] + baseline} & {pct_1:.1f} & {pct_2:.1f} & {pct_4:.1f} \\\\")

print_group(anthropic)
print("\\midrule")
print_group(amazon)
print("\\midrule")
print_group(deepseek)
print("\\midrule")
print_group(llama)
print("\\midrule")
print_group(gpt_oss)
print("\\midrule")
print_group(qwen)
print("\\midrule")
baseline_pct = (baseline / total_test) * 100
print(f"Dafny Verifier (No LLM) & {total_test} & {baseline_pct:.1f} & {baseline_pct:.1f} & {baseline_pct:.1f} \\\\")
print("\\bottomrule")
print("\\end{tabular}")
print("\\caption{Extrapolated evaluation results on miniF2F-test (\\%).}")
print("\\label{tab:minif2f-test-results}")
print("\\end{table}")
print("\\footnotetext[1]{Pass@N indicates projected pass rate with up to N generation attempts. \\#Prob includes 99 baseline problems solved by Dafny verifier.}")
