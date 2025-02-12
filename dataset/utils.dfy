module Utils {
  function pow(b: int, e: nat): int {
    if e == 0 then
      1
    else
      b * pow(b, e - 1)
  }

  function {:axiom} sqrt(x: real): (y: real)
    requires x >= 0.0
    ensures y >= 0.0
    ensures y * y == x

  function abs(x: real): real {
    if x >= 0.0 then x else -x
  }

  function factorial(n: nat): nat {
    if n == 0 then
      1
    else
      n * factorial(n-1)
  }

  predicate prime(n: int) {
    2 <= n && forall m | 2 <= m < n :: n % m != 0
  }

  function {:axiom} gcd(x: nat, y: nat): (gcd: nat)
    requires x > 0 || y > 0
    ensures gcd > 0
    ensures x % gcd == 0
    ensures y % gcd == 0
    ensures forall p: nat | p > 0 && x % p == 0 && y % p == 0 :: p <= gcd

  function {:axiom} lcm(x: nat, y: nat): (lcm: nat)
    requires x > 0 && y > 0
    ensures lcm > 0
    ensures lcm % x == 0
    ensures lcm % y == 0
    ensures forall p: nat | p > 0 && p % x == 0 && p % y == 0 :: lcm <= p
}