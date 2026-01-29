include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2010_p11(x: real, b: real)
  requires 0.0 < b 
  requires Real.rpow(7.0, x+7.0) == Real.rpow(8.0, x)
  requires x == logb(b, Real.rpow(7.0, 7.0))
  ensures b == 8.0/7.0
{}