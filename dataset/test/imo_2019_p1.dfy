// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma imo_2019_p1(f: int -> int)
  ensures (forall a, b: int :: f(2*a) + 2*f(b) == f(f(a+b))) <==> ((forall z: int :: f(z) == 0) || (exists c :: (forall z :: f(z) == 2*z + c)))
{}