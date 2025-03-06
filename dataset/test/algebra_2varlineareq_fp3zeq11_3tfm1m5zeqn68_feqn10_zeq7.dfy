include "../utils.dfy"

lemma algebra_2varlineareq_fp3zeq11_3tfm1m5zeqn68_feqn10_zeq7(f: complex, z: complex)
  requires Complex.add(f, Complex.mul(Complex.of_real(3.0), z)) == Complex.of_real(11.0)
  requires Complex.sub(Complex.mul(Complex.of_real(3.0), Complex.sub(f, Complex.one())), Complex.mul(Complex.of_real(5.0), z)) == Complex.of_real(-68.0)
  ensures f == Complex.of_real(-10.0)
  ensures z == Complex.of_real(7.0)
{}