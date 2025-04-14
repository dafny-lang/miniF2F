include "utils.dfy"

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