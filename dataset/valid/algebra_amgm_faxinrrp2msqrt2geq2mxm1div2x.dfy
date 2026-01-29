include "../definitions.dfy"
include "../library.dfy"

lemma algebra_amgm_faxinrrp2msqrt2geq2mxm1div2x(x: real)
  requires x > 0.0
  ensures 2.0 - sqrt(2.0) >= 2.0 - x - 1.0/(2.0*x)
{}