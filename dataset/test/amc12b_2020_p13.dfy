include "../utils.dfy"

lemma amc12b_2020_p13()
  ensures log(6.0)/log(2.0) + log(6.0)/log(3.0) >= 0.0 // added
  ensures log(3.0)/log(2.0) >= 0.0 // added
  ensures log(2.0)/log(3.0) >= 0.0 // added
  ensures sqrt(log(6.0)/log(2.0) + log(6.0)/log(3.0)) == sqrt(log(3.0)/log(2.0)) + sqrt(log(2.0)/log(3.0))
{}