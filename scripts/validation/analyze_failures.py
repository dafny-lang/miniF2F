#!/usr/bin/env python3
import json
from pathlib import Path
from collections import defaultdict

traces_dir = Path(__file__).parent.parent.parent / "traces"
log_files = list(traces_dir.rglob("*_log.json"))

stats_by_model = defaultdict(lambda: {
    "spec_failures": 0,
    "verification_failures": 0,
    "total_attempts": 0,
    "verified": 0
})

for log_file in log_files:
    try:
        with open(log_file) as f:
            data = json.load(f)
        
        parts = log_file.parts
        model_idx = parts.index("traces") + 1
        model_name = parts[model_idx]
        
        if isinstance(data, list):
            for entry in data:
                if "verification" in entry:
                    stats_by_model[model_name]["total_attempts"] += 1
                    
                    verification = entry["verification"]
                    if verification.get("verified") == True:
                        stats_by_model[model_name]["verified"] += 1
                    elif verification.get("verified") == False:
                        errors = verification.get("errors", "")
                        if "Spec validation failed" in errors or "spec" in errors.lower():
                            stats_by_model[model_name]["spec_failures"] += 1
                        else:
                            stats_by_model[model_name]["verification_failures"] += 1
    except Exception as e:
        continue

print("="*100)
print(f"{'Model':<50} {'Total':>10} {'Verified':>10} {'Spec Fail':>10} {'Verif Fail':>10}")
print("="*100)

for model_name in sorted(stats_by_model.keys()):
    stats = stats_by_model[model_name]
    print(f"{model_name:<50} {stats['total_attempts']:>10} {stats['verified']:>10} "
          f"{stats['spec_failures']:>10} {stats['verification_failures']:>10}")

print("="*100)

# Summary
total_attempts = sum(s["total_attempts"] for s in stats_by_model.values())
total_verified = sum(s["verified"] for s in stats_by_model.values())
total_spec_fail = sum(s["spec_failures"] for s in stats_by_model.values())
total_verif_fail = sum(s["verification_failures"] for s in stats_by_model.values())

print(f"{'TOTAL':<50} {total_attempts:>10} {total_verified:>10} {total_spec_fail:>10} {total_verif_fail:>10}")
print(f"\nVerification Rate: {100*total_verified/total_attempts:.2f}%")
print(f"Spec Failure Rate: {100*total_spec_fail/total_attempts:.2f}%")
print(f"Verification Failure Rate: {100*total_verif_fail/total_attempts:.2f}%")
