// Author: Stefan Zetzsche

include "../definitions.dfy"
include "../library.dfy"

lemma algebraic_manipulation(x: int, y: int)
  requires y*y + 3*x*x*y*y == 30*x*x + 517
  ensures y*y*(1 + 3*x*x) == 30*x*x + 517
{
  calc {
    y*y + 3*x*x*y*y;
    == y*y*(1 + 3*x*x);
  }
}

lemma check_x_zero(x: int, y: int)
  requires y*y + 3*x*x*y*y == 30*x*x + 517
  requires x == 0
  ensures false
{
  assert y*y == 517;
  // 517 = 11 * 47, so it's not a perfect square
  // We can verify this by checking that no integer squared equals 517
  assert 22*22 == 484 < 517;
  assert 23*23 == 529 > 517;
  // So no integer y satisfies y*y == 517
}

lemma check_x_one(x: int, y: int)
  requires y*y + 3*x*x*y*y == 30*x*x + 517
  requires x*x == 1
  ensures false
{
  assert y*y + 3*y*y == 30 + 517;
  assert 4*y*y == 547;
  // 547 is not divisible by 4 since 547 = 4*136 + 3
  assert 547 % 4 == 3;
  // So no integer y satisfies 4*y*y == 547
}

lemma check_x_two(x: int, y: int)
  requires y*y + 3*x*x*y*y == 30*x*x + 517
  requires x*x == 4
  ensures y*y == 49
{
  assert y*y + 3*4*y*y == 30*4 + 517;
  assert y*y + 12*y*y == 120 + 517;
  assert 13*y*y == 637;
  assert y*y == 49;
}

lemma check_x_three(x: int, y: int)
  requires y*y + 3*x*x*y*y == 30*x*x + 517
  requires x*x == 9
  ensures false
{
  algebraic_manipulation(x, y);
  assert y*y*(1 + 27) == 270 + 517;
  assert y*y*28 == 787;
  // 787 is not divisible by 28
  assert 787 == 28*28 + 3;
  assert 787 % 28 != 0;
}

lemma check_large_x(x: int, y: int)
  requires y*y + 3*x*x*y*y == 30*x*x + 517
  requires x*x >= 16
  ensures false
{
  algebraic_manipulation(x, y);
  var factor := 1 + 3*x*x;
  assert factor >= 1 + 3*16;
  assert factor >= 49;

  // We have y*y*factor == 30*x*x + 517
  // For y != 0, we need y*y >= 1, so factor <= 30*x*x + 517

  if y == 0 {
    assert 0 == 30*x*x + 517;
    assert false; // 30*x*x + 517 > 0
  } else {
    assert y*y >= 1;
    assert factor <= 30*x*x + 517;
    assert 1 + 3*x*x <= 30*x*x + 517;
    assert 1 <= 27*x*x + 517;
    // This is always true, so we need a different approach

    // Let's use the fact that 30*x*x + 517 must be divisible by 1 + 3*x*x
    // We can write: 30*x*x + 517 = 10*(1 + 3*x*x) + (517 - 10)
    assert 30*x*x + 517 == 10*(1 + 3*x*x) + 507;

    // So we need (1 + 3*x*x) to divide 507
    // 507 = 3 * 169 = 3 * 13^2
    // For x*x >= 16, we have 1 + 3*x*x >= 49
    // The divisors of 507 that are >= 49 are: 169, 507

    if factor == 169 {
      assert 1 + 3*x*x == 169;
      assert 3*x*x == 168;
      assert x*x == 56;
      // 56 is not a perfect square (7^2 = 49, 8^2 = 64)
      assert false;
    } else if factor == 507 {
      assert 1 + 3*x*x == 507;
      assert 3*x*x == 506;
      // 506/3 is not an integer
      assert false;
    } else {
      // factor must divide 507 but we've checked all possibilities >= 49
      assert false;
    }
  }
}

lemma aime_1987_p5(x: int, y: int)
  requires y*y + 3*x*x*y*y == 30*x*x + 517
  ensures 3*x*x*y*y == 588
{
  // Case analysis on x*x
  if x*x == 0 {
    check_x_zero(x, y);
    assert false;
  } else if x*x == 1 {
    check_x_one(x, y);
    assert false;
  } else if x*x == 4 {
    check_x_two(x, y);
    assert y*y == 49;
    calc {
      3*x*x*y*y;
      == 3*4*49;
      == 588;
    }
  } else if x*x == 9 {
    check_x_three(x, y);
    assert false;
  } else {
    assert x*x >= 16;
    check_large_x(x, y);
    assert false;
  }
}
