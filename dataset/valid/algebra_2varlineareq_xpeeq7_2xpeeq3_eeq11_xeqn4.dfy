// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_2varlineareq_xpeeq7_2xpeeq3_eeq11_xeqn4(x: complex, e: complex) 
  requires Complex.add(x, e) == Complex.of_real(7.0)
  requires Complex.add(Complex.mul(Complex.of_real(2.0), x), e) == Complex.of_real(3.0)
  ensures e == Complex.of_real(11.0)
  ensures x == Complex.of_real(-4.0)
{}