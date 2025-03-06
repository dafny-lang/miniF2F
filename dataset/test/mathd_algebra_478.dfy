// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_478(b: real, h: real, v: real)
  requires 0.0 < b && 0.0 < h && 0.0 < v
  requires v == 1.0 / 3.0 * (b * h)
  requires b == 30.0
  requires h == 13.0 / 2.0
  ensures v == 65.0
{}