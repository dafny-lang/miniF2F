// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_others_exirrpowirrrat()
  ensures exists a, b: real :: irrational(a) && irrational(b) && !irrational(rpow(a, b))
{}