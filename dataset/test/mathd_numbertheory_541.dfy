// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_541(m: nat, n: nat)
  requires 1 < m
  requires 1 < n
  requires m*n == 2005
  ensures m + n == 406
{}