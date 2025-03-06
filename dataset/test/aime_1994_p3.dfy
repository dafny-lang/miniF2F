// Author: Stefan Zetzsche

include "../utils.dfy"

lemma aime_1994_p3(x: int, f: int -> int)
  requires f(x) + f(x-1) == x*x
  requires f(19) == 94
  ensures f(94) % 1000 == 561
{}