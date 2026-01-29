include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_44(s: real, t: real)
  requires s == 9.0 - 2.0*t
  requires t == 3.0*s + 1.0
  ensures s == 1.0
  ensures t == 4.0
{}