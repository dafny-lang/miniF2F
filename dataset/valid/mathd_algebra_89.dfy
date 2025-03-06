// Author: Stefan Zetzsche

include "../utils.dfy"

lemma  mathd_algebra_89(b: real)
  requires b != 0.0
  requires Real.pow(4.0*b*b, 3) != 0.0
  ensures (7.0*b*b*b) * (7.0*b*b*b) * 1.0/Real.pow(4.0*b*b, 3) == 49.0/64.0
{}