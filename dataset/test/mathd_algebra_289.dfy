// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_289(k: nat, t: nat, m: nat, n: nat)
  requires prime(m)
  requires prime(n)
  requires t < k
  requires k*k - m*k + n == 0
  requires t*t - m*t + n == 0
  ensures Int.pow(m,n) + Int.pow(n,m) + Int.pow(k,t) + Int.pow(t,k) == 20
{}