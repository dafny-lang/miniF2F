// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_sqineq_2at2pclta2c2p41pc(a: real, c: real)
  ensures 2.0 * a * (2.0 + c) <= a*a + c*c + 4.0*(1.0 + c)
{}