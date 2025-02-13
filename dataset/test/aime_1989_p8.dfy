include "../utils.dfy"

lemma aime_1989_p8(a: real, b: real, c: real, d: real, e: real, f: real, g: real)
  requires a + 4.0*b + 9.0*c + 16.0*d + 25.0*e + 36.0*f + 49.0*g == 1.0
  requires 4.0*a + 9.0*b + 16.0*c + 25.0*d + 36.0*e + 49.0*f + 64.0*g == 12.0
  requires 9.0*a + 16.0*b + 25.0*c + 36.0*d + 49.0*e + 64.0*f + 81.0*g == 123.0
  ensures 16.0*a + 25.0*b + 36.0*c + 49.0*d + 64.0*e + 81.0*f + 100.0*g == 334.0
{}