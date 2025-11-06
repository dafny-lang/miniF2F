include "definitions.dfy"

/* ========== AUXILIARY DEFINITIONS ========== */

  function {:axiom} cexp(z: complex): (w: complex)
    ensures z == Complex.zero() ==> w == one()
    ensures z.im == 0.0 ==> w == of_real(Real.exp(z.re))
    ensures z.re == 0.0 ==> w == Complex(Real.cos(z.im), Real.sin(z.im))
    ensures w == Complex.mul(of_real(Real.exp(z.re)), Complex(Real.cos(z.im), Real.sin(z.im)))

  predicate {:axiom} pos (x : real)
    ensures x > 0.0

  predicate {:axiom} eventually_within_eps(f: nat -> real, L: real, eps: real, N : nat)
    ensures forall n: nat :: n >= N ==> abs(f(n) - L) < eps

  predicate {:axiom} limit(f: nat -> real, L: real)
    ensures forall eps: real :: pos(eps) ==> forall N : nat ::  eventually_within_eps(f, L, eps, N)

  predicate {:axiom} continuous_at(f: real -> real, a: real)
    ensures forall eps: real | pos(eps) ::
    exists delta: real | pos(delta) ::
      forall x: real | abs(x - a) < delta :: abs(f(x) - f(a)) < eps

  predicate {:axiom} continuous(f: real -> real)
    ensures forall a: real :: continuous_at(f, a)


  function e_seq(n: nat): real
  {
    if n == 0 then 1.0
    else Real.pow(1.0 + 1.0/(n as real), n)
  }

  function {:axiom} e(): real
    ensures limit(((n : nat) => if n > 0 then e_seq(n) else 0.0), e())


function {:axiom} icc<T>(s: set<T>, t: set<T>): (r: set<set<T>>)
  ensures r == set x | s <= x <= t

/* LEMMAS */

/* ========== EXPONENTIAL & LOGARITHM ========== */

/* Exp */

lemma {:axiom} exp_zero()
  ensures exp(0.0) == 1.0

lemma {:axiom} exp_pos(x: real)
  ensures exp(x) > 0.0

lemma {:axiom} exp_add(x: real, y: real)
  ensures exp(x+y) == exp(x) * exp(y)

lemma {:axiom} exp_sub(x: real, y: real)
  ensures exp(x-y) == exp(x) / exp(y)

lemma {:axiom} exp_lt_exp_of_lt(x: real, y: real)
  requires x < y
  ensures exp(x) < exp(y)

lemma {:axiom} exp_le_exp_of_le(x: real, y: real)
  requires x <= y
  ensures exp(x) <= exp(y)

lemma {:axiom} exp_eq_exp(x: real, y: real)
  ensures exp(x) == exp(y) <==> x == y

lemma {:axiom} exp_continuous()
  ensures continuous(exp)

lemma {:axiom} exp_def()
  ensures forall x, y :: exp(x + y) == exp(x) * exp(y)
  ensures continuous(exp)
  ensures exp(0.0) == 1.0
  ensures exp(1.0) == e()

/* Log */

lemma {:axiom} log_one()
  ensures log(1.0) == 0.0

lemma {:axiom} log_exp(x: real)
  ensures log(exp(x)) == x

lemma {:axiom} exp_log(x: real)
  requires x > 0.0
  ensures exp(log(x)) == x

lemma {:axiom} log_mul(x: real, y: real)
  requires x > 0.0
  requires y > 0.0
  ensures log(x*y) == log(x) + log(y)

lemma {:axiom} log_div(x: real, y: real)
  requires x > 0.0
  requires y > 0.0
  ensures log(x/y) == log(x) - log(y)

lemma {:axiom} log_inv(x: real)
  requires x > 0.0
  ensures log(1.0/x) == -log(x)

lemma {:axiom} log_pow(y: real, n: nat)
  requires y > 0.0
  ensures log(Real.pow(y, n)) == (n as real)*log(y)

lemma {:axiom} log_nonneg(x: real)
  requires 1.0 <= x
  ensures 0.0 <= log(x)

lemma {:axiom} log_pos(x: real)
  requires 1.0 < x
  ensures 0.0 < log(x)

/* Logb */

lemma {:axiom} logb_one(b: real)
  requires b > 0.0 && b != 1.0
  ensures logb(b, 1.0) == 0.0

lemma {:axiom} logb_base(b: real)
  requires b > 0.0 && b != 1.0
  ensures logb(b, b) == 1.0

lemma {:axiom} rpow_logb(b: real, x: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0
  ensures rpow(b, logb(b, x)) == x

lemma {:axiom} logb_mul(b: real, x: real, y: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0 && y > 0.0
  ensures logb(b, x*y) == logb(b, x) + logb(b, y)

lemma {:axiom} logb_div(b: real, x: real, y: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0 && y > 0.0
  ensures logb(b, x/y) == logb(b, x) - logb(b, y)

lemma {:axiom} logb_inv(b: real, x: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0
  ensures logb(b, 1.0/x) == -logb(b, x)

lemma {:axiom} logb_pow(b: real, x: real, k: nat)
  requires b > 0.0 && b != 1.0
  requires x > 0.0
  ensures logb(b, Real.pow(x, k)) == (k as real) * logb(b, x)

lemma {:axiom} logb_rpow(b: real, x: real, k: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0
  ensures logb(b, rpow(x, k)) == k * logb(b, x)

lemma {:axiom} logb_change_base(b1: real, b2: real, x: real)
  requires b1 > 0.0 && b1 != 1.0
  requires b2 > 0.0 && b2 != 1.0
  requires x > 0.0
  ensures logb(b1, x) == logb(b2, x) / logb(b2, b1)

/* ========== POWERS ========== */

/* Pow */

lemma {:axiom} pow_eq_rpow(b: real, k: nat)
  ensures Real.pow(b, k) == rpow(b, k as real)

lemma {:axiom} pow_add(b: real, k: nat)
  ensures b > 0.0 ==> forall x: nat, y: nat :: Real.pow(b, x+y) == Real.pow(b, x) * Real.pow(b, y)

/* Rpow */

lemma {:axiom} rpow_add(b: real, x: real, y: real)
  requires b > 0.0
  ensures rpow(b, x+y) == rpow(b, x) * rpow(b, y)

lemma {:axiom} rpow_sub(b: real, x: real, y: real)
  requires b > 0.0
  ensures rpow(b, x-y) == rpow(b, x) / rpow(b, y)

lemma {:axiom} rpow_mul(x: real, y: real, k: real)
  requires x >= 0.0
  requires y >= 0.0
  ensures rpow(x*y, k) == rpow(x, k) * rpow(y, k)

lemma {:axiom} rpow_div(b: real, x: real, y: real)
  requires b > 0.0
  requires y != 0.0
  ensures rpow(b, x/y) == rpow(rpow(b, 1.0/y), x)

lemma {:axiom} rpow_div_base(x: real, y: real, k: real)
  requires x >= 0.0
  requires y > 0.0
  ensures rpow(x/y, k) == rpow(x, k) / rpow(y, k)

/* Sqrt */

lemma {:axiom} sqrt_mul(y: real, z: real)
  requires y >= 0.0
  requires z >= 0.0
  ensures sqrt(y*z) == sqrt(y)*sqrt(z)

/* ========== TRIGONOMETRY ========== */

/* Sin and Cos */

lemma {:axiom} sin_zero()
  ensures sin(0.0) == 0.0

lemma {:axiom} cos_zero()
  ensures cos(0.0) == 1.0

lemma {:axiom} sin_neg(x: real)
  ensures sin(-x) == -sin(x)

lemma {:axiom} cos_neg(x: real)
  ensures cos(-x) == cos(x)

lemma {:axiom} cos_abs(x: real)
  ensures cos(Real.abs(x)) == cos(x)

lemma {:axiom} sin_add(x: real, y: real)
  ensures sin(x+y) == sin(x)*cos(y) + cos(x)*sin(y)

lemma {:axiom} sin_sub(x: real, y: real)
  ensures sin(x-y) == sin(x)*cos(y) - cos(x)*sin(y)

lemma {:axiom} cos_add(x: real, y: real)
  ensures cos(x+y) == cos(x)*cos(y) - sin(x)*sin(y)

lemma {:axiom} cos_sub(x: real, y: real)
  ensures cos(x-y) == cos(x)*cos(y) + sin(x)*sin(y)

lemma {:axiom} cos_sq_add_sin_sq_eq_one(x : real)
  ensures cos(x) * cos(x) + sin(x) * sin(x) == 1.0

// Axiomatization of sin and cos functions over the real numbers
lemma {:axiom} sin_cos_def()
  ensures continuous(sin)
  ensures continuous(cos)
  ensures sin(0.0) == 0.0
  ensures forall x, y :: cos(x - y) == cos(x) * cos(y) + sin(x) * sin(y)
  ensures forall x | 0.0 < x < 1.0 :: 0.0 < x * cos(x) < sin(x) < x

/* Pi */

lemma {:axiom} pi_ne_zero()
  ensures pi() != 0.0

lemma {:axiom} one_le_pi_div_two()
  ensures 1.0 <= pi()/2.0

lemma {:axiom} pi_div_two_le_two()
  ensures pi()/2.0 <= 2.0

lemma {:axiom} sin_pi()
  ensures sin(pi()) == 0.0

lemma {:axiom} cos_pi()
  ensures cos(pi()) == -1.0

lemma {:axiom} sin_pi_div_two()
  ensures sin(pi() / 2.0) == 1.0

lemma {:axiom} cos_pi_div_two()
  ensures cos(pi()/2.0) == 0.0

lemma {:axiom} sin_two_pi()
  ensures sin(2.0*pi()) == 0.0

lemma {:axiom} cos_two_pi()
  ensures cos(2.0*pi()) == 1.0

lemma {:axiom} sin_period(x: real, k: int)
  ensures sin(x + (k as real) * 2.0 * pi()) == sin(x)

lemma {:axiom} cos_period(x: real, k: int)
  ensures cos(x + (k as real) * 2.0 * pi()) == cos(x)

lemma {:axiom} sin_add_pi(x: real)
  ensures sin(x + pi()) == -sin(x)

lemma {:axiom} sin_sub_pi(x: real)
  ensures sin(x - pi()) == -sin(x)

lemma {:axiom} cos_add_pi(x: real)
  ensures cos(x + pi()) == -cos(x)

lemma {:axiom} cos_sub_pi(x: real)
  ensures cos(x - pi()) == -cos(x)

lemma {:axiom} sin_add_two_pi(x: real)
  ensures sin(x + 2.0*pi()) == sin(x)

lemma {:axiom} sin_sub_two_pi(x: real)
  ensures sin(x - 2.0*pi()) == sin(x)

lemma {:axiom} cos_add_two_pi(x: real)
  ensures cos(x + 2.0*pi()) == cos(x)

lemma {:axiom} cos_sub_two_pi(x: real)
  ensures cos(x - 2.0*pi()) == cos(x)

lemma {:axiom} pi_smallest_period()
  ensures forall p: real | pos(p) && (forall x :: sin(x + p) == sin(x)) :: pi() <= p

/* Special angle values */

lemma {:axiom} sin_pi_div_six()
  ensures sin(pi() / 6.0) == 0.5

lemma {:axiom} cos_pi_div_six()
  ensures cos(pi() / 6.0) == sqrt(3.0) / 2.0

lemma {:axiom} sin_pi_div_four()
  ensures sin(pi() / 4.0) == sqrt(2.0) / 2.0

lemma {:axiom} cos_pi_div_four()
  ensures cos(pi() / 4.0) == sqrt(2.0) / 2.0
  ensures cos(pi() / 4.0) == sin(pi() / 4.0)

lemma {:axiom} sin_pi_div_three()
  ensures sin(pi() / 3.0) == sqrt(3.0) / 2.0

lemma {:axiom} cos_pi_div_three()
  ensures cos(pi() / 3.0) == 0.5

/* ========== COMPLEX NUMBERS ========== */

/* Complex arithmetic */

lemma {:axiom} complex_add_comm(z: Complex.complex, w: Complex.complex)
  ensures Complex.add(z, w) == Complex.add(w, z)

lemma {:axiom} complex_add_assoc(z: Complex.complex, w: Complex.complex, u: Complex.complex)
  ensures Complex.add(Complex.add(z, w), u) == Complex.add(z, Complex.add(w, u))

lemma {:axiom} complex_add_zero(z: Complex.complex)
  ensures Complex.add(z, Complex.zero()) == z

lemma {:axiom} complex_mul_comm(z: Complex.complex, w: Complex.complex)
  ensures Complex.mul(z, w) == Complex.mul(w, z)

lemma {:axiom} complex_mul_assoc(z: Complex.complex, w: Complex.complex, u: Complex.complex)
  ensures Complex.mul(Complex.mul(z, w), u) == Complex.mul(z, Complex.mul(w, u))

lemma {:axiom} complex_mul_one(z: Complex.complex)
  ensures Complex.mul(z, Complex.one()) == z

lemma {:axiom} complex_mul_zero(z: Complex.complex)
  ensures Complex.mul(z, Complex.zero()) == Complex.zero()

lemma {:axiom} complex_distributive(z: Complex.complex, w: Complex.complex, u: Complex.complex)
  ensures Complex.mul(z, Complex.add(w, u)) == Complex.add(Complex.mul(z, w), Complex.mul(z, u))

lemma {:axiom} complex_norm_sq_nonneg(z: Complex.complex)
  ensures Complex.norm_sq(z) >= 0.0

lemma {:axiom} complex_norm_sq_zero(z: Complex.complex)
  ensures Complex.norm_sq(z) == 0.0 <==> z == Complex.zero()

lemma {:axiom} complex_abs_nonneg(z: Complex.complex)
  ensures Complex.norm(z) >= 0.0

lemma {:axiom} complex_abs_zero(z: Complex.complex)
  ensures Complex.norm(z) == 0.0 <==> z == Complex.zero()

/* Complex exponential */

lemma {:axiom} cexp_zero()
  ensures cexp(Complex.zero()) == Complex.one()

lemma {:axiom} cexp_add(z: Complex.complex, w: Complex.complex)
  ensures cexp(Complex.add(z, w)) == Complex.mul(cexp(z), cexp(w))

lemma {:axiom} cexp_real(x: real)
  ensures cexp(Complex.of_real(x)) == Complex.of_real(exp(x))

lemma {:axiom} cexp_imag(y: real)
  ensures cexp(Complex.Complex(0.0, y)) == Complex.Complex(cos(y), sin(y))

lemma {:axiom} euler_formula(x: real)
  ensures cexp(Complex.mul(Complex.i(), Complex.of_real(x))) == Complex.Complex(cos(x), sin(x))

lemma {:axiom} cos_via_exp(x: real)
  ensures cos(x) == (cexp(Complex.mul(Complex.i(), Complex.of_real(x))).re + 
                      cexp(Complex.mul(Complex.i(), Complex.of_real(-x))).re) / 2.0

lemma {:axiom} sin_via_exp(x: real)
  ensures sin(x) == (cexp(Complex.mul(Complex.i(), Complex.of_real(x))).im - 
                      cexp(Complex.mul(Complex.i(), Complex.of_real(-x))).im) / 2.0

/* ========== NUMBER THEORY ========== */

/* GCD */

lemma {:axiom} gcd_comm(x: nat, y: nat)
  requires x > 0 || y > 0
  ensures gcd(x, y) == gcd(y, x)

lemma {:axiom} gcd_self(x: nat)
  requires x > 0
  ensures gcd(x, x) == x

lemma {:axiom} gcd_one_left(x: nat)
  requires x > 0
  ensures gcd(1, x) == 1

lemma {:axiom} gcd_one_right(x: nat)
  requires x > 0
  ensures gcd(x, 1) == 1

lemma {:axiom} gcd_lcm_product(x: nat, y: nat)
  requires x > 0
  requires y > 0
  ensures gcd(x,y)*lcm(x,y) == x*y

/* ========== ANALYSIS ========== */

/* Limits */

lemma {:axiom} limit_unique(f: nat -> real, L1: real, L2: real)
  requires limit(f, L1)
  requires limit(f, L2)
  ensures L1 == L2

/* Continuity */

lemma {:axiom} continuous_add(f: real -> real, g: real -> real)
  requires continuous(f)
  requires continuous(g)
  ensures continuous((x: real) => f(x) + g(x))

lemma {:axiom} continuous_mul(f: real -> real, g: real -> real)
  requires continuous(f)
  requires continuous(g)
  ensures continuous((x: real) => f(x) * g(x))

lemma {:axiom} continuous_compose(f: real -> real, g: real -> real)
  requires continuous(f)
  requires continuous(g)
  ensures continuous((x: real) => f(g(x)))


/* ========== SEQUENCE Products and Sums ========== */


import opened Int
import opened Rat
import opened Real
import opened Complex

/* Integer sequences */
function int_prod_seq<T>(s: seq<T>, f: T -> int): (p: int)
  ensures s == [] ==> p == 1
  ensures s != [] ==> int_prod_seq(s, f) == f(s[0]) * int_prod_seq(s[1..], f)
{
  if s == [] then 1
  else f(s[0]) * int_prod_seq(s[1..], f)
}

function int_sum_seq<T>(s: seq<T>, f: T -> int): (p: int)
  ensures s == [] ==> p == 0
  ensures s != [] ==> int_sum_seq(s, f) == f(s[0]) + int_sum_seq(s[1..], f)
{
  if s == [] then 0
  else f(s[0]) + int_sum_seq(s[1..], f)
}

/* Rational sequences */
function rat_prod_seq<T>(s: seq<T>, f: T -> rat): (p: rat)
  ensures s == [] ==> p == Rational(1, 1)
  ensures s != [] ==> rat_prod_seq(s, f) == Rat.mul(f(s[0]), rat_prod_seq(s[1..], f))
{
  if s == [] then Rational(1, 1)
  else Rat.mul(f(s[0]), rat_prod_seq(s[1..], f))
}

function rat_sum_seq<T>(s: seq<T>, f: T -> rat): (p: rat)
  ensures s == [] ==> p == Rational(0, 1)
  ensures s != [] ==> rat_sum_seq(s, f) == Rat.add(f(s[0]), rat_sum_seq(s[1..], f))
{
  if s == [] then Rational(0, 1)
  else Rat.add(f(s[0]), rat_sum_seq(s[1..], f))
}

/* Real sequences */
function real_sum_seq<T>(s: seq<T>, f: T -> real): (p: real)
  ensures s == [] ==> p == 0.0
  ensures s != [] ==> real_sum_seq(s, f) == f(s[0]) + real_sum_seq(s[1..], f)
{
  if s == [] then 0.0
  else f(s[0]) + real_sum_seq(s[1..], f)
}

function real_prod_seq<T>(s: seq<T>, f: T -> real): (p: real)
  ensures s == [] ==> p == 1.0
  ensures s != [] ==> real_prod_seq(s, f) == f(s[0]) * real_prod_seq(s[1..], f)
{
  if s == [] then 1.0
  else f(s[0]) * real_prod_seq(s[1..], f)
}

/* Complex sequences */
function complex_sum_seq<T>(s: seq<T>, f: T -> complex): (p: complex)
  ensures s == [] ==> p == Complex.zero()
  ensures s != [] ==> complex_sum_seq(s, f) == Complex.add(f(s[0]), complex_sum_seq(s[1..], f))
{
  if s == [] then Complex.zero()
  else Complex.add(f(s[0]), complex_sum_seq(s[1..], f))
}

function complex_prod_seq<T>(s: seq<T>, f: T -> complex): (p: complex)
  ensures s == [] ==> p == one()
  ensures s != [] ==> complex_prod_seq(s, f) == Complex.mul(f(s[0]), complex_prod_seq(s[1..], f))
{
  if s == [] then one()
  else Complex.mul(f(s[0]), complex_prod_seq(s[1..], f))
}


/* ========== Coercions ========== */

/* Sum and Prod conversions */

lemma {:axiom} int_sum_seq_to_set<T>(s: seq<T>, f: T -> int)
  ensures int_sum_seq(s, f) == Int.sum((set x | x in s), f)

lemma {:axiom} int_prod_seq_to_set<T>(s: seq<T>, f: T -> int)
  ensures int_prod_seq(s, f) == Int.prod((set x | x in s), f)

lemma {:axiom} rat_sum_seq_to_set<T>(s: seq<T>, f: T -> Rat.rat)
  ensures rat_sum_seq(s, f) == Rat.sum((set x | x in s), f)

lemma {:axiom} rat_prod_seq_to_set<T>(s: seq<T>, f: T -> Rat.rat)
  ensures rat_prod_seq(s, f) == Rat.prod((set x | x in s), f)

lemma {:axiom} real_sum_seq_to_set<T>(s: seq<T>, f: T -> real)
  ensures real_sum_seq(s, f) == Real.sum((set x | x in s), f)

lemma {:axiom} real_prod_seq_to_set<T>(s: seq<T>, f: T -> real)
  ensures real_prod_seq(s, f) == Real.prod((set x | x in s), f)

lemma {:axiom} complex_sum_seq_to_set<T>(s: seq<T>, f: T -> Complex.complex)
  ensures complex_sum_seq(s, f) == Complex.sum((set x | x in s), f)

lemma {:axiom} complex_prod_seq_to_set<T>(s: seq<T>, f: T -> Complex.complex)
  ensures complex_prod_seq(s, f) == Complex.prod((set x | x in s), f)



