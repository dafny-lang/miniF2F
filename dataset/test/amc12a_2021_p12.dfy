include "../utils.dfy"

lemma amc12a_2021_p12(a: real, b: real, c: real, d: real, f: complex -> complex)
  requires forall z: complex :: f(z) == Complex.add(Complex.add(Complex.add(Complex.add(Complex.add(Complex.sub(Complex.pow(z, 6), Complex.mul(Complex.of_real(10.0), Complex.pow(z, 5))), Complex.mul(Complex.of_real(a), Complex.pow(z, 4))), Complex.mul(Complex.of_real(b), Complex.pow(z, 3))), Complex.mul(Complex.of_real(c), Complex.pow(z, 2))), Complex.mul(Complex.of_real(d), z)), Complex.of_real(16.0))
  requires forall z: complex | f(z) == Complex(0.0, 0.0) :: z.im == 0.0 && 0.0 < z.re && ((z.re).Floor as real) == z.re
  ensures b == 88.0
{}