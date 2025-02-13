include "../utils.dfy"

lemma amc12a_2016_p3(f: real -> real -> real)
  requires forall x, y | y != 0.0 :: f(x)(y) == x - y * x / y
  ensures f(3.0 / 8.0)(-(2.0 / 5.0)) == -(1.0 / 40.0)
{}