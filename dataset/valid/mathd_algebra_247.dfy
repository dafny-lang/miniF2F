include "../utils.dfy"

import opened Utils

lemma mathd_algebra_247(t: real, s: real, n: int)
    requires t == 2.0 * s - s * s
    requires s == n as real * n as real - power(2, n) as real + 1.0
    requires n == 3
    ensures t == 0.0
{}