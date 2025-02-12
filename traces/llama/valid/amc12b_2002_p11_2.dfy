include "../utils.dfy"

import opened Utils

lemma amc12b_2002_p11(a: nat, b: nat)
  requires prime(a)
  requires prime(b)
  requires prime(a+b)
  requires prime(a-b)
  ensures prime(a + b + a - b + a + b)
 {
     assert a + b + a - b + a + b == 3 * a + b;
     assert 3 * a + b == a + (a + b);
     assert a + b > 2 by {
       assert a >= 2 by { assert a <= 1; assert a >= 2; }
       assert b >= 2 by { assert b <= 1; assert b >= 2; }
       assert a + b >= 2 + 2;
     }
     assert a + b != 2 by {
       assert a + b == 2;
       assert a == 2 && b == 0 || a == 0 && b == 2;
       assert a != 0 && b != 0 by { assert a == 0 || b == 0; }
     }
     assert a + b > 2 && a + b != 2;
     assert exists m :: 2 <= m < a + b && (a + b) % m == 0 by {
       assert a + b == 3;
       assert a == 2 && b == 1 || a == 1 && b == 2;
       assert a != 1 && b != 1 by { assert a == 1 || b == 1; }
       assert a + b != 3;
       assert a + b >= 5;
       assert (a + b) % 2 == 0 || (a + b) % 3 == 0;
       assert (a + b) % 2 != 0 && (a + b) % 3 != 0;
       assert exists m :: 2 <= m < a + b && (a + b) % m == 0;
     }
     assert !prime(a + b);
     assert a + b != a - b;
     assert a != b;
     assert a - b < a + b;
     assert a - b >= 2;
     assert exists m :: 2 <= m < a + b && (a + b) % m == 0;
     assert !prime(a + b);
     assert a + b + a - b + a + b != a + b;
     assert a + b + a - b + a + b == 3 * a + b;
     assert !prime(3 * a + b);
   }