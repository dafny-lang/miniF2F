include "../definitions.dfy"
include "../library.dfy"

lemma algebra_absapbon1pabsapbleqsumabsaon1pabsa(a: real, b: real)
  ensures Real.abs(a+b)/(1.0 + Real.abs(a+b)) <= Real.abs(a)/(1.0 + Real.abs(a)) + Real.abs(b)/(1.0+Real.abs(b))
{}