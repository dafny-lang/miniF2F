// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12b_2021_p9()
  ensures log(40.0) != 0.0
  ensures log(2.0)/log(40.0) != 0.0
  ensures log(20.0) != 0.0
  ensures log(2.0)/log(20.0) != 0.0
  ensures (log(80.0)/log(2.0))/(log(2.0)/log(40.0)) - (log(160.0)/log(2.0))/(log(2.0)/log(20.0)) == 2.0
{}