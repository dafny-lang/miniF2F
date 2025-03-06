// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_amgm_sqrtxymulxmyeqxpy_xpygeq4(x: real, y: real)
  requires 0.0 < x
  requires 0.0 < y
  requires y <= x
  requires sqrt(x*y*(x-y)) == x+y
  ensures x + y >= 4.0
{}