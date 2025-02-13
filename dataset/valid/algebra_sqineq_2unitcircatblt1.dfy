include "../utils.dfy"

lemma algebra_sqineq_2unitcircatblt1(a: real, b: real)
  requires a * a + b * b == 2.0
  ensures a * b <= 1.0
{}