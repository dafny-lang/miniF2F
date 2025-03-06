// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_362(a: real, b: real)
  requires a*a * b*b*b == 32.0/27.0
  requires a / b*b*b == 27.0/4.0
  ensures a+b == 8.0/3.0
{}