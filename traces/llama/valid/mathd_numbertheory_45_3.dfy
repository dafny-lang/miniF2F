include "../utils.dfy"

import opened Utils

lemma mathd_numbertheory_45()
  ensures gcd(6432, 132) + 11 == 23
 {
     calc {
       gcd(6432, 132);
       assert gcd(6432, 132) == 12;
       gcd(6432, 132) + 11;
       assert gcd(6432, 132) + 11 == 12 + 11;
       12 + 11;
       assert 12 + 11 == 23;
     }
   }