// Author: Stefan Zetzsche

include "../utils.dfy"

lemma imo_1974_p5(a: real, b: real, c: real, d: real, s: real)
  requires a+b+d != 0.0 // added manually
  requires a+b+c != 0.0 // added manually
  requires b+c+d != 0.0 // added manually
  requires a+c+d != 0.0 // added manually
  requires s == a/(a+b+d) + b/(a+b+c) + c/(b+c+d) + d/(a+c+d)
  ensures 1.0 < s < 2.0
{}