include "../utils.dfy"

lemma algebra_sqineq_unitcircatbpabsamblt1(a: real, b: real)
  requires a*a + b*b == 1.0
  ensures a*b + abs(a-b) <= 1.0
{}