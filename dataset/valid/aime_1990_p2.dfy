include "../definitions.dfy"
include "../library.dfy"

lemma aime_1990_p2()
  ensures rpow(52.0 + 6.0*sqrt(43.0), 3.0/(2 as real)) - rpow(52.0 - 6.0*sqrt(43.0), 3.0/(2 as real)) == 828.0
{}