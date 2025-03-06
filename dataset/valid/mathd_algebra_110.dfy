// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_110(q: complex, e: complex)
  requires q == Complex(2.0, -2.0)
  requires e == Complex(5.0, 5.0)
  ensures Complex.mul(q, e) == Complex.of_real(20.0)
{}