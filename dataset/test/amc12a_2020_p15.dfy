include "../utils.dfy"

lemma amc12a_2020_p15(a: complex, b: complex)
  requires Complex.sub(Complex.pow(a, 3), Complex.of_real(8.0)) == Complex.zero
  requires Complex.add(Complex.sub(Complex.sub(Complex.pow(b, 3), Complex.mul(Complex.of_real(8.0), Complex.pow(b, 2))), Complex.mul(Complex.of_real(8.0), b)), Complex.of_real(64.0)) == Complex.zero
  ensures Complex.abs(Complex.sub(a, b)) <= 2.0 * sqrt(21.0)
{}