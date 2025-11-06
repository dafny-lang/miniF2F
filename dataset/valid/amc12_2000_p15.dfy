// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma amc12_2000_p15(f: complex -> complex, s: set<complex>)
  requires forall x: complex :: f(Complex.div(x, Complex.of_real(3.0))) == Complex.add(Complex.add(Complex.mul(x, x), x), Complex.one())
  requires (iset x | x in s :: x) == (iset x | f(x) == Complex.of_real(7.0)) 
  ensures Complex.sum(s, x => Complex.div(x, Complex.of_real(3.0))) == Complex.of_real(-1.0/9.0)
{}