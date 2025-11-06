// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma mathd_numbertheory_30()
  ensures (33818*33818 + 33819*33819 + 33820*33820 + 33821*33821 + 33822*33822) % 17 == 0
{}