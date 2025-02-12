include "../utils.dfy"

import opened Utils

lemma mathd_algebra_289(k: nat, t: nat, m: nat, n: nat)
  requires prime(m)
  requires prime(n)
  requires t < k
  requires k*k - m*k + n == 0
  requires t*t - m*t + n == 0
  ensures pow(m,n) + pow(n,m) + pow(k,t) + pow(t,k) == 20
{}