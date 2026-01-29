include "../definitions.dfy"
include "../library.dfy"

lemma amc12b_2020_p22(t: real)
  ensures ((rpow(2.0,t) - 3.0*t)*t) / (rpow(4.0,t)) <= 1.0/12.0
{}