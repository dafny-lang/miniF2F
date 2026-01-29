include "../definitions.dfy"
include "../library.dfy"

lemma amc12a_2008_p4()
  ensures Real.prod(set k: int | 1 <= k <= 501 :: k, (k: int) => if k == 0 then 1.0 else (4.0*(k as real) + 4.0)/(4.0*(k as real))) == 502.0
{}