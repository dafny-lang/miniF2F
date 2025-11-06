// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_manipexpr_apbeq2cceqiacpbceqm2(a: complex, b: complex, c: complex)
  requires Complex.add(a, b) == Complex.mul(Complex.of_real(2.0), c)
  requires c == Complex.i()
  ensures Complex.add(Complex.mul(a, c), Complex.mul(b, c)) == Complex.of_real(-2.0)
{}