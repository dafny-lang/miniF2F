// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2003_p24()
  ensures Real.is_greatest(iset y: real | (exists a,b: real :: (1.0 < b <= a) && (y == logb(a, a/b) + logb(b, b/a))) :: y, 0.0)
{}