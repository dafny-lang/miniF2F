include "../definitions.dfy"
include "../library.dfy"

lemma algebra_sqineq_unitcircatbpamblt1(a: real, b: real)
  requires a*a + b*b == 1.0
  ensures a*b + (a-b) <= 1.0
{}