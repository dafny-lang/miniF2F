include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_182(y: complex)
  ensures Complex.mul(Complex.of_real(7.0), Complex.add(Complex.mul(Complex.of_real(3.0), y), Complex.of_real(2.0))) == Complex.add(Complex.mul(Complex.of_real(21.0), y), Complex.of_real(14.0))
{}