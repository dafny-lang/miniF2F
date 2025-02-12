include "../utils.dfy"

import opened Utils

lemma amc12a_2011_p18(x: real, y: real)
  requires abs(x + y) + abs(x - y) == 2.0
  ensures x*x - 6.0*x + y*y <= 9.0
 {
    abs(x + y) + abs(x - y) == 2.0;
    abs(x + y) == x + y || abs(x + y) == -(x + y);
    abs(x - y) == x - y || abs(x - y) == -(x - y);
    if abs(x + y) == x + y && abs(x - y) == x - y {
      x + y + x - y == 2.0;
      2*x == 2.0;
      x == 1.0;
    } else if abs(x + y) == x + y && abs(x - y) == -(x - y) {
      x + y - x + y == 2.0;
      2*y == 2.0;
      y == 1.0;
    } else if abs(x + y) == -(x + y) && abs(x - y) == x - y {
      -x - y + x - y == 2.0;
      -2*y == 2.0;
      y == -1.0;
    } else {
      -x - y - x + y == 2.0;
      -2*x == 2.0;
      x == -1.0;
    }
    if x == 1.0 {
      y*y <= 9.0;
      1.0*1.0 - 6.0*1.0 + y*y <= 9.0;
    } else if x == -1.0 {
      y*y <= 9.0;
      (-1.0)*(-1.0) - 6.0*(-1.0) + y*y <= 9.0;
    } else if y == 1.0 {
      x*x <= 9.0;
      x*x - 6.0*x + 1.0*1.0 <= 9.0;
    } else {
      x*x <= 9.0;
      x*x - 6.0*x + (-1.0)*(-1.0) <= 9.0;
    }
  }