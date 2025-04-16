// Author: Stefan Zetzsche

include "../utils.dfy"

lemma amc12a_2002_p1(f: complex -> complex, s: set<complex>)
  requires 
    forall x :: 
      f(x) == 
        Complex.add(
          Complex.mul(
            Complex.add(Complex.mul(Complex.of_real(2.0), x), Complex.of_real(3.0)), 
            Complex.sub(x, Complex.of_real(4.0))
          ),
          Complex.mul(
            Complex.add(Complex.mul(Complex.of_real(2.0), x), Complex.of_real(3.0)),
            Complex.sub(x, Complex.of_real(6.0))
          )
        )
  requires (iset x | x in s :: x) == (iset x | f(x) == Complex.zero() :: x)
  ensures Complex.sum(s, x => x) == Complex.of_real(7.0/2.0)
{}