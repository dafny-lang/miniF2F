include "../utils.dfy"

lemma imo_1962_p4(s: iset<real>)
  requires s == iset x: real | cos(x)*cos(x) + cos(2.0*x)*cos(2.0*x) + cos(3.0*x)*cos(3.0*x) == 1.0
  ensures s == iset x: real | (exists m: int :: (x == pi/2.0 + (m as real)*pi) || (x == pi/4.0 + (m as real)*pi/2.0) || (x == pi/6.0 + (m as real)*pi) || (x == 5.0*pi/6.0 + (m as real)*pi))
{}