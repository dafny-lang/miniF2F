// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_apbmpcneq0_aeq0anbeq0anceq0(a: rat, b: rat, c: rat, m: real, n: real)
  requires 0.0 < m
  requires 0.0 < n
  requires m*m*m == 2.0
  requires n*n*n == 4.0
  requires a.to_real() + b.to_real()*m + c.to_real()*n == 0.0
  ensures a.to_real() == 0.0
  ensures b.to_real() == 0.0
  ensures c.to_real() == 0.0
{}