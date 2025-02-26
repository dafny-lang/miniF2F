include "../utils.dfy"

lemma mathd_algebra_184(a: real, b: real)
  requires a > 0.0
  requires b > 0.0
  requires a*a == 6.0*b
  requires a*a == 54.0*b
  ensures a == 3.0*sqrt(2.0)
{}