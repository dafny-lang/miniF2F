// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_13(a: real, b: real)
  requires forall x: real :: (x-3.0 != 0.0 && x-5.0 != 0.0) ==> (4.0*x / (x*x -8.0*x + 15.0) == a/(x-3.0) + b/(x-5.0))
  ensures a == -6.0
  ensures b == 10.0
{}