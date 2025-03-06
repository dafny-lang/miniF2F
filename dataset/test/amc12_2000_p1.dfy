// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12_2000_p1(i: nat, m: nat, o: nat)
  requires i != 0
  requires m != 0
  requires o != 0
  requires i*m*o == 2001
  ensures i+m+o <= 671
{}