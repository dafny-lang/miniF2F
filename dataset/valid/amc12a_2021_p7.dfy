include "../utils.dfy"

lemma amc12a_2021_p7(x: real, y: real)
  ensures 1.0 <= (x*y-1.0)*(x*y-1.0) + (x+y)*(x+y)
{}