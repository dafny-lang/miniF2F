// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma lemma1(x: nat -> int, n : nat)
  requires x(1) == 211
  requires x(2) == 375
  requires x(3) == 420
  requires x(4) == 523
  requires hyp: forall n | n >= 5 :: x(n) == x(n-1) - x(n-2) + x(n-3) - x(n-4)
  requires n >= 5
  ensures x(n+1) == - x(n-4)
{
  calc
  { 
      x(n+1);
    == { reveal hyp; }
      x(n) - x(n-1) + x(n-2) - x(n-3);
    == { reveal hyp; }
      (x(n-1) - x(n-2) + x(n-3) - x(n-4)) - x(n-1) + x(n-2) - x(n-3);
  }
}

lemma lemma2(x: nat -> int, n : nat)
  requires x(1) == 211
  requires x(2) == 375
  requires x(3) == 420
  requires x(4) == 523
  requires hyp: forall n | n >= 5 :: x(n) == x(n-1) - x(n-2) + x(n-3) - x(n-4)
  requires n >= 5
  ensures x(n+6) == x(n-4)
{
  calc
  {
    x(n + 6);
  == { reveal hyp; lemma1(x, n + 5); }
    - x(n + 1);
  == { reveal hyp; lemma1(x, n); }
    x(n - 4);
  }
}

lemma lemma3(x: nat -> int, n : nat)
  requires x(1) == 211
  requires x(2) == 375
  requires x(3) == 420
  requires x(4) == 523
  requires hyp: forall n | n >= 5 :: x(n) == x(n-1) - x(n-2) + x(n-3) - x(n-4)
  requires n >= 1
  ensures x(n+10) == x(n)
{
  reveal hyp;
  lemma2(x, n + 4);
}

lemma lemma4(x: nat -> int, n : nat)
  requires x(1) == 211
  requires x(2) == 375
  requires x(3) == 420
  requires x(4) == 523
  requires hyp: forall n | n >= 5 :: x(n) == x(n-1) - x(n-2) + x(n-3) - x(n-4)
  requires n >= 1
  requires n % 10 != 0
  ensures x(n) == x(n % 10)
{
  if n >= 10
  {
    assert n > 10;
    reveal hyp;
    lemma3(x, n - 10);
    lemma4(x, n - 10);
  }
}

lemma aimeII_2001_p3(x: nat -> int)
  requires x(1) == 211
  requires x(2) == 375
  requires x(3) == 420
  requires x(4) == 523
  requires forall n | n >= 5 :: x(n) == x(n-1) - x(n-2) + x(n-3) - x(n-4)
  ensures x(531) + x(753) + x(975) == 898
{
  assert 531 % 10 != 0;
  assert 753 % 10 != 0;
  assert 975 % 10 != 0;
  lemma4(x, 531);
  lemma4(x, 753);
  assert x(5) == 267;
  lemma4(x, 975);
}