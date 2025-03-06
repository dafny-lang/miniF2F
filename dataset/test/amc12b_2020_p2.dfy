// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12b_2020_p2()
  ensures ((100*100 - 7*7)) / (70*70 - 11*11) * ((70 - 11) * (70 + 11) / ((100 - 7) * (100 + 7))) == 1
{}