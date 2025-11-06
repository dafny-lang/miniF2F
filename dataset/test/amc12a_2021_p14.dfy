// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2021_p14()
  ensures Real.sum(set k: int | 1 <= k <= 20, (k: int) => logb(Real.pow(5.0, k), Real.pow(3.0, k*k))) * Real.sum(set k: int | 1 <= k <= 100, (k: int) => logb(Real.pow(9.0, k), Real.pow(25.0, k))) == 21000.0
{}