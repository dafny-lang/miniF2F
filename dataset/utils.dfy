/* DEFINITIONS */  

module Int {
  function {:axiom} pow(b: int, k: nat): (p: int) 
    ensures if k == 0 then p == 1 else p == b * pow(b, k - 1)
    ensures b >= 0 ==> p >= 0
    ensures (b == 0 && k != 0) <==> p == 0
    ensures b > 0 ==> p > 0
    ensures k == 1 ==> b == p

  function {:axiom} prod<T>(s: set<T>, f: T -> int): (p: int)
    ensures forall x | x in s :: p == f(x) * prod(s - {x}, f)

  function {:axiom} sum<T>(s: set<T>, f: T -> int): (p: int)
    ensures forall x | x in s :: p == f(x) + sum(s - {x}, f)
}

module Rat {
  type PosInt = n: int | n >= 1 witness 1

  datatype rat = Rational(num: int, denom: PosInt) {
    function {:axiom} to_real(): (r: real)
      ensures r == this.num as real / this.denom as real

    function {:axiom} neg(): (r: rat)
      ensures r == Rational(-this.num, this.denom)

    function {:axiom} inv(): (r: rat)
      requires this.num != 0
      ensures this.num < 0 ==> var denom: int := this.denom; r == Rational(-denom, -this.num)
      ensures this.num > 0 ==> var denom: int := this.denom; r == Rational(denom, this.num)
  }

  predicate {:axiom} eq(lhs: rat, rhs: rat) 
    ensures eq(lhs, rhs) <==> (lhs.num * rhs.denom == rhs.num * lhs.denom)

  predicate {:axiom} leq(lhs: rat, rhs: rat)
    ensures leq(lhs, rhs) <==> (lhs.num * rhs.denom <= rhs.num * lhs.denom)

  predicate {:axiom} le(lhs: rat, rhs: rat)
    ensures le(lhs, rhs) <==> (lhs.num * rhs.denom < rhs.num * lhs.denom)

  function {:axiom} add(lhs: rat, rhs: rat): (r: rat)
    ensures r == Rational(lhs.num * rhs.denom + rhs.num * lhs.denom, lhs.denom * rhs.denom)

  function {:axiom} sub(lhs: rat, rhs: rat): (r: rat) 
    ensures r == add(lhs, rhs.neg())

  function {:axiom} mul(lhs: rat, rhs: rat): (r: rat)
    ensures r == Rational(lhs.num * rhs.num, lhs.denom * rhs.denom)

  function {:axiom} div(lhs: rat, rhs: rat): (r: rat)
    requires rhs.num != 0
    ensures r == mul(lhs, rhs.inv())

  function {:axiom} of_int(n: int): (r: rat)
    ensures r == Rational(n, 1)

  function {:axiom} zero(): rat
    ensures zero() == of_int(0)
}

module Real {
  function {:axiom} pow(b: real, k: nat): (p: real) 
    ensures if k == 0 then p == 1.0 else p == b * pow(b, k - 1)
    ensures b >= 0.0 ==> p >= 0.0
    ensures (b == 0.0 && k != 0) <==> p == 0.0
    ensures b > 0.0 ==> p > 0.0
    ensures k == 1 ==> b == p
    ensures p == rpow(b, k as real)

  function {:axiom} rpow(b: real, k: real): (p: real)
    ensures k == 0.0 ==> p == 1.0
    ensures (b == 0.0 && k != 0.0) <==> p == 0.0
    ensures b > 0.0 ==> p > 0.0
    ensures k == 1.0 ==> b == p

  function {:axiom} sum<T>(s: set<T>, f: T -> real): (p: real)
    ensures forall x | x in s :: p == f(x) + sum(s - {x}, f)
}

module Complex {
  datatype complex = Complex(re: real, im: real) {
    function {:axiom} neg(): (z: complex)
      ensures z == Complex(-this.re, -this.im)
  }

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
    ensures u == add(z, w.neg())

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

function {:axiom} icc<T>(s: set<T>, t: set<T>): (r: set<set<T>>)
  ensures r == set x | s <= x <= t

function {:axiom} filter<T>(p: T -> bool, s: set<T>): (r: set<T>)
  ensures r == set x | x in s && p(x)

function {:axiom} range(n: nat): (s: set<nat>)
  ensures s == set x: nat | 0 <= x < n

import opened Real
import opened Int
import opened Rat
import opened Complex

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

predicate {:axiom} is_least(s: iset<nat>, l: nat)
  ensures is_least(s, l) <==> (l in s && forall a: nat | a in s :: l <= a)

predicate {:axiom} is_greatest(s: iset<nat>, g: nat)
  ensures is_greatest(s, g) <==> (g in s && forall a: nat | a in s :: a <= g)

function {:axiom} digits(b: int, n: int): seq<int>

function {:axiom} divisors(n: int): (s: set<int>)
  ensures forall x | x != 0 :: x in s <==> n % x == 0