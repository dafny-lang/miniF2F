// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1984_p6(a: nat, b: nat, c: nat, d: nat, k: nat, m: nat)
  requires 0 < a
  requires 0 < b
  requires 0 < c
  requires 0 < d
  requires a % 2 == 1
  requires b % 2 == 1
  requires c % 2 == 1
  requires d % 2 == 1
  requires a < b < c < d
  requires a*d == b*c
  requires a+d == Int.pow(2, k)
  requires b+c == Int.pow(2, m)
  ensures a == 1
{}