// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_135(n: nat, A: nat, B: nat, C: nat)
  requires n == Int.pow(3,17) + Int.pow(3,10)
  requires (n+1) % 11 == 0
  requires A != B && A != C && B != C
  requires 0 <= A <= 9
  requires 0 <= B <= 9
  requires 0 <= C <= 9
  requires A % 2 != 0
  requires C % 2 != 0
  requires 3 % B != 0
  requires digits(10, n) == [B,A,B,C,C,A,C,B,A]
  ensures 100*A + 10*B + C == 129
{}