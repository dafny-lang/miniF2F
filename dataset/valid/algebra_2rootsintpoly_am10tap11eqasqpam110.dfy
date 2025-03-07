// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_2rootsintpoly_am10tap11eqasqpam110(a: complex)
  ensures Complex.mul(Complex.sub(a, Complex.of_real(10.0)), Complex.add(a, Complex.of_real(11.0))) == Complex.sub(Complex.add(Complex.mul(a,a), a), Complex.of_real(110.0))
{}