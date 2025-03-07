/* DEFINITIONS */  

module Int {
  function {:axiom} pow(b: int, k: nat): (p: int) 
    ensures b >= 0 ==> p >= 0
    ensures if k == 0 then p == 1 else p == b * pow(b, k - 1)
}

module Rat {
  type PosInt = n: int | n >= 1 witness 1

  datatype rat = Rational(num: int, denom: PosInt) {
    function {:axiom} to_real(): (r: real)
      ensures r == this.num as real / this.denom as real
  }

  predicate {:axiom} eq(lhs: rat, rhs: rat) 
    ensures eq(lhs, rhs) <==> lhs.num * rhs.denom == rhs.num * lhs.denom

  function {:axiom} add(lhs: rat, rhs: rat): (r: rat)
    ensures r == Rational(lhs.num * rhs.denom + rhs.num * lhs.denom, lhs.denom * rhs.denom)

  function {:axiom} mul(lhs: rat, rhs: rat): (r: rat)
    ensures r == Rational(lhs.num * rhs.num, lhs.denom * rhs.denom)
  
  function {:axiom} of_int(n: int): (r: rat)
    ensures r == Rational(n, 1)


}

module Real {
  function {:axiom} pow(b: real, k: nat): (p: real) 
    ensures b >= 0.0 ==> p >= 0.0
    ensures if k == 0 then p == 1.0 else p == b * pow(b, k - 1)
    ensures p == rpow(b, k as real)

  function {:axiom} rpow(x: real, y: real): (p: real)
}

module Complex {
  datatype complex = Complex(re: real, im: real)

  function {:axiom} of_real(r: real): (z: complex) 
    ensures z == Complex(r, 0.0)

  function {:axiom} zero(): complex
    ensures zero() == of_real(0.0)

  function {:axiom} one(): complex
    ensures one() == of_real(1.0)

  function {:axiom} i(): complex
    ensures i() == Complex(0.0, 1.0)

  function {:axiom} add(z: complex, w: complex): (u: complex) 
    ensures u == Complex(z.re + w.re, z.im + w.im)

  function {:axiom} sub(z: complex, w: complex): (u: complex) 
    ensures u == Complex(z.re - w.re, z.im - w.im)

  function {:axiom} mul(z: complex, w: complex): (u: complex) 
    ensures u == Complex(z.re * w.re - z.im * w.im, z.re * w.im + z.im * w.re)

  function {:axiom} div(z: complex, w: complex): (u: complex)
    requires w != zero()
    ensures u == Complex(z.re * w.re / norm_sq(w) + z.im * w.im / norm_sq(w), z.im * w.re / norm_sq(w) - z.re * w.im / norm_sq(w))

  function {:axiom} pow(b: complex, k: nat): (p: complex) 
    ensures if k == 0 then p == one() else p == mul(b, pow(b, k - 1))

  function {:axiom} norm_sq(z: complex): (r: real)
    ensures r == z.re * z.re + z.im * z.im
    ensures r == 0.0 <==> z == zero()

  function {:axiom} sqrt(x: real): (y: real)
    requires x >= 0.0
    ensures y >= 0.0
    ensures y * y == x

  function {:axiom} abs(z: complex): (r: real) 
    ensures r == sqrt(z.re * z.re + z.im * z.im)
}

module Finset {
  function {:axiom} icc<T>(s: set<T>, t: set<T>): (r: set<set<T>>)
    ensures r == set x | s <= x <= t

  function {:axiom} filter<T>(s: set<T>, p: T -> bool): (r: set<T>)
    ensures r == set x | x in s && p(x)
}

import opened Real
import opened Int
import opened Rat
import opened Complex
import opened Finset

function {:axiom} choose(n: nat, k: nat): nat
  ensures n >= 1 && k >= 1 ==> choose(n,k) == choose(n-1,k-1) + choose(n-1,k)
  ensures k != 0 ==> choose(0,k) == 0
  ensures choose(n,0) == 1

function {:axiom} floor(x: real): (m: int)
  ensures m as real <= x < (m+1) as real

function {:axiom} ceil(x: real): (m: int)
  ensures (m-1) as real < x <= m as real

predicate {:axiom} irrational(x: real)

function {:axiom} abs(x: real): (r: real)
  ensures if x >= 0.0 then r == x else r == -x

function {:axiom} factorial(n: nat): (r: nat) 
  ensures if n == 0 then r == 1 else r == n * factorial(n-1)

predicate {:axiom} prime(n: int) 
  ensures prime(n) <==> 2 <= n && forall m | 2 <= m < n :: n % m != 0

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

function {:axiom} exp(x: real): (e: real)
  ensures e != 0.0
  ensures x == 0.0 ==> e == 1.0

function {:axiom} log(x: real): (l: real)
  ensures x > 1.0 ==> l > 0.0
  ensures x == 1.0 ==> l == 0.0
  ensures 0.0 < x < 1.0 ==> l < 0.0
  ensures x == 0.0 ==> l == 0.0

function {:axiom} logb(b: real, x: real): (l: real)
  ensures x == 0.0 ==> l == 0.0
  ensures x == 1.0 ==> l == 0.0
  ensures b == 0.0 ==> l == 0.0
  ensures b == 1.0 ==> l == 0.0

function {:axiom} cos(x: real): real

function {:axiom} sin(x: real): real

function {:axiom} tan(x: real): real

const {:axiom} pi: real

/* LEMMAS */

/* Exp */

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

/* Log */

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

lemma {:axiom} log_inv(x: real)
  requires x != 0.0
  ensures log(1.0/x) == -log(x)

lemma {:axiom} log_nonneg(x: real)
  requires 1.0 <= x
  ensures 0.0 <= log(x)  

lemma {:axiom} log_pos(x: real)
  requires 1.0 < x
  ensures 0.0 < log(x)

lemma {:axiom} exp_log(x: real)
  requires 0.0 < x
  ensures exp(log(x)) == x

/* Logb */

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

lemma {:axiom} logb_inv(b: real, x: real)
  requires x != 0.0
  ensures logb(b, 1.0/x) == -logb(b, x)

lemma {:axiom} logb_pow(b: real, x: real, k: nat)
  ensures logb(b, Real.pow(x, k)) == (k as real) * logb(b, x)

/* Cos and sin */

lemma {:axiom} cos_zero()
  ensures cos(0.0) == 1.0

lemma {:axiom} sin_zero()
  ensures sin(0.0) == 0.0

lemma {:axiom} cos_neg(x: real)
  ensures cos(-x) == cos(x)

lemma {:axiom} cos_abs(x: real)
  ensures cos(abs(x)) == cos(x)

lemma {:axiom} cos_add(x: real, y: real)
  ensures cos(x+y) == cos(x)*cos(y) - sin(x)*sin(y)

lemma {:axiom} cos_sub(x: real, y: real)
  ensures cos(x-y) == cos(x)*cos(y) + sin(x)*sin(y)

lemma {:axiom} sin_add(x: real, y: real)
  ensures sin(x+y) == sin(x)*cos(y) + cos(x)*sin(y)

lemma {:axiom} sin_sub(x: real, y: real)
  ensures sin(x-y) == sin(x)*cos(y) - cos(x)*sin(y)

lemma {:axiom} neg_one_le_cos(x: real)
  ensures -1.0 <= cos(x)

lemma {:axiom} neg_one_le_sin(x: real)
  ensures -1.0 <= sin(x)

lemma {:axiom} cos_le_one(x: real)
  ensures x <= 1.0

lemma {:axiom} sin_le_one(x: real)
  ensures sin(x) <= 1.0

/* Pi */

lemma {:axiom} cos_pi_div_two()
  ensures cos(pi/2.0) == 0.0

lemma {:axiom} sin_pi()
  ensures sin(pi) == 0.0

lemma {:axiom} cos_pi()
  ensures cos(pi) == -1.0

lemma {:axiom} sin_two_pi()
  ensures sin(2.0*pi) == 0.0

lemma {:axiom} cos_two_pi()
  ensures cos(2.0*pi) == 1.0

lemma {:axiom} sin_add_pi(x: real)
  ensures sin(x + pi) == -sin(x)

lemma {:axiom} sin_add_two_pi(x: real)
  ensures sin(x + 2.0*pi) == sin(x)

lemma {:axiom} sin_sub_pi(x: real)
  ensures sin(x - pi) == -sin(x)

lemma {:axiom} sin_sub_two_pi(x: real)
  ensures sin(x - 2.0*pi) == sin(x)

lemma {:axiom} cos_add_pi(x: real)
  ensures cos(x + pi) == -cos(x)

lemma {:axiom} cos_add_two_pi(x: real)
  ensures cos(x + 2.0*pi) == cos(x)

lemma {:axiom} cos_sub_pi(x: real)
  ensures cos(x - pi) == -cos(x)

lemma {:axiom} cos_sub_two_pi(x: real)
  ensures cos(x - 2.0*pi) == cos(x)

lemma {:axiom} one_le_pi_div_two()
  ensures 1.0 <= pi/2.0

lemma {:axiom} pi_div_two_le_two()
  ensures pi/2.0 <= 2.0

lemma {:axiom} pi_ne_zero()
  ensures pi != 0.0