// Author: Stefan Zetzsche

include "../utils.dfy"

lemma mathd_algebra_69(rows: nat, seats: nat)
  requires rows * seats == 450
  requires (rows+5) * (seats-3) == 450
  ensures rows == 25
{}