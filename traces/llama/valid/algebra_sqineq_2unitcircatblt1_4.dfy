include "../utils.dfy"

import opened Utils

lemma algebra_sqineq_2unitcircatblt1(a: real, b: real)
  requires a * a + b * b == 2.0
  ensures a * b <= 1.0
{
  calc {
    a * a + b * b == 2.0;
    (a * a + b * b) / 2.0 == 1.0;
    (a * a) / 2.0 + (b * b) / 2.0 == 1.0;
    (a / sqrt(2.0)) * (a / sqrt(2.0)) + (b / sqrt(2.0)) * (b / sqrt(2.0)) == 1.0;
    (a / sqrt(2.0)) * (b / sqrt(2.0)) <= sqrt((a / sqrt(2.0)) * (a / sqrt(2.0))) * sqrt((b / sqrt(2.0)) * (b / sqrt(2.0)));
    (a / sqrt(2.0)) * (b / sqrt(2.0)) <= sqrt((a * a) / 2.0) * sqrt((b * b) / 2.0);
    (a / sqrt(2.0)) * (b / sqrt(2.0)) <= sqrt(((a * a) / 2.0 + (b * b) / 2.0) / 2.0);
    (a / sqrt(2.0)) * (b / sqrt(2.0)) <= sqrt(1.0 / 2.0);
    (a / sqrt(2.0)) * (b / sqrt(2.0)) <= 1.0 / sqrt(2.0);
    a * b <= sqrt(2.0) * 1.0 / sqrt(2.0);
    a * b <= 1.0;
  }
}