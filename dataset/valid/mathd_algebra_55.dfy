// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_algebra_55(q: real, p: real)
  requires q == 2.0 - 4.0 + 6.0 - 8.0 + 10.0 - 12.0 + 14.0
  requires p == 3.0 - 6.0 + 9.0 - 12.0 + 15.0 - 18.0 + 21.0
  ensures q / p == 2.0 / 3.0
{}