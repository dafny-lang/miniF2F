// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12_2001_p5()
  ensures Int.prod(filter((x: int) => x % 2 != 0, range(10000)), (x: int) => x) == factorial(10000)/(Int.pow(2, 5000)*factorial(5000))
{}