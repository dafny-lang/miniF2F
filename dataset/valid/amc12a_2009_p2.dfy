include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2009_p2()
  ensures 1.0 + (1.0 / (1.0 + (1.0 / (1.0+1.0)))) == 5.0/3.0
{}