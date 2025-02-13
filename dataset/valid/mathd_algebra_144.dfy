include "../utils.dfy"

lemma mathd_algebra_144(a: nat, b: nat, c: nat, d: nat)
  requires 0 < a 
  requires 0 < b
  requires 0 < c
  requires 0 < d
  requires c - b == d
  requires b - a == d
  requires a + b + c == 60
  requires a + b > c
  ensures d < 10
{}