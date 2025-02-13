include "../utils.dfy"

lemma algebra_absxm1pabsxpabsxp1eqxp2_0leqxleq1(x: real)
  requires abs(x-1.0) + abs(x) + abs(x+1.0) == x+2.0
  ensures 0.0 <= x <= 1.0
{}