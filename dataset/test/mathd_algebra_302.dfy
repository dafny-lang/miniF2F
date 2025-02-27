include "../utils.dfy"

lemma mathd_algebra_302()
  ensures Complex.pow(Complex.div(Complex(0.0, 1.0), Complex.of_real(2.0)), 2) == Complex.of_real(-1.0/4.0)
{}