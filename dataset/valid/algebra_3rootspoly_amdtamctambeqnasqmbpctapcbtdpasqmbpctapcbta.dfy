include "../definitions.dfy"
include "../library.dfy"

lemma algebra_3rootspoly_amdtamctambeqnasqmbpctapcbtdpasqmbpctapcbta(b: complex, c: complex, d: complex, a: complex)
  ensures 
  Complex.mul(Complex.mul(Complex.sub(a, d), Complex.sub(a, c)), Complex.sub(a, b)) == 
  Complex.sub(Complex.mul(Complex.add(Complex.sub(Complex.mul(a,a), Complex.mul(Complex.add(b,c),a)), Complex.mul(c,b)), a),
              Complex.mul(Complex.add(Complex.sub(Complex.mul(a,a), Complex.mul(Complex.add(b,c), a)), Complex.mul(c,b)), d))
{}