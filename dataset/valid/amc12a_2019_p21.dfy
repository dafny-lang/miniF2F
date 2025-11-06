// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2019_p21(z: complex)
  requires z == Complex.div(Complex.add(Complex.one(), Complex.i()), Complex.of_real(sqrt(2.0)))
  ensures Complex.mul(Complex.sum(set k | 1 <= k <= 12 :: k, k => Complex.pow(z, k*k)), Complex.sum(set k | 1 <= k <= 12 :: k, k => Complex.div(Complex.one(), Complex.pow(z, k*k)))) == Complex.of_real(36.0)
{}