include "../utils.dfy"

import opened Utils

lemma imo_1961_p1(x: real, y: real, z: real, a: real, b: real)
  requires 0.0 < x
  requires 0.0 < y
  requires 0.0 < z
  requires x != y
  requires y != z
  requires z != x
  requires x + y + z == a
  requires x*x + y*y + z*z == b*b
  requires x*y == z*z
  ensures 0.0 < a
  ensures b*b < a*a
  ensures a*a < 3.0 * b*b
{
  calc {
    a*a == (x + y + z)*(x + y + z);
    a*a == x*x + y*y + z*z + 2.0*x*y + 2.0*y*z + 2.0*z*x;
    a*a == b*b + 2.0*x*y + 2.0*y*z + 2.0*z*x;
    a*a == b*b + 2.0*z*z + 2.0*y*z + 2.0*z*x;
    a*a == b*b + 2.0*z*(z + y + x);
    a*a == b*b + 2.0*z*a;
    a*a - 2.0*z*a == b*b;
    a*a - 2.0*z*a + z*z == b*b + z*z;
    (a - z)*(a - z) == b*b + z*z;
    (a - z)*(a - z) == b*b + x*y;
    (a - z)*(a - z) == b*b + z*z;
    (a - z)*(a - z) < b*b + y*y + z*z;
    (a - z)*(a - z) < b*b + b*b;
    (a - z)*(a - z) < 2.0*b*b;
    a*a - 2.0*a*z + z*z < 2.0*b*b;
    a*a < 2.0*a*z + 2.0*b*b - z*z;
    a*a < 2.0*a*z + 2.0*b*b - (a - y - x)*(a - y - x);
    a*a < 2.0*a*z + 2.0*b*b - (a*a - 2.0*a*(y + x) + (y + x)*(y + x));
    a*a < 2.0*a*z + 2.0*b*b - a*a + 2.0*a*(y + x) - (y + x)*(y + x);
    2.0*a*a < 2.0*a*z + 2.0*a*(y + x) + 2.0*b*b - (y + x)*(y + x);
    2.0*a*a < 2.0*a*(z + y + x) + 2.0*b*b - (y + x)*(y + x);
    2.0*a*a < 2.0*a*a + 2.0*b*b - (y + x)*(y + x);
    0.0 < 2.0*b*b - (y + x)*(y + x);
    (y + x)*(y + x) < 2.0*b*b;
    y*y + 2.0*y*x + x*x < 2.0*b*b;
    y*y + x*x < 2.0*b*b - 2.0*y*x;
    y*y + x*x < 2.0*b*b - 2.0*z*z;
    y*y + x*x < 2.0*(y*y + z*z + x*x) - 2.0*z*z;
    y*y + x*x < 2.0*y*y + 2.0*x*x;
    0.0 < y*y + x*x;
    0.0 < a;
    b*b < a*a;
    a*a < 3.0*b*b;
  }
}