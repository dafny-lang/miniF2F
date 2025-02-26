include "../utils.dfy"

lemma imo_1968_p5_1(a: real, f: real -> real)
  requires 0.0 < a
  requires forall x: real :: f(x+a) == 1.0 / (2.0+sqrt(f(x)- f(x)*f(x)))
  ensures exists b: real | b > 0.0 :: (forall x :: f(x+b) == f(x))
{}