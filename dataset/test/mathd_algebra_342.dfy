include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_342(a: real, d: real)
  requires Real.sum(range(5), k => a+(k as real)*d) == 70.0
  requires Real.sum(range(10), k => a+(k as real)*d) == 210.0
  ensures a == 42.0/5.0
{}