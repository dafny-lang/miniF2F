include "../utils.dfy"

lemma amc12a_2013_p4()
  ensures Real.pow(2.0,2014) != Real.pow(2.0,2012)
  ensures (Real.pow(2.0,2014) + Real.pow(2.0,2012)) / (Real.pow(2.0,2014) - Real.pow(2.0,2012)) == 5.0/3.0
{}