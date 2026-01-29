include "../definitions.dfy"
include "../library.dfy"

lemma aime_1984_p15(x: real, y: real, z: real, w: real)
  requires (Real.pow(x,2) / (Real.pow(2.0,2) - 1.0)) + (Real.pow(y,2) / (Real.pow(2.0,2) - Real.pow(3.0,2))) + (Real.pow(z,2) / (Real.pow(2.0,2) - Real.pow(5.0,2))) + (Real.pow(w,2) / (Real.pow(2.0,2) - Real.pow(7.0,2))) == 1.0
  requires (Real.pow(x,2) / (Real.pow(4.0,2) - 1.0)) + (Real.pow(y,2) / (Real.pow(4.0,2) - Real.pow(3.0,2))) + (Real.pow(z,2) / (Real.pow(4.0,2) - Real.pow(5.0,2))) + (Real.pow(w,2) / (Real.pow(4.0,2) - Real.pow(7.0,2))) == 1.0
  requires (Real.pow(x,2) / (Real.pow(6.0,2) - 1.0)) + (Real.pow(y,2) / (Real.pow(6.0,2) - Real.pow(3.0,2))) + (Real.pow(z,2) / (Real.pow(6.0,2) - Real.pow(5.0,2))) + (Real.pow(w,2) / (Real.pow(6.0,2) - Real.pow(7.0,2))) == 1.0
  requires (Real.pow(x,2) / (Real.pow(8.0,2) - 1.0)) + (Real.pow(y,2) / (Real.pow(8.0,2) - Real.pow(3.0,2))) + (Real.pow(z,2) / (Real.pow(8.0,2) - Real.pow(5.0,2))) + (Real.pow(w,2) / (Real.pow(8.0,2) - Real.pow(7.0,2))) == 1.0
  ensures Real.pow(x,2) + Real.pow(y,2) + Real.pow(z,2) + Real.pow(w,2) == 36.0
{}

