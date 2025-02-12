include "../utils.dfy"

import opened Utils

lemma amc12b_2002_p11(a: nat, b: nat)
  requires prime(a)
  requires prime(b)
  requires prime(a+b)
  requires prime(a-b)
  ensures prime(a + b + a - b + a + b)
 {
     assert a + b + a - b + a + b == 3 * a + 2 * b;
     assert 2 <= 3 * a + 2 * b;
     assert 3 * a + 2 * b % 2 != 0;
     assert 3 * a + 2 * b % 3 != 0;
     assert 3 * a + 2 * b % 5 != 0;
     assert 3 * a + 2 * b % 7 != 0;
     assert 3 * a + 2 * b % 11 != 0;
     assert 3 * a + 2 * b % 13 != 0;
     assert 3 * a + 2 * b % 17 != 0;
     assert 3 * a + 2 * b % 19 != 0;
     assert 3 * a + 2 * b % 23 != 0;
     assert 3 * a + 2 * b % 29 != 0;
     assert 3 * a + 2 * b % 31 != 0;
     assert 3 * a + 2 * b % 37 != 0;
     assert 3 * a + 2 * b % 41 != 0;
     assert 3 * a + 2 * b % 43 != 0;
     assert 3 * a + 2 * b % 47 != 0;
     assert 3 * a + 2 * b % 53 != 0;
     assert 3 * a + 2 * b % 59 != 0;
     assert 3 * a + 2 * b % 61 != 0;
     assert 3 * a + 2 * b % 67 != 0;
     assert 3 * a + 2 * b % 71 != 0;
     assert 3 * a + 2 * b % 73 != 0;
     assert 3 * a + 2 * b % 79 != 0;
     assert 3 * a + 2 * b % 83 != 0;
     assert 3 * a + 2 * b % 89 != 0;
     assert 3 * a + 2 * b % 97 != 0;
     assert 3 * a + 2 * b % 101 != 0;
     assert 3 * a + 2 * b % 103 != 0;
     assert 3 * a + 2 * b % 107 != 0;
     assert 3 * a + 2 * b % 109 != 0;
     assert 3 * a + 2 * b % 113 != 0;
     assert forall m :: 2 <= m < 3 * a + 2 * b  && m % 2 != 0 && m % 3 != 0 && m % 5 != 0 && m % 7 != 0 && m % 11 != 0 && m % 13 != 0 && m % 17 != 0 && m % 19 != 0 && m % 23 != 0 && m % 29 != 0 && m % 31 != 0 && m % 37 != 0 && m % 41 != 0 && m % 43 != 0 && m % 47 != 0 && m % 53 != 0 && m % 59 != 0 && m % 61 != 0 && m % 67 != 0 && m % 71 != 0 && m % 73 != 0 && m % 79 != 0 && m % 83 != 0 && m % 89 != 0 && m % 97 != 0 && m % 101 != 0 && m % 103 != 0 && m % 107 != 0 && m % 109 != 0 && m % 113 != 0  => (3 * a + 2 * b) % m != 0;
     assert prime(3 * a + 2 * b);
     }
     assert prime(a + b + a - b + a + b);