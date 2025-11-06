// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_690()
  ensures is_least(iset a: nat | 0 < a && (a%3 == 2%3) && (a%5 == 4%5) && (a%7 == 6%7) && (a%9 == 8%9), 314)
{}