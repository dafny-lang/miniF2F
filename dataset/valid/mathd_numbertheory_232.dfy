// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_numbertheory_232(x: int, y: int, z: int)
  requires 0 <= x < 31
  requires 0 <= y < 31
  requires 0 <= z < 31
  requires (x*3) % 31 == 1
  requires (y*5) % 31 == 1
  requires (z*(x+y)) % 31 == 1
  ensures z == 29
{}