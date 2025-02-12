include "../utils.dfy"

import opened Utils

lemma amc12a_2013_p4()
  ensures (pow(2,2014) as real + pow(2,2012) as real) / (pow(2,2014) as real - pow(2,2012) as real) == 5.0 / 3.0
{}