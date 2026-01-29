include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2021_p25(N: nat, f: nat -> real)
  requires forall n | 0 < n :: f(n) == (|divisors(n)| as real) / Real.rpow(n as real, 1.0/(3 as real))
  requires forall n | 0 < n && n != N :: f(n) < f(N)
  ensures Int.sum(range(|digits(10, N)|), k => if 0 <= k < |digits(10, N)| then digits(10, N)[k] else 0) == 9
{}