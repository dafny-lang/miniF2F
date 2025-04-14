// Author: Stefan Zetzsche

include "../utils.dfy"

lemma algebra_cubrtrp1oncubrtreq3_rcubp1onrcubeq5778(r: real)
  requires r != 0.0
  requires Real.rpow(r, 1.0/3.0) + 1.0/Real.rpow(r, 1.0/3.0) == 3.0
  ensures Real.rpow(r, 3.0) + 1.0/Real.rpow(r, 3.0) == 5778.0
{}