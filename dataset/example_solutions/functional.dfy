include "../definitions.dfy"
include "../library.dfy"

lemma aime_1988_p8(f: nat -> nat -> real)
  requires forall x: nat | 0 < x :: f(x)(x) == (x as real)
  requires forall x, y: nat | 0 < x && 0 < y :: f(x)(y) == f(y)(x)
  requires forall x, y: nat | 0 < x && 0 < y :: ((x+y) as real)*f(x)(y) == (y as real)*f(x)(x+y)
  ensures f(14)(52) == 364.0
{
  // From the third condition: f(x)(x+y) = ((x+y)/y) * f(x)(y)
  // We can use this to reduce larger arguments to smaller ones

  // First, let's establish that f(x)(y) = xy/(gcd(x,y)) when we can reduce to gcd

  // f(14)(52): gcd(14,52) = gcd(14, 52-3*14) = gcd(14, 10) = gcd(4, 10) = gcd(4, 2) = 2
  // So we want to show f(14)(52) = 14*52/2 = 728/2 = 364

  // Use the recurrence relation from condition 3
  // f(x)(x+y) = ((x+y)/y) * f(x)(y)
  // So f(x)(y) = (y/(x+y)) * f(x)(x+y)

  // Let's work with f(14)(52)
  // 52 = 14 + 38, so we can write:
  // f(14)(52) = f(14)(14+38) = (52/38) * f(14)(38)

  assert f(14)(52) == (52.0/38.0) * f(14)(38);

  // Now f(14)(38): 38 = 14 + 24
  // f(14)(38) = (38/24) * f(14)(24)
  assert f(14)(38) == (38.0/24.0) * f(14)(24);

  // Now f(14)(24): 24 = 14 + 10
  // f(14)(24) = (24/10) * f(14)(10)
  assert f(14)(24) == (24.0/10.0) * f(14)(10);

  // Now f(14)(10): We can use symmetry f(14)(10) = f(10)(14)
  // 14 = 10 + 4, so f(10)(14) = (14/4) * f(10)(4)
  assert f(14)(10) == f(10)(14);
  assert f(10)(14) == (14.0/4.0) * f(10)(4);

  // f(10)(4): Use symmetry f(10)(4) = f(4)(10)
  // 10 = 4 + 6, so f(4)(10) = (10/6) * f(4)(6)
  assert f(10)(4) == f(4)(10);
  assert f(4)(10) == (10.0/6.0) * f(4)(6);

  // f(4)(6): Use symmetry f(4)(6) = f(6)(4)
  // But 6 > 4, so let's use 6 = 4 + 2: f(4)(6) = (6/2) * f(4)(2)
  assert f(4)(6) == (6.0/2.0) * f(4)(2);

  // f(4)(2): Use symmetry f(4)(2) = f(2)(4)
  // 4 = 2 + 2, so f(2)(4) = (4/2) * f(2)(2) = 2 * 2 = 4
  assert f(4)(2) == f(2)(4);
  assert f(2)(4) == (4.0/2.0) * f(2)(2);
  assert f(2)(2) == 2.0;
  assert f(2)(4) == 2.0 * 2.0;
  assert f(2)(4) == 4.0;

  // Now work backwards
  assert f(4)(2) == 4.0;
  assert f(4)(6) == 3.0 * 4.0;
  assert f(4)(6) == 12.0;

  assert f(10)(4) == (10.0/6.0) * 12.0;
  assert f(10)(4) == (5.0/3.0) * 12.0;
  assert f(10)(4) == 20.0;

  assert f(14)(10) == (14.0/4.0) * 20.0;
  assert f(14)(10) == 3.5 * 20.0;
  assert f(14)(10) == 70.0;

  assert f(14)(24) == (24.0/10.0) * 70.0;
  assert f(14)(24) == 2.4 * 70.0;
  assert f(14)(24) == 168.0;

  assert f(14)(38) == (38.0/24.0) * 168.0;
  assert f(14)(38) == (19.0/12.0) * 168.0;
  assert f(14)(38) == 19.0 * 14.0;
  assert f(14)(38) == 266.0;

  assert f(14)(52) == (52.0/38.0) * 266.0;
  assert f(14)(52) == (26.0/19.0) * 266.0;
  assert f(14)(52) == 26.0 * 14.0;
  assert f(14)(52) == 364.0;
}
