// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2016_p2(x: real)
  requires Real.rpow(10.0, x) * Real.rpow(100.0, 2.0*x) == Real.rpow(1000.0, 5.0)
  ensures x == 3.0
{}