include "../utils.dfy"

lemma algebra_xmysqpymzsqpzmxsqeqxyz_xpypzp6dvdx3y3z3(x: int, y: int, z: int)
  requires (x-y)*(x-y) + (y-z)*(y-z) + (z-x)*(z-x) == x*y*z
  ensures (x*x*x + y*y*y + z*z*z) % (x+y+z+6) == 0
{}