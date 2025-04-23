// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2020_p13(a: nat, b: nat, c: nat, n: real)
  requires n >= 0.0
  requires n != 1.0
  requires 1 < a
  requires 1 < b
  requires 1 < c
  requires Real.rpow(n*Real.rpow(n*Real.rpow(n, 1.0/(c as real)), 1.0/(b as real)), 1.0/(a as real)) == Real.rpow(Real.rpow(n, 25.0), 1.0/(36 as real))
  ensures b == 3
{}