// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12b_2021_p18(z: complex)
  requires 12.0 * Complex.norm_sq(z) == 2.0 * Complex.norm_sq(Complex.add(z, Complex.of_real(2.0))) + Complex.norm_sq(Complex.add(Complex.mul(z, z), Complex.one())) + 31.0
  ensures Complex.add(z, Complex.div(Complex.of_real(6.0), z)) == Complex.of_real(-2.0)
{}