include "../definitions.dfy"
include "../library.dfy"

lemma numbertheory_sqmod4in01d(a: int)
  ensures ((a*a) % 4 == 0) || ((a*a) % 4 == 1)
{}