// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_48(q: complex, e: complex)
  requires q == Complex(9.0, -4.0)
  requires e == Complex(-3.0, -4.0)
  ensures Complex.sub(q, e) == Complex.of_real(12.0)
{}