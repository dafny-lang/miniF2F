// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_absapbon1pabsapbleqsumabsaon1pabsa(a: real, b: real)
  ensures abs(a+b)/(1.0 + abs(a+b)) <= abs(a)/(1.0 + abs(a)) + abs(b)/(1.0+abs(b))
{}