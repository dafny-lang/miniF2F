include "../definitions.dfy"
include "../library.dfy"

lemma algebra_manipexpr_2erprsqpesqeqnrpnesq(e: complex, r: complex)
  ensures Complex.add(Complex.mul(Complex.of_real(2.0), Complex.mul(e, r)), Complex.add(Complex.mul(e,e), Complex.mul(r,r))) == 
          Complex.mul(Complex.add(r.neg(), e.neg()), Complex.add(r.neg(), e.neg()))
{}