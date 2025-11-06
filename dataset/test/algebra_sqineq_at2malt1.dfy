// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_sqineq_at2malt1(a: real)
  ensures a * (2.0-a) <= 1.0
{}