// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_sqineq_unitcircatbpabsamblt1(a: real, b: real)
  requires a*a + b*b == 1.0
  ensures a*b + Real.abs(a-b) <= 1.0
{}