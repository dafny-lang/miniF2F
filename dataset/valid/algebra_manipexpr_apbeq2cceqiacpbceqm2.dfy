include "../utils.dfy"

lemma algebra_manipexpr_apbeq2cceqiacpbceqm2(a: complex, b: complex, c: complex)
  requires Complex.add(a, b) == Complex.mul(Complex.of_real(2.0), c)
  requires c == Complex(0.0, 1.0)
  ensures Complex.add(Complex.mul(a, c), Complex.mul(b, c)) == Complex.of_real(-2.0)
{}