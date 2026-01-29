include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_459(a: rat, b: rat, c: rat, d: rat)
  requires Rat.eq(Rat.mul(Rat.of_int(3),a), Rat.add(Rat.add(b,c),d))
  requires Rat.eq(Rat.mul(Rat.of_int(4),b), Rat.add(Rat.add(a,c),d))
  requires Rat.eq(Rat.mul(Rat.of_int(2),c), Rat.add(Rat.add(a,b),d))
  requires Rat.eq(Rat.add(Rat.add(Rat.mul(Rat.of_int(8),a),Rat.mul(Rat.of_int(10),b)),Rat.mul(Rat.of_int(6),c)), Rat.of_int(24))
  ensures d.denom + d.num == 28
{}