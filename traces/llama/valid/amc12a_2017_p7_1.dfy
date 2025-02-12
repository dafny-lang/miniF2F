include "../utils.dfy"

import opened Utils

lemma amc12a_2017_p7(f: nat -> real)
  requires f(1) == 2.0
  requires forall n :: 1 < n && n % 2 == 0 ==> f(n) == f(n-1) + 1.0
  requires forall n :: 1 < n && n % 2 == 1 ==> f(n) == f(n-2) + 2.0
  ensures f(2017) == 2018.0
 {
     assert f(1) == 2.0;
     assert f(2) == f(1) + 1.0 == 3.0;
     assert f(3) == f(1) + 2.0 == 4.0;
     var n := 4;
     while n <= 2017
     invariant f(1) == 2.0
     invariant f(2) == 3.0
     invariant f(3) == 4.0
     invariant forall i | 4 <= i < n && i % 2 == 0 ==> f(i) == f(i-1) + 1.0
     invariant forall i | 4 <= i < n && i % 2 == 1 ==> f(i) == f(i-2) + 2.0
     {
       if n % 2 == 0 {
         assert f(n) == f(n-1) + 1.0;
       } else {
         assert f(n) == f(n-2) + 2.0;
       }
       n := n + 1;
     }
     assert f(2017) == 2018.0;
   }