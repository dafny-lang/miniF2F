// Author: Stefan Zetzsche

include "../utils.dfy"

lemma induction_11div10tonmn1ton(n: nat)
  ensures (Int.pow(10, n) - Int.pow(-1, n)) % 11 == 0
{}