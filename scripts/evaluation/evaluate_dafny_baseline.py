#!/usr/bin/env python3
import sys
sys.path.insert(0, '../../eval')
from results import run_dafny_baseline

if __name__ == "__main__":
    run_dafny_baseline("test", max_workers=64)
    run_dafny_baseline("valid", max_workers=64)
