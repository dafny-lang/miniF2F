// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_282(f: real -> real)
  requires forall x: real | !irrational(x) :: f(x) == abs(floor(x) as real)
  requires forall x: real | irrational(x) :: f(x) == (ceil(x) as real)*(ceil(x) as real)
  ensures f(rpow(8.0, 1.0/3.0)) + f(-pi) + f(sqrt(50.0)) + f(9.0/2.0) == 79.0
{}