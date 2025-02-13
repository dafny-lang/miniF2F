include "../utils.dfy"

lemma amc12_2000_p11(a: real, b: real)
  requires a != 0.0
  requires b != 0.0
  requires a * b == a - b
  ensures a/b + b/a - a*b == 2.0
{}