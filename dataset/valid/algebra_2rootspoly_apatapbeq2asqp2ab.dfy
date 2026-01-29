include "../definitions.dfy"
include "../library.dfy"

lemma algebra_2rootspoly_apatapbeq2asqp2ab(a: complex, b: complex)
  ensures Complex.mul(Complex.add(a,a), Complex.add(a,b)) == Complex.add(Complex.mul(Complex.of_real(2.0), Complex.mul(a,a)), Complex.mul(Complex.of_real(2.0), Complex.mul(a,b)))
{}