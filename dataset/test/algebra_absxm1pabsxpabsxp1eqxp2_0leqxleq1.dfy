// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebra_absxm1pabsxpabsxp1eqxp2_0leqxleq1(x: real)
  requires Real.abs(x-1.0) + Real.abs(x) + Real.abs(x+1.0) == x+2.0
  ensures 0.0 <= x <= 1.0
{}