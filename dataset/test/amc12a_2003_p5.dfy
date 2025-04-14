// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2003_p5(a: nat, m: nat, c: nat)
  requires a <= 9
  requires m <= 9
  requires c <= 9
  requires of_digits(10, [0,1,c,m,a]) + of_digits(10, [2,1,c,m,a]) == 123422
  ensures a+m+c == 14
{}