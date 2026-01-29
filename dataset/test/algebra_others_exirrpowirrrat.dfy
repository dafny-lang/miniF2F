include "../definitions.dfy"
include "../library.dfy"

lemma algebra_others_exirrpowirrrat()
  ensures exists a, b : real :: irrational(a) && irrational(b) && !irrational(rpow(a, b))
{   
}