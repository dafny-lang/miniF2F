include "../utils.dfy"

import opened Utils

lemma amc12a_2011_p18(x: real, y: real)
  requires abs(x + y) + abs(x - y) == 2.0
  ensures x*x - 6.0*x + y*y <= 9.0
 {
    abs(x + y) + abs(x - y) == 2.0;
    if x + y >= 0.0 {
      if x - y >= 0.0 {
        // x + y >= 0 and x - y >= 0
        // => x >= 0 and y >= 0
        // => x + y == x + y and x - y == x - y
        // => 2x == 2.0
        // => x == 1.0
        // => y == 1.0
        assert x == 1.0;
        assert y == 1.0;
      } else {
        // x + y >= 0 and x - y < 0
        // => x >= 0 and y < 0
        // => x + y == x + y and x - y == -(x - y)
        // => 2y == 2.0
        // => y == 1.0
        // => x == 1.0
        assert x == 1.0;
        assert y == 1.0;
      }
    } else {
      if x - y >= 0.0 {
        // x + y < 0 and x - y >= 0
        // => x < 0 and y < 0
        // => x + y == -(x + y) and x - y == x - y
        // => -2y == 2.0
        // => y == -1.0
        // => x == -1.0
        assert x == -1.0;
        assert y == -1.0;
      } else {
        // x + y < 0 and x - y < 0
        // => x < 0 and y < 0
        // => x + y == -(x + y) and x - y == -(x - y)
        // => -2x == 2.0
        // => x == -1.0
        // => y == -1.0
        assert x == -1.0;
        assert y == -1.0;
      }
    }
    // x == 1.0 and y == 1.0 or x == -1.0 and y == -1.0
    // => x*x - 6.0*x + y*y <= 9.0
  }