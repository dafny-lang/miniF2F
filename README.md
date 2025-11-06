# miniF2F - Dafny Formal Verification Benchmark

This repository contains a Dafny version of the miniF2F benchmark consisting of mathematical problems from competitions (AIME, AMC, IMO) along with automated evaluation infrastructure. It is maintained by Mantas Bakšys and Stefan Zetzsche.

## Overview

miniF2F challenges LLMs to complete formal proofs in Dafny by filling in empty lemma bodies (`{}`) while preserving the original specifications. The benchmark tests models' abilities in:

- **Formal verification**: Writing proofs that satisfy Dafny's verifier
- **Mathematical reasoning**: Solving problems from algebra, number theory, and induction
- **Proof construction**: Using assertions, calc statements, and helper lemmas
- **Specification adherence**: Maintaining exact preconditions and postconditions

## Dataset Structure

```
dataset/
├── test/          # 244 test problems (evaluation set)
├── valid/         # 153 validation problems (development set)
├── utils.dfy      # Core mathematical definitions and axioms
└── lemmas.dfy     # Helper lemmas for proofs
```

## Example Problem

**Problem**: AIME 1983 Problem 1
```dafny
lemma aime_1983_p1(x: nat, y: nat, z: nat, w: nat)
  requires 1 < x
  requires 1 < y
  requires 1 < z
  requires 0 <= w
  requires log(x as real) != 0.0
  requires log(y as real) != 0.0
  requires log((x as real)*(y as real)*(z as real)) != 0.0
  requires log(z as real) != 0.0
  requires log(w as real)/log(x as real) == 24.0
  requires log(w as real)/log(y as real) == 40.0
  requires log(w as real)/log((x as real)*(y as real)*(z as real)) == 12.0
  ensures log(w as real)/log(z as real) == 60.0
{}
```

The task is to replace `{}` with a complete, verifying proof body.

## Evaluation Framework

### Core Components

- **`eval/verify.py`**: Dafny verification wrapper with spec checking
- **`eval/spec_extractor.py`**: Validates that solutions preserve original specifications
- **`eval/results.py`**: Multi-model evaluation with error correction
- **`scripts/`**: Testing utilities for different models and configurations

### Evaluation Modes

1. **Single-shot**: Model generates proof in one attempt
2. **Error correction**: Model receives verification errors and iterates (default up to 3 corrections)
   - **Conversational**: Maintains conversation history across attempts
   - **New conversation**: Starts fresh conversation for each error correction

### Supported Models

The framework supports evaluation via:

- **AWS Bedrock**: Claude (Sonnet 4, Opus 4), Nova Premier, GPT-OSS, Qwen3, DeepSeek R1
- **Ollama**: Local model inference (deprecated)

## Installation

### Prerequisites

1. **Dafny 4.11.0**: Install the Dafny verifier

   1. Download Dafny 4.11.0 from GitHub.
   2. Follow Dafny installations to install Z3 and build Dafny.
   3. Set the `DAFNY_PATH` variable
   ```bash
   export DAFNY_PATH=path/to/dafny
   
   # Verify installation
   $DAFNY_PATH --version  # Should output: 4.11.0
   ```

2. **AWS Bedrock API Access**: Configure AWS credentials
   ```bash
   # Add to ~/.bashrc or ~/.zshrc for permanent configuration
   export AWS_ACCESS_KEY_ID=your-access-key-id
   export AWS_SECRET_ACCESS_KEY=your-secret-access-key
   export AWS_DEFAULT_REGION=us-east-2
   
   # Reload shell configuration
   source ~/.bashrc  # or source ~/.zshrc
   ```
   
   Note: You need AWS Bedrock model access enabled for your account. Request access through AWS Console under Bedrock > Model access.

3. **Python dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

### Requirements

- Python 3.8+
- Dafny 4.11.0 
- AWS Bedrock API access
- boto3, botocore, tqdm

## Usage

### Testing the Dafny Verifier
```bash
# Basic verification
python eval/verify.py dataset/test/aime_1983_p1.dfy

# With specification adherence checking
python eval/verify.py dataset/test/aime_1983_p1.dfy --with-spec

# With error feedback
python eval/verify.py dataset/test/aime_1983_p1.dfy --with-errors
```

### Test Single Problem with a Model

```bash
# Test a specific model on one problem
python scripts/testing/test_single_problem.py
```

### Run Evaluations on All Models

```bash
# Evaluate all supported models on test and validation sets
python scripts/evaluation/evaluate_all_models.py

# Debug mode: test with only 1 problem per model
python scripts/evaluation/evaluate_all_models.py --debug

# Evaluate specific models
python scripts/testing/test_models.py
```

### Run Dafny verifier baseline

```python
from eval.results import run_dafny_baseline

# Test Dafny verifier on all problems (no LLM)
run_dafny_baseline("test", max_workers=8)
run_dafny_baseline("valid", max_workers=8)
```

## Configuration

Key parameters in `eval/results.py`:

- **N**: Number of generation attempts (default: 2)
- **E**: Maximum error corrections per attempt (default: 3)
- **TEMPERATURE**: Sampling temperature (default: 0.5)
- **MAX_GEN_LEN**: Maximum generation tokens (default: 8192)
- **TIMEOUT**: Verification timeout in seconds (default: 60)

## Results

Results are stored in `results/{model_id}/{test|valid}/results.json`:

```json
[
  {
    "id": "dataset/test/aime_1983_p1.dfy",
    "result": "verified at attempt 1, error corrections: 0",
    "status": "verified",
    "attempt": 1,
    "error_corrections": 0
  }
]
```

**Note**: Current evaluation results are in `traces.zip`. Extract with `unzip traces.zip`.

### Analyzing Results

```bash
# Generate summary statistics
python eval/summary.py

# Compute pass@N metrics to latex table (for paper)
python scripts/evaluation/compute_pass_at_n.py

# Find problems solved by LLMs but not baseline
python scripts/evaluation/find_llm_solved.py

# Analyze failure patterns
python scripts/validation/analyze_failures.py
```



