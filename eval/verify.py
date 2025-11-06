#!/usr/bin/env python3

import os
import subprocess
import json
import sys
from pathlib import Path
import re
from spec_extractor import DafnySpecExtractor, DafnySpecValidator

def setup_dafny_path():
    """Set up the DAFNY_PATH environment variable if not already set."""
    if 'DAFNY_PATH' in os.environ:
        return
    
    common_paths = [
        '/usr/local/bin/dafny',
        '/opt/dafny/dafny',
        os.path.expanduser('~/dafny/Scripts/dafny'),
        os.path.expanduser('~/dafny/dafny'),
        'dafny/Scripts/dafny',
    ]
    
    for path in common_paths:
        if os.path.exists(path):
            os.environ['DAFNY_PATH'] = path
            return
    
    raise RuntimeError("Dafny not found. Please set DAFNY_PATH environment variable.")

def _format_verification_errors(file_path, json_output, utils_file=None, lemmas_file=None):
    """
    Helper function to format verification errors from JSON output.
    Returns list of formatted error strings.
    
    Args:
        file_path: Path to the file being verified
        json_output: JSON output from Dafny verifier
        utils_file: Name of utils file to exclude from errors (e.g., 'utils.dfy')
        lemmas_file: Name of lemmas file to exclude from errors (e.g., 'lemmas.dfy')
    """
    utils_files = []
    if utils_file:
        utils_files.append(utils_file)
    if lemmas_file:
        utils_files.append(lemmas_file)
    
    errors = []
    with open(file_path, 'r') as f:
        content = f.read()
    
    for line in json_output.strip().split('\n'):
        if not line:
            continue
        try:
            obj = json.loads(line)
            if obj.get('type') == 'diagnostic':
                value = obj.get('value', {})
                severity = value.get('severity')
                location = value.get('location', {})
                filename = location.get('filename', '')
                message = value.get('defaultFormatMessage', '')
                range_info = location.get('range', {})
                start_pos = range_info.get('start', {}).get('pos', 0)
                end_pos = range_info.get('end', {}).get('pos', 0)
                
                # Skip errors from utility files
                if any(util_file in filename for util_file in utils_files):
                    continue
                
                if severity == 1:
                    line_start = content.rfind('\n', 0, start_pos) + 1
                    line_end = content.find('\n', end_pos)
                    if line_end == -1:
                        line_end = len(content)
                    error_line = content[line_start:line_end]
                    errors.append(f"{message}\nLine: {error_line}")
                elif severity == 2:
                    errors.append(message)
        except json.JSONDecodeError:
            continue
    
    return errors

def verify_file(file_path, utils_file=None, lemmas_file=None):
    """
    Verify a Dafny file and return True if verification passes.
    Allows warnings/errors in utility files.
    
    Args:
        file_path: Path to the Dafny file to verify
        utils_file: Name of utils file to exclude from errors
        lemmas_file: Name of lemmas file to exclude from errors
    """
    utils_files = []
    if utils_file:
        utils_files.append(utils_file)
    if lemmas_file:
        utils_files.append(lemmas_file)
    
    setup_dafny_path()
    
    dafny_cmd = os.environ.get('DAFNY_PATH', 'dafny')
    cmd = [dafny_cmd, 'verify', '--allow-warnings', '--json-output', file_path]
    result = subprocess.run(cmd, capture_output=True, text=True, timeout=60)
    status_result = None
    
    if result.stdout:
        for line in result.stdout.strip().split('\n'):
            if not line:
                continue
            try:
                obj = json.loads(line)
                if obj.get('type') == 'diagnostic':
                    value = obj.get('value', {})
                    severity = value.get('severity')
                    location = value.get('location', {})
                    filename = location.get('filename', '')
                    
                    # Skip errors from utility files
                    if any(util_file in filename for util_file in utils_files):
                        continue
                    
                    if severity == 1:
                        return False
                    if severity == 2:
                        return False
                        
                elif obj.get('type') == 'status':
                    value = obj.get('value', '')
                    match = re.search(r'(\d+) verified, (\d+) errors', value)
                    if match:
                        verified = int(match.group(1))
                        errors = int(match.group(2))
                        status_result = verified > 0 and errors == 0
            except json.JSONDecodeError:
                continue
    
    if status_result is None:
        return False
    else: 
        return status_result



def verify_with_spec_check(problem_file: str, solution_file: str, debug: bool = False, return_errors: bool = False, silent: bool = False, utils_file: str = None, lemmas_file: str = None, timeout: int = 60):
    """
    Verify a Dafny solution ensuring:
    1. Dafny verification passes (no errors)
    2. Method signatures and contracts are preserved from problem statement
    
    Args:
        problem_file: Path to the original problem file
        solution_file: Path to the solution file
        debug: Print debug information
        return_errors: If True, return (success, errors) tuple
        utils_file: Name of utils file to exclude from errors
        lemmas_file: Name of lemmas file to exclude from errors
        timeout: Timeout in seconds for verification
        
    Returns:
        bool if return_errors=False, (bool, str) if return_errors=True
    """
    utils_files = []
    if utils_file:
        utils_files.append(utils_file)
    if lemmas_file:
        utils_files.append(lemmas_file)
    
    setup_dafny_path()
    
    dafny_cmd = os.environ.get('DAFNY_PATH', 'dafny')
    cmd = [dafny_cmd, 'verify', '--allow-warnings', '--json-output', solution_file]
    try:
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=timeout)
    except subprocess.TimeoutExpired:
        if return_errors:
            return False, f"Verification timed out after {timeout} seconds"
        return False
    
    # Check for verification errors
    has_errors = False
    status_result = None
    
    if result.stdout:
        for line in result.stdout.strip().split('\n'):
            if not line:
                continue
            try:
                obj = json.loads(line)
                if obj.get('type') == 'diagnostic':
                    value = obj.get('value', {})
                    severity = value.get('severity')
                    location = value.get('location', {})
                    filename = location.get('filename', '')
                    
                    # Skip errors from utility files
                    if any(util_file in filename for util_file in utils_files):
                        continue
                    
                    if severity == 1:
                        has_errors = True
                    if severity == 2:
                        has_errors = True
                        
                elif obj.get('type') == 'status':
                    value = obj.get('value', '')
                    match = re.search(r'(\d+) verified, (\d+) errors', value)
                    if match:
                        verified = int(match.group(1))
                        error_count = int(match.group(2))
                        status_result = verified > 0 and error_count == 0
            except json.JSONDecodeError:
                continue
    
    if status_result is None or has_errors:
        if return_errors:
            error_list = _format_verification_errors(solution_file, result.stdout, utils_file, lemmas_file)
            return False, '\n\n'.join(error_list)
        return False
    
    with open(problem_file, 'r') as f:
        problem_spec = f.read()
    
    with open(solution_file, 'r') as f:
        solution_str = f.read()
    
    # Check for axiom usage
    if '{:axiom}' in solution_str:
        if return_errors:
            return False, "Use of {:axiom} attribute is not allowed"
        else:
            if not silent:
                print("Spec error: Use of {:axiom} attribute is not allowed")
            return False
    
    if debug:
        extractor = DafnySpecExtractor()
        problem_specs = extractor.extract_specifications(problem_spec)
        solution_specs = extractor.extract_specifications(solution_str)
        print("\n=== Problem Specs ===")
        print(json.dumps(problem_specs, indent=2))
        print("\n=== Solution Specs ===")
        print(json.dumps(solution_specs, indent=2))
    
    validator = DafnySpecValidator()
    validation_result = validator.validate_implementation(problem_spec, solution_str)
    
    if debug:
        print("\n=== Validation Result ===")
        print(json.dumps(validation_result, indent=2))
    
    if not validation_result['valid']:
        spec_errors = '\n'.join(validation_result['errors'])
        if return_errors:
            return False, f"Spec validation failed:\n{spec_errors}"
        else:
            for error in validation_result['errors']:
                print(f"Spec error: {error}")
            return False
    
    return (True, '') if return_errors else True


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python verify.py <file_path> [--with-spec [solution_file]] [--debug] [--with-errors]")
        sys.exit(1)
    
    file_path = sys.argv[1]
    use_spec_check = '--with-spec' in sys.argv
    debug = '--debug' in sys.argv
    with_errors = '--with-errors' in sys.argv
    
    if with_errors:
        success, errors = verify_with_spec_check(file_path, file_path, return_errors=True)
        if success:
            print(f"✓ {file_path} verified successfully")
            sys.exit(0)
        else:
            print(f"✗ {file_path} verification failed")
            print(errors)
            sys.exit(1)
    elif use_spec_check:
        spec_idx = sys.argv.index('--with-spec')
        solution_file = sys.argv[spec_idx + 1] if spec_idx + 1 < len(sys.argv) and not sys.argv[spec_idx + 1].startswith('--') else file_path
        if verify_with_spec_check(file_path, solution_file, debug):
            print(f"✓ Verified with spec check")
            sys.exit(0)
        else:
            print(f"✗ Verification or spec check failed")
            sys.exit(1)
    else:
        if verify_file(file_path):
            print(f"✓ {file_path} verified successfully")
            sys.exit(0)
        else:
            print(f"✗ {file_path} verification failed")
            sys.exit(1)