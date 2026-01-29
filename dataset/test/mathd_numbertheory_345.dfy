include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_345()
  ensures (2000 + 2001 + 2002 + 2003 + 2004 + 2005 + 2006) % 7 == 0
{}