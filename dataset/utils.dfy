module Utils {
  function pow(b: real, k: nat): real {
    if k == 0 then
      1.0
    else
      b * pow(b, k - 1)
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

  function {:axiom} exp(x: real): real

  lemma {:axiom} exp_neg(x: real)
    ensures exp(x) != 0.0

  lemma {:axiom} exp_zero()
    ensures exp(0.0) == 1.0

  lemma {:axiom} exp_add(x: real, y: real)
    ensures exp(x+y) == exp(x) * exp(y)

  lemma {:axiom} exp_sub(x: real, y: real)
    ensures exp(y) != 0.0
    ensures exp(x-y) == exp(x) / exp(y)

  lemma {:axiom} exp_lt_exp_of_lt(x: real, y: real)
    requires x < y
    ensures exp(x) < exp(y)

  lemma {:axiom} exp_le_exp_of_le(x: real, y: real)
    requires x <= y
    ensures exp(x) <= exp(y)

  lemma {:axiom} exp_eq_exp(x: real, y: real)
    ensures exp(x) == exp(y) <==> x == y

  function {:axiom} log(x: real): real

  lemma {:axiom} log_zero()
    ensures log(0.0) == 0.0

  lemma {:axiom} log_one()
    ensures log(1.0) == 0.0

  lemma {:axiom} log_abs(x: real)
    ensures log(abs(x)) == log(x)

  lemma {:axiom} log_neg_eq_log(x: real)
    ensures log(-x) == log(x)

  lemma {:axiom} log_mul(x: real, y: real)
    requires x != 0.0
    requires y != 0.0
    ensures log(x*y) == log(x) + log(y)

  lemma {:axiom} log_div(x: real, y: real)
    requires x != 0.0
    requires y != 0.0
    ensures log(x/y) == log(x) - log(y)

  lemma log_inv(x: real)
    requires x != 0.0
    ensures log(1.0/x) == -log(x)
  {
    log_div(1.0, x);
    log_one();
  }

  lemma {:axiom} log_nonneg(x: real)
    requires 1.0 <= x
    ensures 0.0 <= log(x)  

  lemma {:axiom} log_pos(x: real)
    requires 1.0 < x
    ensures 0.0 < log(x)

  lemma {:axiom} exp_log(x: real)
    requires 0.0 < x
    ensures exp(log(x)) == x

  function {:axiom} logb(b: real, x: real): real

  lemma {:axiom} logb_zero(b: real)
    ensures logb(b, 0.0) == 0.0

  lemma {:axiom} logb_one(b: real)
    ensures logb(b, 1.0) == 0.0

  lemma {:axiom} logb_zero_left(x: real)
    ensures logb(0.0, x) == 0.0

  lemma {:axiom} logb_one_left(x: real)
    ensures logb(1.0, x) == 0.0

  lemma {:axiom} logb_neg_eq_logb(b: real, x: real)
    ensures logb(b, -x) == logb(b, x)

  lemma {:axiom} logb_mul(b: real, x: real, y: real)
    requires x != 0.0
    requires y != 0.0
    ensures logb(b, x*y) == logb(b, x) + logb(b, y)

  lemma {:axiom} logb_div(b: real, x: real, y: real)
    requires x != 0.0
    requires y != 0.0
    ensures logb(b, x/y) == logb(b, x) - logb(b, y)

  lemma logb_inv(b: real, x: real)
    requires x != 0.0
    ensures logb(b, 1.0/x) == -logb(b, x)
  {
    logb_div(b, 1.0, x);
    logb_one(b);
  }

  lemma {:axiom} logb_pow(b: real, x: real, k: nat)
    ensures logb(b, pow(x, k)) == (k as real) * logb(b, x)
}