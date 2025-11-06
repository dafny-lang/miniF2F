// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma aime_1987_p5(x: int, y: int)
  requires y*y + 3*x*x*y*y == 30*x*x + 517
  ensures 3*x*x*y*y == 588
{}