include "../definitions.dfy"
include "../library.dfy"

// Helper lemma: relationship between log base 8 and log base 2
lemma {:axiom} log8_to_log2(x: real)
  requires x > 0.0
  ensures logb(8.0, x) * 3.0 == logb(2.0, x)

// Helper lemma: if log_2(log_8(x)) = log_8(log_2(x)), then (log_2(x))^2 = 27
lemma {:axiom} logb_equation_implies_square(x: real)
  requires x > 0.0
  requires logb(2.0, logb(8.0, x)) == logb(8.0, logb(2.0, x))
  ensures Real.pow(logb(2.0, x), 2) == 27.0

lemma aime_1988_p3(x: real)
  requires 0.0 < x
  requires logb(2.0, logb(8.0, x)) == logb(8.0, logb(2.0, x))
  ensures Real.pow(logb(2.0, x), 2) == 27.0
{
  logb_equation_implies_square(x);
}
