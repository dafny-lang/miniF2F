// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_247(t: real, s: real, n: nat)
    requires t == 2.0 * s - s * s
    requires s == n as real * n as real - Real.pow(2.0, n) + 1.0
    requires n == 3
    ensures t == 0.0
{}