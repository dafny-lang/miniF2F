// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_313(v: complex, i: complex, z: complex)
  requires v == Complex.mul(i, z)
  requires v == Complex.add(Complex.of_real(1.0), Complex.i())
  requires z == Complex.sub(Complex.of_real(2.0), Complex.i())
  ensures i == Complex.add(Complex.of_real(1.0/5.0), Complex.mul(Complex.of_real(3.0/5.0), Complex.i()))
{}