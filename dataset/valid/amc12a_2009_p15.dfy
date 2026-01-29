include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2009_p15(n: nat)
  requires 0 < n
  requires Complex.sum(set k {:trigger k as real}| 1 <= k <= n :: k, k => if k < 0 then Complex.zero() else Complex.mul(Complex.of_real(k as real), Complex.pow(Complex.i(), k))) == Complex.add(Complex.of_real(48.0), Complex.mul(Complex.of_real(49.0), Complex.i()))
  ensures n == 97
{}