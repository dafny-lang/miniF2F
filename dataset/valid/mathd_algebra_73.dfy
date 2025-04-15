// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_73(p: complex, q: complex, r: complex, x: complex)
  requires Complex.mul(Complex.sub(x, p), Complex.sub(x, q)) == Complex.mul(Complex.sub(r, p), Complex.sub(r, q))
  requires x != r
  ensures x == Complex.sub(Complex.add(p, q), r)
{}