include "../definitions.dfy"
include "../library.dfy"

lemma algebra_sqineq_4bap1lt4bsqpap1sq(a: real, b: real)
  ensures 4.0*b*(a+1.0) <= 4.0*b*b + (a+1.0)*(a+1.0)
{}