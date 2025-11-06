# TODO

1. **Implement parallelized verification for evaluation stability**
   - Add support for multiple verification attempts to handle time-out non-determinism verification behavior
   - Improve stability and reproducibility of evaluation results

2. **Complete all evaluations**
   - Finish all model evaluations on `/test` dataset
   - Run full evaluations on `/valid` dataset

3. **Fix dataset issues**
   - Remedy division by zero errors (and similar) in dataset files
   - Address brittleness warnings caused by triggers within dataset files

4. **Update summary.py to support new results format**
   - Migrate `eval/summary.py` to parse the updated error correction tracking format
   - Ensure compatibility with new pass-based logging structure
