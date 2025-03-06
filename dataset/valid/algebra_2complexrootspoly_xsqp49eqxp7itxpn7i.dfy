// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_2complexrootspoly_xsqp49eqxp7itxpn7i(x: complex)
  ensures Complex.add(Complex.mul(x, x), Complex.of_real(49.0)) == Complex.mul(Complex.add(x, Complex(0.0, 7.0)), Complex.add(x, Complex(0.0, -7.0)))
{}