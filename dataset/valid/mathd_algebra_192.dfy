// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_192(q: complex, e: complex, d: complex)
  requires q == Complex(11.0, -5.0)
  requires e == Complex(11.0, 5.0)
  requires d == Complex(0.0, 2.0)
  ensures Complex.mul(Complex.mul(q, e), d) == Complex(0.0, 292.0)
{}