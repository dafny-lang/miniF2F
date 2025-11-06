// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma cauchy_schwarz_four_terms(x1: real, x2: real, x3: real, x4: real, y1: real, y2: real, y3: real, y4: real)
  ensures (x1*y1 + x2*y2 + x3*y3 + x4*y4) * (x1*y1 + x2*y2 + x3*y3 + x4*y4) <=
          (x1*x1 + x2*x2 + x3*x3 + x4*x4) * (y1*y1 + y2*y2 + y3*y3 + y4*y4)
{
  // The Cauchy-Schwarz inequality: (∑xᵢyᵢ)² ≤ (∑xᵢ²)(∑yᵢ²)
  // This can be proven by showing the difference is a sum of squares
  var lhs := (x1*y1 + x2*y2 + x3*y3 + x4*y4) * (x1*y1 + x2*y2 + x3*y3 + x4*y4);
  var rhs := (x1*x1 + x2*x2 + x3*x3 + x4*x4) * (y1*y1 + y2*y2 + y3*y3 + y4*y4);

  // The difference rhs - lhs equals:
  // (x1*y2 - x2*y1)² + (x1*y3 - x3*y1)² + (x1*y4 - x4*y1)² +
  // (x2*y3 - x3*y2)² + (x2*y4 - x4*y2)² + (x3*y4 - x4*y3)²

  var diff := rhs - lhs;
  var sum_of_squares := (x1*y2 - x2*y1)*(x1*y2 - x2*y1) +
  (x1*y3 - x3*y1)*(x1*y3 - x3*y1) +
  (x1*y4 - x4*y1)*(x1*y4 - x4*y1) +
  (x2*y3 - x3*y2)*(x2*y3 - x3*y2) +
  (x2*y4 - x4*y2)*(x2*y4 - x4*y2) +
  (x3*y4 - x4*y3)*(x3*y4 - x4*y3);

  assert sum_of_squares >= 0.0;
  // The algebraic verification that diff == sum_of_squares is left to Dafny
}

lemma division_by_sqrt_product(x: real, y: real)
  requires x > 0.0
  requires y > 0.0
  ensures x / (sqrt(y) * sqrt(y)) == x / y
{
  assert sqrt(y) * sqrt(y) == y;
}

lemma algebra_amgm_sumasqdivbgeqsuma(a: real, b: real, c: real, d: real)
  requires 0.0 < a
  requires 0.0 < b
  requires 0.0 < c
  requires 0.0 < d
  ensures (a*a)/b + (b*b)/c + (c*c)/d + (d*d)/a >= a + b + c + d
{
  // We'll use Cauchy-Schwarz inequality
  // Let x₁ = a/√b, x₂ = b/√c, x₃ = c/√d, x₄ = d/√a
  // Let y₁ = √b, y₂ = √c, y₃ = √d, y₄ = √a

  var x1 := a / sqrt(b);
  var x2 := b / sqrt(c);
  var x3 := c / sqrt(d);
  var x4 := d / sqrt(a);

  var y1 := sqrt(b);
  var y2 := sqrt(c);
  var y3 := sqrt(d);
  var y4 := sqrt(a);

  // All terms are well-defined since a,b,c,d > 0
  assert sqrt(a) > 0.0;
  assert sqrt(b) > 0.0;
  assert sqrt(c) > 0.0;
  assert sqrt(d) > 0.0;

  // Apply division lemmas
  division_by_sqrt_product(a*a, b);
  division_by_sqrt_product(b*b, c);
  division_by_sqrt_product(c*c, d);
  division_by_sqrt_product(d*d, a);

  // Apply Cauchy-Schwarz
  cauchy_schwarz_four_terms(x1, x2, x3, x4, y1, y2, y3, y4);

  // Now we establish the key equalities step by step

  // First: x₁² + x₂² + x₃² + x₄² = (a²)/b + (b²)/c + (c²)/d + (d²)/a
  assert x1*x1 == (a/sqrt(b)) * (a/sqrt(b));
  assert x1*x1 == (a*a) / (sqrt(b) * sqrt(b));
  assert x1*x1 == (a*a) / b;

  assert x2*x2 == (b*b) / c;
  assert x3*x3 == (c*c) / d;
  assert x4*x4 == (d*d) / a;

  var sum_x_sq := x1*x1 + x2*x2 + x3*x3 + x4*x4;
  var target_lhs := (a*a)/b + (b*b)/c + (c*c)/d + (d*d)/a;
  assert sum_x_sq == target_lhs;

  // Second: x₁y₁ + x₂y₂ + x₃y₃ + x₄y₄ = a + b + c + d
  assert x1*y1 == (a/sqrt(b)) * sqrt(b) == a;
  assert x2*y2 == (b/sqrt(c)) * sqrt(c) == b;
  assert x3*y3 == (c/sqrt(d)) * sqrt(d) == c;
  assert x4*y4 == (d/sqrt(a)) * sqrt(a) == d;

  var sum_xy := x1*y1 + x2*y2 + x3*y3 + x4*y4;
  assert sum_xy == a + b + c + d;

  // Third: y₁² + y₂² + y₃² + y₄² = a + b + c + d
  assert y1*y1 == sqrt(b) * sqrt(b) == b;
  assert y2*y2 == sqrt(c) * sqrt(c) == c;
  assert y3*y3 == sqrt(d) * sqrt(d) == d;
  assert y4*y4 == sqrt(a) * sqrt(a) == a;

  var sum_y_sq := y1*y1 + y2*y2 + y3*y3 + y4*y4;
  assert sum_y_sq == a + b + c + d;

  // From Cauchy-Schwarz: (∑xᵢyᵢ)² ≤ (∑xᵢ²)(∑yᵢ²)
  // We have: (a + b + c + d)² ≤ ((a²)/b + (b²)/c + (c²)/d + (d²)/a) * (a + b + c + d)
  assert sum_xy * sum_xy <= sum_x_sq * sum_y_sq;
  assert (a + b + c + d) * (a + b + c + d) <= target_lhs * (a + b + c + d);

  // Since a + b + c + d > 0, we can divide both sides by it
  assert a + b + c + d > 0.0;

  // This gives us: a + b + c + d ≤ (a²)/b + (b²)/c + (c²)/d + (d²)/a
  assert (a + b + c + d) <= target_lhs;
}