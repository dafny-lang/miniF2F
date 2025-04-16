// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2021_p22(a: real, b: real, c: real, f: real -> real)
  requires forall x :: f(x) == x*x*x + a*x*x + b*x + c
  requires (iset x | f(x) == 0.0 :: x) == iset{cos(2.0*pi/7.0), cos(4.0*pi/7.0), cos(6.0*pi/7.0)}
  ensures a*b*c == 1.0/32.0
{}