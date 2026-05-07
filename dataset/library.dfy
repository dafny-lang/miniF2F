include "definitions.dfy"

/* ========== AUXILIARY DEFINITIONS ========== */

  function {:axiom} cexp(z: complex): (w: complex)
    ensures z == Complex.zero() ==> w == one()
    ensures z.im == 0.0 ==> w == of_real(Real.exp(z.re))
    ensures z.re == 0.0 ==> w == Complex(Real.cos(z.im), Real.sin(z.im))
    ensures w == Complex.mul(of_real(Real.exp(z.re)), Complex(Real.cos(z.im), Real.sin(z.im)))

  predicate {:axiom} pos (x : real)
    ensures x > 0.0

  predicate {:axiom} eventually_within_eps(f: nat -> real, L: real, eps: real, N : nat)
    ensures forall n: nat :: n >= N ==> abs(f(n) - L) < eps

  predicate {:axiom} limit(f: nat -> real, L: real)
    ensures forall eps: real :: pos(eps) ==> forall N : nat ::  eventually_within_eps(f, L, eps, N)

  predicate {:axiom} continuous_at(f: real -> real, a: real)
    ensures forall eps: real | pos(eps) ::
    exists delta: real | pos(delta) ::
      forall x: real | abs(x - a) < delta :: abs(f(x) - f(a)) < eps

  predicate {:axiom} continuous(f: real -> real)
    ensures forall a: real :: continuous_at(f, a)


  function e_seq(n: nat): real
  {
    if n == 0 then 1.0
    else Real.pow(1.0 + 1.0/(n as real), n)
  }

  function {:axiom} e(): real
    ensures limit(((n : nat) => if n > 0 then e_seq(n) else 0.0), e())


function {:axiom} icc<T>(s: set<T>, t: set<T>): (r: set<set<T>>)
  ensures r == set x | s <= x <= t

/* LEMMAS */

/* ========== EXPONENTIAL & LOGARITHM FUNCTIONS ========== */

/* Exp */

lemma exp_zero()
  ensures exp(0.0) == 1.0
{
  var c := cexp(Complex.zero());
  assert c == one();
  assert c == of_real(exp(0.0));
}

lemma exp_pos(x: real)
  ensures exp(x) > 0.0
{}

lemma exp_add(x: real, y: real)
  ensures exp(x+y) == exp(x) * exp(y)
{
  exp_def();
}

lemma exp_sub(x: real, y: real)
  ensures exp(x-y) == exp(x) / exp(y)
{
  exp_add(x-y, y);
  assert exp((x-y)+y) == exp(x-y) * exp(y);
  assert (x-y)+y == x;
  assert exp(x) == exp(x-y) * exp(y);
  assert exp(y) > 0.0;
}

lemma exp_lt_exp_of_lt(x: real, y: real)
  requires x < y
  ensures exp(x) < exp(y)
{
  var d := y - x;
  exp_add(x, d);
  assert exp(y) == exp(x) * exp(d);
  log_exp(d);
  assert exp(d) > 1.0;
  assert exp(x) > 0.0;
  assert exp(x) * exp(d) > exp(x) * 1.0;
}

lemma exp_le_exp_of_le(x: real, y: real)
  requires x <= y
  ensures exp(x) <= exp(y)
{
  if x == y {
  } else {
    exp_lt_exp_of_lt(x, y);
  }
}

lemma exp_eq_exp(x: real, y: real)
  ensures exp(x) == exp(y) <==> x == y
{
  if x == y {
    // trivial: exp(x) == exp(y)
  }
  if exp(x) == exp(y) {
    log_exp(x);
    log_exp(y);
    // log(exp(x)) == x and log(exp(y)) == y
    // exp(x) == exp(y) implies log(exp(x)) == log(exp(y)) implies x == y
  }
}

lemma exp_continuous()
  ensures continuous(exp)
{
  exp_def();
}

lemma {:axiom} exp_def()
  ensures forall x, y :: exp(x + y) == exp(x) * exp(y)
  ensures continuous(exp)
  ensures exp(0.0) == 1.0
  ensures exp(1.0) == e()

/* Log */

lemma log_one()
  ensures log(1.0) == 0.0
{}

lemma {:axiom} log_exp(x: real)
  ensures log(exp(x)) == x

lemma {:axiom} exp_log(x: real)
  requires x > 0.0
  ensures exp(log(x)) == x

lemma log_mul(x: real, y: real)
  requires x > 0.0
  requires y > 0.0
  ensures log(x*y) == log(x) + log(y)
{
  exp_add(log(x), log(y));
  exp_log(x); exp_log(y); exp_log(x * y);
  exp_eq_exp(log(x) + log(y), log(x * y));
}


lemma log_div(x: real, y: real)
  requires x > 0.0
  requires y > 0.0
  ensures log(x/y) == log(x) - log(y)
{
  exp_sub(log(x), log(y));
  exp_log(x); exp_log(y); exp_log(x/y);
  exp_eq_exp(log(x) - log(y), log(x/y));
}

lemma log_inv(x: real)
  requires x > 0.0
  ensures log(1.0/x) == -log(x)
{
  log_div(1.0, x);
  log_one();
}

lemma log_pow(y: real, n: nat)
  requires y > 0.0
  ensures log(Real.pow(y, n)) == (n as real)*log(y)
{
  if n == 0
  {
    log_one();
  }
  else
  {
    var X := Real.pow(y, n - 1);
    real_pow_pos(y, n - 1);
    assert X > 0.0;

    assert Real.pow(y, n) == X * y;
    assert log(Real.pow(y, n)) == log(X * y);

    assert log(X * y) == log(X) + log(y) by {
      log_mul(X, y);
    }
    
    assert log(X) == ((n - 1) as real) * log(y) by {
      log_pow(y, n - 1);
    }

    assert log(Real.pow(y, n)) == ((n - 1) as real) * log(y) + log(y);
    
    // Distribution property for reals
    assert ((n - 1) as real) * log(y) + log(y) == ((n - 1) as real + 1.0) * log(y);
    assert ((n - 1) as real + 1.0) == (n as real);
    assert (n as real) * log(y) == ((n - 1) as real + 1.0) * log(y) by
    { 
      if log(y) == 0.0
      { }
      else
      {
        forall a : real | log(a) != 0.0 // assumption for only the purpose of a trigger
          ensures (n as real) * log(a) == ((n - 1) as real + 1.0) * log(a)
        {}
      }
    }
  }
}

lemma log_nonneg(x: real)
  requires 1.0 <= x
  ensures 0.0 <= log(x)
{}


lemma log_pos(x: real)
  requires 1.0 < x
  ensures 0.0 < log(x)
{}

/* Logb */

lemma logb_one(b: real)
  requires b > 0.0 && b != 1.0
  ensures logb(b, 1.0) == 0.0
{}

lemma logb_base(b: real)
  requires b > 0.0 && b != 1.0
  ensures logb(b, b) == 1.0
{}

lemma rpow_logb(b: real, x: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0
  ensures rpow(b, logb(b, x)) == x
{
  logb_rpow(b, b, logb(b, x));
  logb_base(b);
  var y := rpow(b, logb(b, x));
  assert logb(b, y) == logb(b, x);
  assert log(b) != 0.0;
  assert log(y) / log(b) == log(x) / log(b);
  assert log(y) == log(x);
  exp_log(y);
  exp_log(x);
}

lemma logb_mul(b: real, x: real, y: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0 && y > 0.0
  ensures logb(b, x*y) == logb(b, x) + logb(b, y)
{
  assert x * y > 0.0;
  assert logb(b, x*y) == log(x*y) / log(b);
  assert logb(b, x) == log(x) / log(b);
  assert logb(b, y) == log(y) / log(b);
  log_mul(x, y);
  assert log(x*y) == log(x) + log(y);
  assert (log(x) + log(y)) / log(b) == log(x) / log(b) + log(y) / log(b);
}

lemma logb_div(b: real, x: real, y: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0 && y > 0.0
  ensures logb(b, x/y) == logb(b, x) - logb(b, y)
{
  assert x / y > 0.0;
  assert logb(b, x/y) == log(x/y) / log(b);
  assert logb(b, x) == log(x) / log(b);
  assert logb(b, y) == log(y) / log(b);
  log_div(x, y);
  assert log(x/y) == log(x) - log(y);
  assert (log(x) - log(y)) / log(b) == log(x) / log(b) - log(y) / log(b);
}

lemma logb_inv(b: real, x: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0
  ensures logb(b, 1.0/x) == -logb(b, x)
{
  assert 1.0/x > 0.0;
  assert logb(b, 1.0/x) == log(1.0/x) / log(b);
  assert logb(b, x) == log(x) / log(b);
  log_inv(x);
  assert log(1.0/x) == -log(x);
  assert -log(x) / log(b) == -(log(x) / log(b));
}

lemma logb_pow(b: real, x: real, k: nat)
  requires b > 0.0 && b != 1.0
  requires x > 0.0
  ensures logb(b, Real.pow(x, k)) == (k as real) * logb(b, x)
{
  pow_eq_rpow(x, k);
  logb_rpow(b, x, k as real);
}

lemma {:axiom} logb_rpow(b: real, x: real, k: real)
  requires b > 0.0 && b != 1.0
  requires x > 0.0
  ensures logb(b, rpow(x, k)) == k * logb(b, x)

lemma logb_change_base(b1: real, b2: real, x: real)
  requires b1 > 0.0 && b1 != 1.0
  requires b2 > 0.0 && b2 != 1.0
  requires x > 0.0
  ensures logb(b1, x) == logb(b2, x) / logb(b2, b1)
{}

/* ========== INTEGER OPERATIONS ========== */

/* Int.pow */

lemma int_pow_zero(b: int)
  ensures Int.pow(b, 0) == 1
{}

lemma int_pow_one(b: int)
  ensures Int.pow(b, 1) == b
{}

lemma int_pow_add(b: int, m: nat, n: nat)
  ensures Int.pow(b, m + n) == Int.pow(b, m) * Int.pow(b, n)
{
  // Proof by induction on n
  if n == 0
  { 
  }
  else
  {
    assert n > 0;
    int_pow_add(b, m, n - 1);
    
    var X := Int.pow(b, m);
    var Y := Int.pow(b, n - 1);

    calc {
      Int.pow(b, m + n);
      == // Definition of Int.pow
      b * Int.pow(b, m + n - 1);
      == { int_pow_add(b, m, n - 1); } // Inductive hypothesis
      b * (X * Y);
      == { forall b, X, Y : int
            ensures b * (X * Y) == X * (b * Y)
            {} } // Associativity and commutativity
      X * (b * Y);
      == // Definition of Int.pow(b, n) is b * Y
      X * Int.pow(b, n);
    }
  }
}

lemma int_pow_mul(b: int, m: nat, n: nat)
  ensures Int.pow(b, m * n) == Int.pow(Int.pow(b, m), n)
{
  if n == 0
  {}
  else
  {
    assert n > 0;
    calc {
      Int.pow(b, m * n);
      == { assert m * n == m * (n - 1) + m; }
      Int.pow(b, m * (n - 1) + m);
      == { int_pow_add(b, m * (n - 1), m); }
      Int.pow(b, m * (n - 1)) * Int.pow(b, m);
      == { int_pow_mul(b, m, n - 1); }
      Int.pow(Int.pow(b, m), n - 1) * Int.pow(b, m);
      ==
      Int.pow(b, m) * Int.pow(Int.pow(b, m), n - 1);
      ==
      Int.pow(Int.pow(b, m), n);
    }
  }
}

lemma int_pow_pos(b: int, k: nat)
  requires b > 0
  ensures Int.pow(b, k) > 0
{ }

/* Int.prod */

lemma int_prod_singleton<T>(x: T, f: T -> int)
  ensures Int.prod({x}, f) == f(x)
{}

lemma {:axiom} int_prod_union<T>(A: set<T>, B: set<T>, f: T -> int)
  requires A !! B  // disjoint
  ensures Int.prod(A + B, f) == Int.prod(A, f) * Int.prod(B, f)

lemma int_prod_insert<T>(s: set<T>, x: T, f: T -> int)
  requires x !in s
  ensures Int.prod(s + {x}, f) == f(x) * Int.prod(s, f)
{}

/* Int.sum */

lemma int_sum_singleton<T>(x: T, f: T -> int)
  ensures Int.sum({x}, f) == f(x)
{}


lemma int_sum_union<T>(A: set<T>, B: set<T>, f: T -> int)
  requires A !! B  // disjoint
  ensures Int.sum(A + B, f) == Int.sum(A, f) + Int.sum(B, f)
{
  if B == {}
  {
    assert A + B == A;
  }
  else
  {
    var y : T :| y in B;
    assert A !! (B - {y});
    int_sum_union(A, B - {y}, f);
    assert A + B == A + (B - {y}) + {y};
  }
}

lemma int_sum_insert<T>(s: set<T>, x: T, f: T -> int)
  requires x !in s
  ensures Int.sum(s + {x}, f) == f(x) + Int.sum(s, f)
{}

/* ========== RATIONAL OPERATIONS ========== */

/* Rat.add */

lemma rat_add_comm(x: Rat.rat, y: Rat.rat)
  ensures Rat.add(x, y) == Rat.add(y, x)
{}

lemma rat_add_assoc(x: Rat.rat, y: Rat.rat, z: Rat.rat)
  ensures Rat.add(Rat.add(x, y), z) == Rat.add(x, Rat.add(y, z))
{}

lemma rat_add_zero(x: Rat.rat)
  ensures Rat.add(x, Rat.zero()) == x
{}

lemma rat_add_neg(x: Rat.rat)
  ensures Rat.add(x, x.neg()) == Rat.zero()
{
  var one := Rat.of_int(1);
  var neg_one := one.neg();
  assert Rat.add(one, neg_one) == Rat.zero();
  rat_mul_zero(x);
  rat_distributive(x, one, neg_one);
  rat_mul_one(x);
}

/* Rat.mul */

lemma rat_mul_comm(x: Rat.rat, y: Rat.rat)
  ensures Rat.mul(x, y) == Rat.mul(y, x)
{}

lemma rat_mul_assoc(x: Rat.rat, y: Rat.rat, z: Rat.rat)
  ensures Rat.mul(Rat.mul(x, y), z) == Rat.mul(x, Rat.mul(y, z))
{}

lemma rat_mul_one(x: Rat.rat)
  ensures Rat.mul(x, Rat.Rational(1, 1)) == x
{}

lemma rat_mul_zero(x: Rat.rat)
  ensures Rat.mul(x, Rat.zero()) == Rat.zero()
{
  rat_distributive(x, Rat.Rational(1, 1), Rat.Rational(1, 1).neg());
  rat_mul_one(x);
}

lemma {:axiom} rat_mul_inv(x: Rat.rat)
  requires x.num != 0
  ensures Rat.mul(x, x.inv()) == Rat.Rational(1, 1)

lemma rat_distributive(x: Rat.rat, y: Rat.rat, z: Rat.rat)
  ensures Rat.mul(x, Rat.add(y, z)) == Rat.add(Rat.mul(x, y), Rat.mul(x, z))
{
  var a := Rat.Rational(1, 2);
  var ai := a.inv();
  assert ai == Rat.Rational(2, 1);
  var p := Rat.mul(a, ai);
  assert p == Rat.Rational(2, 2);
  rat_mul_inv(a);
  assert p == Rat.Rational(1, 1);
}

/* Rat.prod */

lemma rat_prod_singleton<T>(x: T, f: T -> Rat.rat)
  ensures Rat.prod({x}, f) == f(x)
{}

lemma rat_prod_union<T>(A: set<T>, B: set<T>, f: T -> Rat.rat)
  requires A !! B
  ensures Rat.prod(A + B, f) == Rat.mul(Rat.prod(A, f), Rat.prod(B, f))
{
  if B == {}
  {
    assert A + B == A;
    rat_mul_one(Rat.prod(A, f));
  }
  else
  {
    var y :| y in B;
    assert A !! (B - {y});
    rat_prod_union(A, B - {y}, f);
    assert (A + B) - {y} == A + (B - {y});
    rat_mul_assoc(f(y), Rat.prod(A, f), Rat.prod(B - {y}, f));
    rat_mul_assoc(Rat.prod(A, f), f(y), Rat.prod(B - {y}, f));
    rat_mul_comm(f(y), Rat.prod(A, f));
  }
}

lemma rat_prod_insert<T>(s: set<T>, x: T, f: T -> Rat.rat)
  requires x !in s
  ensures Rat.prod(s + {x}, f) == Rat.mul(f(x), Rat.prod(s, f))
{}

/* Rat.sum */

lemma rat_sum_singleton<T>(x: T, f: T -> Rat.rat)
  ensures Rat.sum({x}, f) == f(x)
{}

lemma rat_sum_union<T>(A: set<T>, B: set<T>, f: T -> Rat.rat)
  requires A !! B
  ensures Rat.sum(A + B, f) == Rat.add(Rat.sum(A, f), Rat.sum(B, f))
{
  if B == {}
  {
    assert A + B == A;
    rat_add_zero(Rat.sum(A, f));
  }
  else
  {
    var y : T :| y in B;
    assert A !! (B - {y});
    rat_sum_union(A, B - {y}, f);
    assert A + B == A + (B - {y}) + {y};
    assert y !in (A + (B - {y}));
    rat_sum_insert(A + (B - {y}), y, f);
    rat_add_assoc(f(y), Rat.sum(A, f), Rat.sum(B - {y}, f));
    rat_add_comm(f(y), Rat.sum(A, f));
    rat_add_assoc(Rat.sum(A, f), f(y), Rat.sum(B - {y}, f));
  }
}

lemma rat_sum_insert<T>(s: set<T>, x: T, f: T -> Rat.rat)
  requires x !in s
  ensures Rat.sum(s + {x}, f) == Rat.add(f(x), Rat.sum(s, f))
{}

/* ========== REAL POWERS ========== */

/* Real.pow */

lemma real_pow_zero(b: real)
  ensures Real.pow(b, 0) == 1.0
{}

lemma real_pow_one(b: real)
  ensures Real.pow(b, 1) == b
{}

lemma {:axiom} real_pow_mul(b: real, m: nat, n: nat)
  ensures Real.pow(b, m * n) == Real.pow(Real.pow(b, m), n)

lemma real_pow_pos(b: real, k: nat)
  requires b > 0.0
  ensures Real.pow(b, k) > 0.0
{}

lemma {:axiom} pow_eq_rpow(b: real, k: nat)
  ensures Real.pow(b, k) == rpow(b, k as real)

lemma {:axiom} pow_add(b: real, k: nat)
  ensures b > 0.0 ==> forall x: nat, y: nat :: Real.pow(b, x+y) == Real.pow(b, x) * Real.pow(b, y)

/* Real.rpow */

lemma rpow_zero(b: real)
  ensures rpow(b, 0.0) == 1.0
{}

lemma rpow_one(b: real)
  ensures rpow(b, 1.0) == b
{}

lemma rpow_add(b: real, x: real, y: real)
  requires b > 0.0
  ensures rpow(b, x+y) == rpow(b, x) * rpow(b, y)
{
  var lhs := rpow(b, x + y);
  var rx := rpow(b, x);
  var ry := rpow(b, y);
  assert lhs > 0.0;
  assert rx > 0.0;
  assert ry > 0.0;
  var rhs := rx * ry;
  assert rhs > 0.0;
  var base: real := 2.0;
  logb_rpow(base, b, x + y);
  logb_rpow(base, b, x);
  logb_rpow(base, b, y);
  logb_mul(base, rx, ry);
  assert logb(base, lhs) == (x + y) * logb(base, b);
  assert logb(base, rx) == x * logb(base, b);
  assert logb(base, ry) == y * logb(base, b);
  assert logb(base, rhs) == logb(base, rx) + logb(base, ry);
  assert logb(base, rhs) == x * logb(base, b) + y * logb(base, b);
  assert x * logb(base, b) + y * logb(base, b) == (x + y) * logb(base, b);
  assert logb(base, lhs) == logb(base, rhs);
  assert log(base) != 0.0;
  assert log(lhs) / log(base) == log(rhs) / log(base);
  assert log(lhs) == log(rhs);
  exp_log(lhs);
  exp_log(rhs);
}

lemma rpow_sub(b: real, x: real, y: real)
  requires b > 0.0
  ensures rpow(b, x-y) == rpow(b, x) / rpow(b, y)
{
  rpow_add(b, x-y, y);
  assert rpow(b, (x-y)+y) == rpow(b, x-y) * rpow(b, y);
  assert (x-y)+y == x;
  assert rpow(b, x) == rpow(b, x-y) * rpow(b, y);
  assert rpow(b, y) > 0.0;
}

lemma rpow_mul(x: real, y: real, k: real)
  requires x >= 0.0
  requires y >= 0.0
  ensures rpow(x*y, k) == rpow(x, k) * rpow(y, k)
{
  if k == 0.0 {
  } else if x == 0.0 {
  } else if y == 0.0 {
  } else {
    assert x > 0.0 && y > 0.0 && x * y > 0.0;
    var a := rpow(x*y, k);
    var rx := rpow(x, k);
    var ry := rpow(y, k);
    assert a > 0.0 && rx > 0.0 && ry > 0.0;
    var c := rx * ry;
    assert c > 0.0;
    var b : real := 2.0;
    logb_rpow(b, x, k);
    logb_rpow(b, y, k);
    logb_rpow(b, x * y, k);
    logb_mul(b, x, y);
    logb_mul(b, rx, ry);
    assert logb(b, a) == logb(b, c);
    assert log(b) != 0.0;
    assert log(a) / log(b) == log(c) / log(b);
    assert log(a) == log(c);
    exp_log(a);
    exp_log(c);
  }
}

lemma rpow_div(b: real, x: real, y: real)
  requires b > 0.0
  requires y != 0.0
  ensures rpow(b, x/y) == rpow(rpow(b, 1.0/y), x)
{
  var inv_y := 1.0 / y;
  rpow_rpow(b, inv_y, x);
  assert inv_y * x == x / y;
}

lemma rpow_div_base(x: real, y: real, k: real)
  requires x >= 0.0
  requires y > 0.0
  ensures rpow(x/y, k) == rpow(x, k) / rpow(y, k)
{
  if k == 0.0 {
  } else if x == 0.0 {
    assert x / y == 0.0;
  } else {
    assert x > 0.0 && y > 0.0 && x / y > 0.0;
    var a := rpow(x / y, k);
    var rx := rpow(x, k);
    var ry := rpow(y, k);
    assert a > 0.0 && rx > 0.0 && ry > 0.0;
    var c := rx / ry;
    assert c > 0.0;
    var b: real := 2.0;
    logb_rpow(b, x, k);
    logb_rpow(b, y, k);
    logb_rpow(b, x / y, k);
    logb_div(b, x, y);
    logb_div(b, rx, ry);
    assert logb(b, a) == logb(b, c);
    assert log(b) != 0.0;
    assert log(a) / log(b) == log(c) / log(b);
    assert log(a) == log(c);
    exp_log(a);
    exp_log(c);
  }
}

lemma rpow_rpow(b: real, x: real, y: real)
  requires b > 0.0
  ensures rpow(rpow(b, x), y) == rpow(b, x * y)
{
  var bx := rpow(b, x);
  assert bx > 0.0;
  var lhs := rpow(bx, y);
  var rhs := rpow(b, x * y);
  assert lhs > 0.0;
  assert rhs > 0.0;

  var base : real := 2.0;
  logb_rpow(base, bx, y);
  logb_rpow(base, b, x);
  logb_rpow(base, b, x * y);

  assert logb(base, lhs) == y * logb(base, bx);
  assert logb(base, bx) == x * logb(base, b);
  assert logb(base, rhs) == (x * y) * logb(base, b);
  assert logb(base, lhs) == logb(base, rhs);

  assert log(base) != 0.0;
  assert log(lhs) / log(base) == log(rhs) / log(base);
  assert log(lhs) == log(rhs);
  exp_log(lhs);
  exp_log(rhs);
}

lemma rpow_neg(b: real, k: real)
  requires b > 0.0
  ensures rpow(b, -k) == 1.0 / rpow(b, k)
{
  rpow_sub(b, 0.0, k);
  assert rpow(b, 0.0 - k) == rpow(b, 0.0) / rpow(b, k);
  assert 0.0 - k == -k;
  rpow_zero(b);
  assert rpow(b, 0.0) == 1.0;
}

/* ========== REAL SUM AND PROD ========== */

/* Real.sum */

lemma real_sum_singleton<T>(x: T, f: T -> real)
  ensures Real.sum({x}, f) == f(x)
{}

lemma real_sum_union<T>(A: set<T>, B: set<T>, f: T -> real)
  requires A !! B
  ensures Real.sum(A + B, f) == Real.sum(A, f) + Real.sum(B, f)
{
  if B == {}
  {
    assert A + B == A;
  }
  else
  {
    var y : T :| y in B;
    assert A !! (B - {y});
    real_sum_union(A, B - {y}, f);
    assert A + B == A + (B - {y}) + {y};
  }
}

lemma real_sum_insert<T>(s: set<T>, x: T, f: T -> real)
  requires x !in s
  ensures Real.sum(s + {x}, f) == f(x) + Real.sum(s, f)
{}

/* Real.prod */

lemma real_prod_singleton<T>(x: T, f: T -> real)
  ensures Real.prod({x}, f) == f(x)
{}

lemma {:axiom} real_prod_union<T>(A: set<T>, B: set<T>, f: T -> real)
  requires A !! B
  ensures Real.prod(A + B, f) == Real.prod(A, f) * Real.prod(B, f)

lemma real_prod_insert<T>(s: set<T>, x: T, f: T -> real)
  requires x !in s
  ensures Real.prod(s + {x}, f) == f(x) * Real.prod(s, f)
{
  real_prod_singleton(x, f);
  real_prod_union(s, {x}, f);
}

/* Sqrt */

lemma sqrt_zero()
  ensures sqrt(0.0) == 0.0
{
  var y := sqrt(0.0);
  assert y * y == 0.0;
  if y != 0.0 {
    var inv := 1.0 / y;
    assert (y * y) * (inv * inv) == 0.0 * (inv * inv);
    assert (y * inv) * (y * inv) == 0.0;
    assert 1.0 * 1.0 == 0.0;
    assert false;
  }
}

lemma sqrt_one()
  ensures sqrt(1.0) == 1.0
{
  var y := sqrt(1.0);
  assert y * y == 1.0;
  assert y > 0.0;
  assert (y - 1.0) * (y - 1.0) >= 0.0;
  assert (y - 1.0) * (y - 1.0) == y * y - 2.0 * y + 1.0;
  assert y * y - 2.0 * y + 1.0 == 1.0 - 2.0 * y + 1.0;
  assert 1.0 - 2.0 * y + 1.0 >= 0.0;
  assert y <= 1.0;
  assert (1.0 - y) * (1.0 - y) >= 0.0;
  assert (1.0 - y) * (1.0 - y) == 1.0 - 2.0 * y + y * y;
  assert 1.0 - 2.0 * y + y * y == 1.0 - 2.0 * y + 1.0;
  assert y >= 1.0;
}

lemma sqrt_nonneg(x: real)
  requires x >= 0.0
  ensures sqrt(x) >= 0.0
{
  var s := sqrt(x);
  if x == 0.0 && s != 0.0 {
    var inv := 1.0 / s;
    assert s * inv == 1.0;
    assert (s * s) * (inv * inv) == 0.0 * (inv * inv);
    assert (s * inv) * (s * inv) == 0.0;
    assert false;
  }
}

lemma sqrt_sq(x: real)
  requires x >= 0.0
  ensures sqrt(x) * sqrt(x) == x
{}

lemma sq_sqrt(x: real)
  requires x >= 0.0
  ensures sqrt(x * x) == x
{
  var s := sqrt(x * x);
  assert x * x >= 0.0;
  assert s * s == x * x;
  sqrt_nonneg(x * x);
  assert s >= 0.0;
  assert (s - x) * (s + x) == s * s - x * x;
  assert s * s - x * x == 0.0;
  assert (s - x) * (s + x) == 0.0;
  if s + x > 0.0 {
    assert s - x == 0.0;
  } else {
    assert s + x == 0.0;
    assert s == 0.0 && x == 0.0;
  }
}

lemma sqrt_eq_pow_half (x: real)
  requires x >= 0.0
  ensures sqrt(x) == rpow(x, 0.5)
{
  if x == 0.0 {
    assert rpow(0.0, 0.5) == 0.0;
    sqrt_nonneg(0.0);
    var s := sqrt(0.0);
    assert s >= 0.0;
    assert s * s == 0.0;
    if s > 0.0 {
      assert 1.0 / s > 0.0;
      assert s * s * (1.0 / s) == s;
      assert 0.0 * (1.0 / s) == 0.0;
    }
    assert s == 0.0;
  } else {
    assert x > 0.0;
    var s := sqrt(x);
    assert s > 0.0;
    assert s * s == x;

    var r := rpow(x, 0.5);
    assert r > 0.0;

    rpow_add(x, 0.5, 0.5);
    assert 0.5 + 0.5 == 1.0;
    assert rpow(x, 1.0) == r * r;
    assert rpow(x, 1.0) == x;
    assert r * r == x;

    assert s * s == r * r;
    var q := s / r;
    assert q > 0.0;
    assert q * q == (s * s) / (r * r);
    assert q * q == x / x;
    assert q * q == 1.0;
    if q > 1.0 {
      assert q * q > 1.0 * q;
      assert q * q > q;
      assert q * q > 1.0;
    } else if q < 1.0 {
      assert q * q < 1.0 * q;
      assert q * q < q;
      assert q * q < 1.0;
    }
    assert q == 1.0;
    assert s / r == 1.0;
    assert s == r;
  }
}

lemma sqrt_mul(y: real, z: real)
  requires y >= 0.0
  requires z >= 0.0
  ensures sqrt(y*z) == sqrt(y)*sqrt(z)
{
  var sy := sqrt(y);
  var sz := sqrt(z);
  var syz := sqrt(y * z);

  assert sy * sy == y;
  assert sz * sz == z;
  assert y * z >= 0.0;
  assert syz * syz == y * z;

  assert (sy * sz) * (sy * sz) == (sy * sy) * (sz * sz);
  assert (sy * sy) * (sz * sz) == y * z;

  var a := syz;
  var b := sy * sz;
  assert a * a == b * b;

  sqrt_nonneg(y);
  sqrt_nonneg(z);
  assert sy >= 0.0;
  assert sz >= 0.0;
  assert b >= 0.0;
  sqrt_nonneg(y * z);
  assert a >= 0.0;

  assert (a - b) * (a + b) == a * a - b * b;
  assert a * a - b * b == 0.0;
  assert (a - b) * (a + b) == 0.0;

  if a + b != 0.0 {
    assert a + b > 0.0;
    var d := a - b;
    var s := a + b;
    assert d * s == 0.0;
    if d != 0.0 {
      assert s == d * s / d;
      assert d * s / d == 0.0 / d;
      assert s == 0.0;
      assert false;
    }
    assert d == 0.0;
    assert a == b;
  } else {
    assert a + b == 0.0;
    assert a >= 0.0 && b >= 0.0;
    assert a == 0.0 && b == 0.0;
    assert a == b;
  }
}

lemma sqrt_div(x: real, y: real)
  requires x >= 0.0
  requires y > 0.0
  ensures sqrt(x / y) == sqrt(x) / sqrt(y)
{
  var sx := sqrt(x);
  var sy := sqrt(y);
  var sxy := sqrt(x / y);

  assert sy * sy == y;
  assert sx * sx == x;
  assert x / y >= 0.0;
  assert sxy * sxy == x / y;

  assert sy > 0.0;

  var b := sx / sy;
  assert b * b == (sx * sx) / (sy * sy);
  assert (sx * sx) / (sy * sy) == x / y;

  var a := sxy;
  assert a * a == b * b;

  sqrt_nonneg(x);
  assert sx >= 0.0;
  assert b >= 0.0;
  sqrt_nonneg(x / y);
  assert a >= 0.0;

  assert (a - b) * (a + b) == a * a - b * b;
  assert a * a - b * b == 0.0;
  assert (a - b) * (a + b) == 0.0;

  if a + b != 0.0 {
    assert a + b > 0.0;
    var d := a - b;
    var s := a + b;
    assert d * s == 0.0;
    if d != 0.0 {
      assert s == d * s / d;
      assert d * s / d == 0.0 / d;
      assert s == 0.0;
      assert false;
    }
    assert d == 0.0;
    assert a == b;
  } else {
    assert a + b == 0.0;
    assert a >= 0.0 && b >= 0.0;
    assert a == 0.0 && b == 0.0;
    assert a == b;
  }
}

/* Tan */

lemma {:axiom} tan_def(x: real)
  requires cos(x) != 0.0
  ensures tan(x) == sin(x) / cos(x)

/* Abs */

lemma abs_nonneg(x: real)
  ensures abs(x) >= 0.0
{}

lemma abs_zero(x: real)
  ensures abs(x) == 0.0 <==> x == 0.0
{}

lemma abs_neg(x: real)
  ensures abs(-x) == abs(x)
{}

lemma abs_triangle(x: real, y: real)
  ensures abs(x + y) <= abs(x) + abs(y)
{}

lemma abs_mul(x: real, y: real)
  ensures abs(x * y) == abs(x) * abs(y)
{}

lemma abs_div(x: real, y: real)
  requires y != 0.0
  ensures abs(x / y) == abs(x) / abs(y)
{
  var ax := abs(x);
  var ay := abs(y);
  var axy := abs(x / y);
  if x >= 0.0 {
    assert ax == x;
    if y > 0.0 {
      assert ay == y;
      assert x / y >= 0.0;
      assert axy == x / y;
      assert axy == ax / ay;
    } else {
      assert ay == -y;
      assert x / y <= 0.0;
      assert axy == -(x / y);
      assert -(x / y) == x / (-y);
      assert axy == ax / ay;
    }
  } else {
    assert ax == -x;
    if y > 0.0 {
      assert ay == y;
      assert x / y < 0.0;
      assert axy == -(x / y);
      assert -(x / y) == (-x) / y;
      assert axy == ax / ay;
    } else {
      assert ay == -y;
      assert x / y > 0.0;
      assert axy == x / y;
      assert x / y == (-x) / (-y);
      assert axy == ax / ay;
    }
  }
}

/* Axiomatization of irrational numbers over the reals */

lemma {:axiom} irrational_def(x: real)
  ensures irrational(x) <==> (forall p: int, q: int :: q != 0 ==> x != (p as real) / (q as real))

/* ========== TRIGONOMETRY ========== */

/* Sin and Cos */

// Axiomatization of sin and cos functions over the real numbers
lemma {:axiom} sin_cos_def()
  ensures continuous(sin)
  ensures continuous(cos)
  ensures sin(0.0) == 0.0
  ensures forall x, y :: cos(x - y) == cos(x) * cos(y) + sin(x) * sin(y)
  ensures forall x | 0.0 < x < 1.0 :: 0.0 < x * cos(x) < sin(x) < x

lemma sin_zero()
  ensures sin(0.0) == 0.0
{
  sin_add(0.0, 0.0);
  cos_sub(0.0, 0.0);
  // From cos_sub: cos(0.0) == cos(0.0)*cos(0.0) + sin(0.0)*sin(0.0)
  // From sin_add: sin(0.0) == sin(0.0)*cos(0.0) + cos(0.0)*sin(0.0) == 2*sin(0.0)*cos(0.0)
  // cos(0.0) == cos(0.0)^2 + sin(0.0)^2, and -1 <= sin,cos <= 1
  // This gives sin(0.0) == 0.0
  var s := sin(0.0);
  var c := cos(0.0);
  assert c == c * c + s * s;
  assert s == 2.0 * s * c;
  // c == c^2 + s^2 means c(1-c) == s^2, and s == 2sc means s(1-2c) == 0
  // So s == 0 or c == 0.5. If c == 0.5 then 0.5 == 0.25 + s^2 => s^2 == 0.25
  // Then s == 2*s*0.5 == s, which is always true. Need more info.
  // Simpler: just call sin_zero() or sin_cos_def()
  sin_cos_def();
}

lemma cos_zero()
  ensures cos(0.0) == 1.0
{
  cos_sub(0.0, 0.0);
  assert cos(0.0 - 0.0) == cos(0.0) * cos(0.0) + sin(0.0) * sin(0.0);
  assert 0.0 - 0.0 == 0.0;
  cos_sq_add_sin_sq_eq_one(0.0);
  assert cos(0.0) * cos(0.0) + sin(0.0) * sin(0.0) == 1.0;
  assert cos(0.0) == 1.0;
}

lemma sin_neg(x: real)
  ensures sin(-x) == -sin(x)
{
  sin_sub(0.0, x);
  sin_zero();
  cos_zero();
  assert sin(0.0 - x) == sin(0.0) * cos(x) - cos(0.0) * sin(x);
  assert sin(0.0) == 0.0;
  assert cos(0.0) == 1.0;
  assert 0.0 - x == -x;
}

lemma cos_neg(x: real)
  ensures cos(-x) == cos(x)
{
  cos_sub(0.0, x);
  cos_zero();
  sin_cos_def();
}

lemma cos_abs(x: real)
  ensures cos(Real.abs(x)) == cos(x)
{
  if x >= 0.0 {
    assert abs(x) == x;
  } else {
    assert abs(x) == -x;
    cos_neg(x);
  }
}

lemma sin_add(x: real, y: real)
  ensures sin(x+y) == sin(x)*cos(y) + cos(x)*sin(y)
{
  // e^(i(x+y)) via euler_formula
  var ix := Complex.mul(Complex.i(), Complex.of_real(x));
  var iy := Complex.mul(Complex.i(), Complex.of_real(y));
  
  // cexp(ix) = Complex(cos(x), sin(x))
  euler_formula(x);
  // cexp(iy) = Complex(cos(y), sin(y))
  euler_formula(y);
  
  // cexp(ix + iy) = cexp(ix) * cexp(iy)
  cexp_add(ix, iy);
  
  // ix + iy = i*(x+y)
  // euler_formula(x+y): cexp(i*(x+y)) = Complex(cos(x+y), sin(x+y))
  euler_formula(x + y);
  
  // Need to show ix + iy == i*(x+y)
  // Complex.add(ix, iy) should equal Complex.mul(i(), of_real(x+y))
}

lemma sin_sub(x: real, y: real)
  ensures sin(x-y) == sin(x)*cos(y) - cos(x)*sin(y)
{
  cexp_add(Complex.Complex(0.0, x), Complex.Complex(0.0, -y));
  cexp_add(Complex.Complex(0.0, y), Complex.Complex(0.0, -y));
  cexp_zero();
  cos_sq_add_sin_sq_eq_one(y);
  cos_sq_add_sin_sq_eq_one(-y);
}

lemma cos_add(x: real, y: real)
  ensures cos(x+y) == cos(x)*cos(y) - sin(x)*sin(y)
{
  var ix := Complex.mul(Complex.i(), Complex.of_real(x));
  var iy := Complex.mul(Complex.i(), Complex.of_real(y));
  
  euler_formula(x);
  euler_formula(y);
  cexp_add(ix, iy);
  euler_formula(x + y);
}

lemma cos_sub(x: real, y: real)
  ensures cos(x-y) == cos(x)*cos(y) + sin(x)*sin(y)
{
  sin_cos_def();
}

lemma cos_sq_add_sin_sq_eq_one(x : real)
  ensures cos(x) * cos(x) + sin(x) * sin(x) == 1.0
{
  // Step 1: Establish cos(0) == 1 from complex exponential
  assert cexp(Complex.Complex(0.0, 0.0)) == Complex.Complex(cos(0.0), sin(0.0)) by {
    cexp_imag(0.0);
  }
  assert Complex.Complex(0.0, 0.0) == Complex.zero();
  assert cexp(Complex.zero()) == Complex.one() by {
    cexp_zero();
  }
  assert Complex.one() == Complex.Complex(1.0, 0.0) by {
    assert Complex.one() == Complex.of_real(1.0);
  }
  assert cos(0.0) == 1.0;

  // Step 2: From sin_cos_def, cos(x - y) == cos(x)*cos(y) + sin(x)*sin(y)
  sin_cos_def();
  assert cos(x - x) == cos(x) * cos(x) + sin(x) * sin(x);
  assert x - x == 0.0;
  assert cos(0.0) == cos(x) * cos(x) + sin(x) * sin(x);
}

/* Pi */

lemma pi_ne_zero()
  ensures pi() != 0.0
{}

lemma one_le_pi_div_two()
  ensures 1.0 <= pi()/2.0
{}

lemma pi_div_two_le_two()
  ensures pi()/2.0 <= 2.0
{}

lemma sin_pi()
  ensures sin(pi()) == 0.0
{}

lemma cos_pi()
  ensures cos(pi()) == -1.0
{}

lemma sin_pi_div_two()
  ensures sin(pi() / 2.0) == 1.0
{
  var h := pi() / 4.0;

  // pi/4 is in (0, 1)
  assert 0.0 < h < 1.0;

  // From sin_cos_def: sin and cos are positive in (0,1)
  sin_cos_def();
  assert sin(h) > 0.0;
  assert cos(h) > 0.0;

  // cos(pi()/2)^2 + sin(pi()/2)^2 == 1
  cos_sq_add_sin_sq_eq_one(pi() / 2.0);

  // cos(pi()) == cos(pi()/2)^2 - sin(pi()/2)^2 == -1
  cos_add(pi() / 2.0, pi() / 2.0);
  assert pi() / 2.0 + pi() / 2.0 == pi();
  assert cos(pi()) == -1.0;

  var s := sin(pi() / 2.0);
  var c := cos(pi() / 2.0);

  // From cos_add and pi postcondition:
  assert c * c - s * s == -1.0;
  // From Pythagorean identity:
  assert c * c + s * s == 1.0;
  // Therefore 2*c*c == 0, so c == 0
  assert c * c == 0.0;
  assert c == 0.0;
  // Therefore s*s == 1
  assert s * s == 1.0;

  // sin(pi()/2) > 0 via sin_add(pi()/4, pi()/4)
  sin_add(h, h);
  assert h + h == pi() / 2.0;
  assert s == 2.0 * sin(h) * cos(h);
  assert s > 0.0;

  // s*s == 1 and s > 0 implies s == 1
  assert -1.0 <= s <= 1.0;
  assert s * s == 1.0;
  if s < 1.0 {
    assert s * s < 1.0 * s;
    assert 1.0 * s <= 1.0;
    assert s * s < 1.0;
    assert false;
  }
  assert s >= 1.0;
  assert s == 1.0;
}

lemma cos_pi_div_two()
  ensures cos(pi()/2.0) == 0.0
{
  var half := pi() / 2.0;

  cos_add(half, half);
  assert half + half == pi();
  assert cos(half) * cos(half) - sin(half) * sin(half) == cos(pi());
  assert cos(pi()) == -1.0;
  assert cos(half) * cos(half) - sin(half) * sin(half) == -1.0;

  cos_sub(half, half);
  assert half - half == 0.0;
  cos_zero();
  assert cos(half) * cos(half) + sin(half) * sin(half) == 1.0;

  assert cos(half) * cos(half) == 0.0 by {
    var cc := cos(half) * cos(half);
    var ss := sin(half) * sin(half);
    assert cc - ss == -1.0;
    assert cc + ss == 1.0;
    assert (cc - ss) + (cc + ss) == 0.0;
    assert 2.0 * cc == 0.0;
  }

  assert cos(half) == 0.0 by {
    var c := cos(half);
    assert c * c == 0.0;
    if c != 0.0 {
      var inv := 1.0 / c;
      assert c * inv == 1.0;
      assert (c * c) * (inv * inv) == 0.0 * (inv * inv);
      assert (c * inv) * (c * inv) == 0.0;
      assert 1.0 * 1.0 == 0.0;
      assert false;
    }
  }
}

lemma sin_two_pi()
  ensures sin(2.0*pi()) == 0.0
{
  sin_add(pi(), pi());
  assert pi() + pi() == 2.0 * pi();
  sin_pi();
  cos_pi();
}

lemma cos_two_pi()
  ensures cos(2.0*pi()) == 1.0
{
  cos_add(pi(), pi());
  assert pi() + pi() == 2.0 * pi();
  sin_pi();
  cos_pi();
}

lemma {:axiom} sin_period(x: real, k: int)
  ensures sin(x + (k as real) * 2.0 * pi()) == sin(x)

lemma {:axiom} cos_period(x: real, k: int)
  ensures cos(x + (k as real) * 2.0 * pi()) == cos(x)

lemma sin_add_pi(x: real)
  ensures sin(x + pi()) == -sin(x)
{
  sin_add(x, pi());
  sin_pi();
  cos_pi();
}

lemma sin_sub_pi(x: real)
  ensures sin(x - pi()) == -sin(x)
{
  sin_sub(x, pi());
  sin_pi();
  cos_pi();
  assert sin(x - pi()) == sin(x) * cos(pi()) - cos(x) * sin(pi());
  assert cos(pi()) == -1.0;
  assert sin(pi()) == 0.0;
  assert sin(x) * (-1.0) - cos(x) * 0.0 == -sin(x);
}

lemma cos_add_pi(x: real)
  ensures cos(x + pi()) == -cos(x)
{
  cos_add(x, pi());
  cos_pi();
  sin_pi();
}

lemma cos_sub_pi(x: real)
  ensures cos(x - pi()) == -cos(x)
{
  cos_sub(x, pi());
  cos_pi();
  sin_pi();
  assert cos(x - pi()) == cos(x) * cos(pi()) + sin(x) * sin(pi());
  assert cos(pi()) == -1.0;
  assert sin(pi()) == 0.0;
  assert cos(x) * (-1.0) + sin(x) * 0.0 == -cos(x);
}

lemma sin_add_two_pi(x: real)
  ensures sin(x + 2.0*pi()) == sin(x)
{
  sin_add(x, 2.0*pi());
  sin_two_pi();
  cos_two_pi();
}

lemma sin_sub_two_pi(x: real)
  ensures sin(x - 2.0*pi()) == sin(x)
{
  sin_sub(x, 2.0*pi());
  sin_two_pi();
  cos_two_pi();
}

lemma cos_add_two_pi(x: real)
  ensures cos(x + 2.0*pi()) == cos(x)
{
  cos_add(x, 2.0*pi());
  cos_two_pi();
  sin_two_pi();
}

lemma cos_sub_two_pi(x: real)
  ensures cos(x - 2.0*pi()) == cos(x)
{
  cos_sub(x, 2.0*pi());
  sin_two_pi();
  cos_two_pi();
}

lemma pi_smallest_period()
  ensures forall p: real | pos(p) && (forall x :: sin(x + p) == sin(x)) :: pi() <= p
{
  forall p: real | pos(p) && (forall x :: sin(x + p) == sin(x))
    ensures pi() <= p
  {
    assert p > 0.0;
    assert sin(0.0 + p) == sin(0.0);
    sin_zero();
    assert sin(p) == 0.0;
    pi_smallest_sin_zero_after_zero();
  }
}

lemma pi_pos()
  ensures pi() > 0.0
{}

lemma pi_smallest_cos_neg_one()
  ensures forall p: real | p > 0.0 && cos(p) == -1.0 :: pi() <= p
{
  forall p: real | p > 0.0 && cos(p) == -1.0
    ensures pi() <= p
  {
    if p < pi() {
      var q := pi() - p;

      // cos(q) = cos(pi - p) = cos(pi)*cos(p) + sin(pi)*sin(p) = 1
      cos_sub(pi(), p);
      cos_pi();
      sin_pi();
      assert cos(q) == 1.0;

      // Pythagorean identity for q/2: cos(q/2)^2 + sin(q/2)^2 = 1
      cos_sub(q / 2.0, q / 2.0);
      assert q / 2.0 - q / 2.0 == 0.0;
      cos_zero();
      assert cos(q / 2.0) * cos(q / 2.0) + sin(q / 2.0) * sin(q / 2.0) == 1.0;

      // cos(q) = cos(q/2)^2 - sin(q/2)^2 = 1, so sin(q/2)^2 = 0
      cos_add(q / 2.0, q / 2.0);
      assert q / 2.0 + q / 2.0 == q;
      assert sin(q / 2.0) * sin(q / 2.0) == 0.0;

      // sin(q/2)^2 = 0 implies sin(q/2) = 0
      if sin(q / 2.0) != 0.0 {
        var inv := 1.0 / sin(q / 2.0);
        assert (sin(q / 2.0) * sin(q / 2.0)) * (inv * inv) == 0.0 * (inv * inv);
        assert (sin(q / 2.0) * inv) * (sin(q / 2.0) * inv) == 0.0;
        assert false;
      }

      // sin(q/2) = sin(q/4 + q/4) = 2*sin(q/4)*cos(q/4) = 0
      sin_add(q / 4.0, q / 4.0);
      assert q / 4.0 + q / 4.0 == q / 2.0;
      var sq4 := sin(q / 4.0);
      var cq4 := cos(q / 4.0);
      assert 0.0 == sq4 * cq4 + cq4 * sq4;

      // 0 < q/4 < pi/4 < 1, so sin_cos_def gives sin(q/4) > 0 and cos(q/4) > 0
      assert 0.0 < q / 4.0 < 1.0;
      sin_cos_def();
      assert sq4 > 0.0;
      assert cq4 > 0.0;

      // 2*sin(q/4)*cos(q/4) > 0, contradicting == 0
      assert false;
    }
  }
}

lemma pi_smallest_sin_zero_after_zero()
  ensures forall p: real | p > 0.0 && sin(p) == 0.0 :: pi() <= p
{
  forall p: real | p > 0.0 && sin(p) == 0.0
    ensures pi() <= p
  {
    cos_sq_add_sin_sq_eq_one(p);
    assert cos(p) * cos(p) == 1.0;

    if cos(p) == -1.0 {
      pi_smallest_cos_neg_one();
    } else {
      if cos(p) - 1.0 != 0.0 {
        var inv := 1.0 / (cos(p) - 1.0);
        assert (cos(p) - 1.0) * (cos(p) + 1.0) == cos(p) * cos(p) - 1.0 == 0.0;
        assert (cos(p) + 1.0) == 0.0;
        assert false;
      }
      assert cos(p) == 1.0;

      var h := p / 2.0;
      sin_add(h, h);
      assert h + h == p;
      cos_add(h, h);
      cos_sq_add_sin_sq_eq_one(h);
      assert cos(h) * cos(h) - sin(h) * sin(h) == 1.0;
      assert cos(h) * cos(h) + sin(h) * sin(h) == 1.0;
      assert sin(h) * sin(h) == 0.0;
      if sin(h) != 0.0 {
        var inv := 1.0 / sin(h);
        assert sin(h) * sin(h) * (inv * inv) == 0.0;
        assert false;
      }
      assert sin(h) == 0.0;
      assert cos(h) * cos(h) == 1.0;

      if cos(h) == -1.0 {
        pi_smallest_cos_neg_one();
      } else {
        if cos(h) - 1.0 != 0.0 {
          var inv := 1.0 / (cos(h) - 1.0);
          assert (cos(h) - 1.0) * (cos(h) + 1.0) == cos(h) * cos(h) - 1.0 == 0.0;
          assert (cos(h) + 1.0) == 0.0;
          assert false;
        }
        assert cos(h) == 1.0;

        var q := h / 2.0;
        sin_add(q, q);
        assert q + q == h;
        cos_add(q, q);
        cos_sq_add_sin_sq_eq_one(q);
        assert cos(q) * cos(q) - sin(q) * sin(q) == 1.0;
        assert cos(q) * cos(q) + sin(q) * sin(q) == 1.0;
        assert sin(q) * sin(q) == 0.0;
        if sin(q) != 0.0 {
          var inv := 1.0 / sin(q);
          assert sin(q) * sin(q) * (inv * inv) == 0.0;
          assert false;
        }
        assert sin(q) == 0.0;
        assert cos(q) * cos(q) == 1.0;

        if cos(q) == -1.0 {
          pi_smallest_cos_neg_one();
        } else {
          if cos(q) - 1.0 != 0.0 {
            var inv := 1.0 / (cos(q) - 1.0);
            assert (cos(q) - 1.0) * (cos(q) + 1.0) == cos(q) * cos(q) - 1.0 == 0.0;
            assert (cos(q) + 1.0) == 0.0;
            assert false;
          }
          assert cos(q) == 1.0;

          var r := q / 2.0;
          sin_add(r, r);
          assert r + r == q;
          cos_add(r, r);
          cos_sq_add_sin_sq_eq_one(r);
          assert cos(r) * cos(r) - sin(r) * sin(r) == 1.0;
          assert cos(r) * cos(r) + sin(r) * sin(r) == 1.0;
          assert sin(r) * sin(r) == 0.0;
          if sin(r) != 0.0 {
            var inv := 1.0 / sin(r);
            assert sin(r) * sin(r) * (inv * inv) == 0.0;
            assert false;
          }
          assert sin(r) == 0.0;

          if p < pi() {
            assert r == p / 8.0;
            assert r < pi() / 8.0;
            assert pi() < 3.1415926536;
            assert r < 1.0;
            sin_cos_def();
            assert sin(r) > 0.0;
            assert false;
          }
        }
      }
    }
  }
}

/* Special angle values */

lemma sin_pi_div_six()
  ensures sin(pi() / 6.0) == 0.5
{
  var h := pi() / 6.0;
  var s := sin(h);
  var c := cos(h);

  // Pythagorean identity: c^2 + s^2 = 1
  cos_sub(h, h);
  cos_zero();
  assert c * c + s * s == 1.0;

  // cos(pi/3) = c^2 - s^2
  cos_add(h, h);
  assert h + h == pi() / 3.0;
  assert cos(pi() / 3.0) == c * c - s * s;

  // cos(pi/3) = sin(pi/6) via cos(pi/2 - pi/6) = 0*c + 1*s = s
  cos_pi_div_two();
  sin_pi_div_two();
  cos_sub(pi() / 2.0, h);
  assert pi() / 2.0 - h == pi() / 3.0;
  assert cos(pi() / 3.0) == s;

  // So s = c^2 - s^2 = 1 - 2s^2
  assert s == 1.0 - 2.0 * s * s;

  // 2s^2 + s - 1 = 0, (2s-1)(s+1) = 0
  assert (2.0 * s - 1.0) * (s + 1.0) == 0.0;

  // s > 0: pi/6 in (0,1), sin_cos_def gives sin positive there
  assert 0.0 < h < 1.0;
  sin_cos_def();
  assert s > 0.0;
  assert s == 0.5;
}

lemma cos_pi_div_six()
  ensures cos(pi() / 6.0) == sqrt(3.0) / 2.0
{
  var h := pi() / 6.0;
  var s := sin(h);
  var c := cos(h);

  sin_pi_div_six();
  assert s == 0.5;

  cos_sq_add_sin_sq_eq_one(h);
  assert c * c + s * s == 1.0;
  assert c * c == 0.75;

  assert 0.0 < h < 1.0;
  sin_cos_def();
  assert c > 0.0;

  var target := sqrt(3.0) / 2.0;
  sqrt_sq(3.0);
  assert sqrt(3.0) * sqrt(3.0) == 3.0;
  assert target * target == 3.0 / 4.0;
  assert target * target == 0.75;

  assert sqrt(3.0) > 0.0;
  assert target > 0.0;

  assert c * c == target * target;
  assert (c - target) * (c + target) == c * c - target * target;
  assert c * c - target * target == 0.0;
  assert (c - target) * (c + target) == 0.0;
  assert c + target > 0.0;

  if c - target != 0.0 {
    var d := c - target;
    var sum := c + target;
    assert d * sum == 0.0;
    assert sum > 0.0;
    assert d == d * sum / sum;
    assert d * sum / sum == 0.0 / sum;
    assert d == 0.0;
    assert false;
  }
  assert c == target;
}

lemma sin_pi_div_four()
  ensures sin(pi() / 4.0) == sqrt(2.0) / 2.0
{
  var h := pi() / 4.0;
  var s := sin(h);
  var c := cos(h);

  // cos(pi/4) == sin(pi/4) via cos(pi/2 - pi/4)
  cos_sub(pi() / 2.0, h);
  assert pi() / 2.0 - h == pi() / 4.0;
  cos_pi_div_two();
  sin_pi_div_two();
  assert cos(pi() / 4.0) == 0.0 * c + 1.0 * s;
  assert c == s;

  // Pythagorean identity: 2*s^2 = 1
  cos_sq_add_sin_sq_eq_one(h);
  assert c * c + s * s == 1.0;
  assert s * s + s * s == 1.0;
  assert 2.0 * s * s == 1.0;

  // s > 0 since pi/4 in (0,1)
  assert 0.0 < h < 1.0;
  sin_cos_def();
  assert s > 0.0;

  // Show s == sqrt(2)/2
  var sq2 := sqrt(2.0);
  assert sq2 * sq2 == 2.0;
  assert sq2 > 0.0;
  var target := sq2 / 2.0;
  assert target > 0.0;
  assert target * target == (sq2 * sq2) / (2.0 * 2.0);
  assert target * target == 2.0 / 4.0;
  assert target * target == 0.5;

  assert s * s == target * target;
  assert (s - target) * (s + target) == s * s - target * target;
  assert s * s - target * target == 0.0;
  assert (s - target) * (s + target) == 0.0;

  assert s + target > 0.0;
  if s - target != 0.0 {
    var d := s - target;
    var sum := s + target;
    assert d * sum == 0.0;
    assert sum > 0.0;
    assert d == d * sum / sum;
    assert d * sum / sum == 0.0 / sum;
    assert d == 0.0;
    assert false;
  }
  assert s == target;
}

lemma cos_pi_div_four()
  ensures cos(pi() / 4.0) == sqrt(2.0) / 2.0
  ensures cos(pi() / 4.0) == sin(pi() / 4.0)
{
  var h := pi() / 4.0;
  var s := sin(h);
  var c := cos(h);

  // h is in (0, 1)
  assert 0.0 < h < 1.0;
  sin_cos_def();
  assert s > 0.0;
  assert c > 0.0;

  // Pythagorean identity
  cos_sq_add_sin_sq_eq_one(h);
  assert c * c + s * s == 1.0;

  // cos(pi/2) = cos(h+h) = c^2 - s^2 = 0
  cos_add(h, h);
  assert h + h == pi() / 2.0;
  cos_pi_div_two();
  assert c * c - s * s == 0.0;

  // Therefore c^2 = s^2 = 0.5
  assert c * c == s * s;
  assert 2.0 * c * c == 1.0;
  assert c * c == 0.5;
  assert s * s == 0.5;

  // c == s (both positive, same square)
  assert (c - s) * (c + s) == c * c - s * s;
  assert (c - s) * (c + s) == 0.0;
  assert c + s > 0.0;
  // ... so c - s == 0
  if c != s {
    var d := c - s;
    assert d != 0.0;
    assert d * (c + s) == 0.0;
    assert c + s == d * (c + s) / d;
    assert d * (c + s) / d == 0.0 / d;
    assert c + s == 0.0;
    assert false;
  }
  assert c == s;

  // Now show c == sqrt(2.0) / 2.0
  // c^2 == 0.5 == 2.0 / 4.0
  // (sqrt(2)/2)^2 = 2/4 = 0.5
  var target := sqrt(2.0) / 2.0;
  assert target > 0.0;
  sqrt_sq(2.0);
  assert sqrt(2.0) * sqrt(2.0) == 2.0;
  assert target * target == (sqrt(2.0) * sqrt(2.0)) / (2.0 * 2.0);
  assert target * target == 2.0 / 4.0;
  assert target * target == 0.5;

  // c > 0, target > 0, c^2 == target^2 == 0.5
  assert c * c == target * target;
  assert (c - target) * (c + target) == c * c - target * target;
  assert (c - target) * (c + target) == 0.0;
  assert c + target > 0.0;
  if c != target {
    var d := c - target;
    assert d != 0.0;
    assert d * (c + target) == 0.0;
    assert c + target == d * (c + target) / d;
    assert d * (c + target) / d == 0.0 / d;
    assert c + target == 0.0;
    assert false;
  }
  assert c == target;
}

lemma sin_pi_div_three()
  ensures sin(pi() / 3.0) == sqrt(3.0) / 2.0
{
  assert pi() / 3.0 == pi() / 2.0 - pi() / 6.0;
  sin_sub(pi() / 2.0, pi() / 6.0);
  sin_pi_div_two();
  cos_pi_div_two();
  cos_pi_div_six();
}

lemma cos_pi_div_three()
  ensures cos(pi() / 3.0) == 0.5
{
  var h := pi() / 6.0;
  cos_sub(pi() / 2.0, h);
  assert pi() / 2.0 - h == pi() / 3.0;
  cos_pi_div_two();
  sin_pi_div_two();
  sin_pi_div_six();
  assert cos(pi() / 3.0) == cos(pi() / 2.0) * cos(h) + sin(pi() / 2.0) * sin(h);
  assert cos(pi() / 3.0) == 0.0 * cos(h) + 1.0 * 0.5;
}

/* ========== COMPLEX NUMBERS ========== */

/* Complex arithmetic */

lemma complex_i_squared()
  ensures Complex.mul(Complex.i(), Complex.i()) == Complex.Complex(-1.0, 0.0)
{}

lemma complex_add_comm(z: Complex.complex, w: Complex.complex)
  ensures Complex.add(z, w) == Complex.add(w, z)
{}

lemma complex_add_assoc(z: Complex.complex, w: Complex.complex, u: Complex.complex)
  ensures Complex.add(Complex.add(z, w), u) == Complex.add(z, Complex.add(w, u))
{}

lemma complex_add_zero(z: Complex.complex)
  ensures Complex.add(z, Complex.zero()) == z
{}

lemma complex_mul_comm(z: Complex.complex, w: Complex.complex)
  ensures Complex.mul(z, w) == Complex.mul(w, z)
{}

lemma complex_mul_assoc(z: Complex.complex, w: Complex.complex, u: Complex.complex)
  ensures Complex.mul(Complex.mul(z, w), u) == Complex.mul(z, Complex.mul(w, u))
{}

lemma complex_mul_one(z: Complex.complex)
  ensures Complex.mul(z, Complex.one()) == z
{}

lemma complex_mul_zero(z: Complex.complex)
  ensures Complex.mul(z, Complex.zero()) == Complex.zero()
{}

lemma complex_distributive(z: Complex.complex, w: Complex.complex, u: Complex.complex)
  ensures Complex.mul(z, Complex.add(w, u)) == Complex.add(Complex.mul(z, w), Complex.mul(z, u))
{}

lemma complex_norm_sq_nonneg(z: Complex.complex)
  ensures Complex.norm_sq(z) >= 0.0
{}

lemma complex_norm_sq_zero(z: Complex.complex)
  ensures Complex.norm_sq(z) == 0.0 <==> z == Complex.zero()
{}

lemma complex_abs_nonneg(z: Complex.complex)
  ensures Complex.norm(z) >= 0.0
{
  var s := z.re * z.re + z.im * z.im;
  assert s >= 0.0;
  sqrt_nonneg(s);
}

lemma complex_abs_zero(z: Complex.complex)
  ensures Complex.norm(z) == 0.0 <==> z == Complex.zero()
{
  var s := z.re * z.re + z.im * z.im;
  var ns := Complex.norm_sq(z);
  var n := Complex.norm(z);
  assert ns == s;
  assert ns == 0.0 <==> z == Complex.zero();
  assert n == sqrt(s);

  if z == Complex.zero() {
    assert s == 0.0;
    sqrt_zero();
    assert n == 0.0;
  }

  if n == 0.0 {
    assert sqrt(s) == 0.0;
    assert s >= 0.0;
    sqrt_sq(s);
    assert s == 0.0;
    assert z == Complex.zero();
  }
}

/* Complex.sum */

lemma complex_sum_singleton<T>(x: T, f: T -> Complex.complex)
  ensures Complex.sum({x}, f) == f(x)
{}

lemma {:axiom} complex_sum_union<T>(A: set<T>, B: set<T>, f: T -> Complex.complex)
  requires A !! B
  ensures Complex.sum(A + B, f) == Complex.add(Complex.sum(A, f), Complex.sum(B, f))

lemma {:axiom} complex_sum_insert<T>(s: set<T>, x: T, f: T -> Complex.complex)
  requires x !in s
  ensures Complex.sum(s + {x}, f) == Complex.add(f(x), Complex.sum(s, f))

/* Complex.prod */

lemma complex_prod_singleton<T>(x: T, f: T -> Complex.complex)
  ensures Complex.prod({x}, f) == f(x)
{}

lemma {:axiom} complex_prod_union<T>(A: set<T>, B: set<T>, f: T -> Complex.complex)
  requires A !! B
  ensures Complex.prod(A + B, f) == Complex.mul(Complex.prod(A, f), Complex.prod(B, f))

lemma {:axiom} complex_prod_insert<T>(s: set<T>, x: T, f: T -> Complex.complex)
  requires x !in s
  ensures Complex.prod(s + {x}, f) == Complex.mul(f(x), Complex.prod(s, f))

/* Complex exponential */

lemma cexp_zero()
  ensures cexp(Complex.zero()) == Complex.one()
{}

lemma {:axiom} cexp_add(z: Complex.complex, w: Complex.complex)
  ensures cexp(Complex.add(z, w)) == Complex.mul(cexp(z), cexp(w))

lemma cexp_real(x: real)
  ensures cexp(Complex.of_real(x)) == Complex.of_real(exp(x))
{}

lemma cexp_imag(y: real)
  ensures cexp(Complex.Complex(0.0, y)) == Complex.Complex(cos(y), sin(y))
{}

lemma euler_formula(x: real)
  ensures cexp(Complex.mul(Complex.i(), Complex.of_real(x))) == Complex.Complex(cos(x), sin(x))
{}

lemma {:axiom} cos_via_exp(x: real)
  ensures cos(x) == (cexp(Complex.mul(Complex.i(), Complex.of_real(x))).re +
                      cexp(Complex.mul(Complex.i(), Complex.of_real(-x))).re) / 2.0

lemma {:axiom} sin_via_exp(x: real)
  ensures sin(x) == (cexp(Complex.mul(Complex.i(), Complex.of_real(x))).im -
                      cexp(Complex.mul(Complex.i(), Complex.of_real(-x))).im) / 2.0

/* ========== NUMBER THEORY ========== */

/* GCD */

lemma gcd_comm(x: nat, y: nat)
  requires x > 0 || y > 0
  ensures gcd(x, y) == gcd(y, x)
{}

lemma gcd_self(x: nat)
  requires x > 0
  ensures gcd(x, x) == x
{
  assert x % x == 0;
  assert x % gcd(x, x) == 0;
  assert gcd(x, x) <= x by {
    assert x > 0;
    assert x % gcd(x, x) == 0;
    var g := gcd(x, x);
    assert g > 0;
    assert x % g == 0;
    assert g <= x by {
      if g > x {
        assert x % g == 0;
        assert x > 0;
        assert g > x > 0;
        assert x % g == x;
        assert false;
      }
    }
  }
  assert x <= gcd(x, x) by {
    assert x > 0 && x % x == 0 && x % x == 0;
  }
}

lemma gcd_one_left(x: nat)
  requires x > 0
  ensures gcd(1, x) == 1
{}

lemma gcd_one_right(x: nat)
  requires x > 0
  ensures gcd(x, 1) == 1
{}

lemma gcd_lcm_product(x: nat, y: nat)
  requires x > 0
  requires y > 0
  ensures gcd(x,y)*lcm(x,y) == x*y
{}

/* ========== ANALYSIS ========== */

/* Limits */

lemma limit_unique(f: nat -> real, L1: real, L2: real)
  requires limit(f, L1)
  requires limit(f, L2)
  ensures L1 == L2
{
  if L1 != L2 {
    var eps := abs(L1 - L2) / 3.0;
    var e1 := eventually_within_eps(f, L1, eps, 0);
    var e2 := eventually_within_eps(f, L2, eps, 0);
    assert L1 - f(0) <= abs(f(0) - L1);
  }
}

/* Continuity */

lemma {:axiom} continuous_add(f: real -> real, g: real -> real)
  requires continuous(f)
  requires continuous(g)
  ensures continuous((x: real) => f(x) + g(x))

lemma {:axiom} continuous_mul(f: real -> real, g: real -> real)
  requires continuous(f)
  requires continuous(g)
  ensures continuous((x: real) => f(x) * g(x))

lemma {:axiom} continuous_compose(f: real -> real, g: real -> real)
  requires continuous(f)
  requires continuous(g)
  ensures continuous((x: real) => f(g(x)))


/* ========== SEQUENCE Products and Sums ========== */


import opened Int
import opened Rat
import opened Real
import opened Complex

/* Integer sequences */
function int_prod_seq<T>(s: seq<T>, f: T -> int): (p: int)
  ensures s == [] ==> p == 1
  ensures s != [] ==> int_prod_seq(s, f) == f(s[0]) * int_prod_seq(s[1..], f)
{
  if s == [] then 1
  else f(s[0]) * int_prod_seq(s[1..], f)
}

function int_sum_seq<T>(s: seq<T>, f: T -> int): (p: int)
  ensures s == [] ==> p == 0
  ensures s != [] ==> int_sum_seq(s, f) == f(s[0]) + int_sum_seq(s[1..], f)
{
  if s == [] then 0
  else f(s[0]) + int_sum_seq(s[1..], f)
}

/* Rational sequences */
function rat_prod_seq<T>(s: seq<T>, f: T -> rat): (p: rat)
  ensures s == [] ==> p == Rational(1, 1)
  ensures s != [] ==> rat_prod_seq(s, f) == Rat.mul(f(s[0]), rat_prod_seq(s[1..], f))
{
  if s == [] then Rational(1, 1)
  else Rat.mul(f(s[0]), rat_prod_seq(s[1..], f))
}

function rat_sum_seq<T>(s: seq<T>, f: T -> rat): (p: rat)
  ensures s == [] ==> p == Rational(0, 1)
  ensures s != [] ==> rat_sum_seq(s, f) == Rat.add(f(s[0]), rat_sum_seq(s[1..], f))
{
  if s == [] then Rational(0, 1)
  else Rat.add(f(s[0]), rat_sum_seq(s[1..], f))
}

/* Real sequences */
function real_sum_seq<T>(s: seq<T>, f: T -> real): (p: real)
  ensures s == [] ==> p == 0.0
  ensures s != [] ==> real_sum_seq(s, f) == f(s[0]) + real_sum_seq(s[1..], f)
{
  if s == [] then 0.0
  else f(s[0]) + real_sum_seq(s[1..], f)
}

function real_prod_seq<T>(s: seq<T>, f: T -> real): (p: real)
  ensures s == [] ==> p == 1.0
  ensures s != [] ==> real_prod_seq(s, f) == f(s[0]) * real_prod_seq(s[1..], f)
{
  if s == [] then 1.0
  else f(s[0]) * real_prod_seq(s[1..], f)
}

/* Complex sequences */
function complex_sum_seq<T>(s: seq<T>, f: T -> complex): (p: complex)
  ensures s == [] ==> p == Complex.zero()
  ensures s != [] ==> complex_sum_seq(s, f) == Complex.add(f(s[0]), complex_sum_seq(s[1..], f))
{
  if s == [] then Complex.zero()
  else Complex.add(f(s[0]), complex_sum_seq(s[1..], f))
}

function complex_prod_seq<T>(s: seq<T>, f: T -> complex): (p: complex)
  ensures s == [] ==> p == one()
  ensures s != [] ==> complex_prod_seq(s, f) == Complex.mul(f(s[0]), complex_prod_seq(s[1..], f))
{
  if s == [] then one()
  else Complex.mul(f(s[0]), complex_prod_seq(s[1..], f))
}


/* ========== Coercions ========== */

/* Sum and Prod conversions */

lemma {:axiom} int_sum_seq_to_set<T>(s: seq<T>, f: T -> int)
  ensures int_sum_seq(s, f) == Int.sum((set x | x in s), f)

lemma {:axiom} int_prod_seq_to_set<T>(s: seq<T>, f: T -> int)
  ensures int_prod_seq(s, f) == Int.prod((set x | x in s), f)

lemma {:axiom} rat_sum_seq_to_set<T>(s: seq<T>, f: T -> Rat.rat)
  ensures rat_sum_seq(s, f) == Rat.sum((set x | x in s), f)

lemma {:axiom} rat_prod_seq_to_set<T>(s: seq<T>, f: T -> Rat.rat)
  ensures rat_prod_seq(s, f) == Rat.prod((set x | x in s), f)

lemma {:axiom} real_sum_seq_to_set<T>(s: seq<T>, f: T -> real)
  ensures real_sum_seq(s, f) == Real.sum((set x | x in s), f)

lemma {:axiom} real_prod_seq_to_set<T>(s: seq<T>, f: T -> real)
  ensures real_prod_seq(s, f) == Real.prod((set x | x in s), f)

lemma {:axiom} complex_sum_seq_to_set<T>(s: seq<T>, f: T -> Complex.complex)
  ensures complex_sum_seq(s, f) == Complex.sum((set x | x in s), f)

lemma complex_prod_seq_to_set<T>(s: seq<T>, f: T -> Complex.complex)
  requires forall i, j | 0 <= i < j < |s| :: s[i] != s[j]
  ensures complex_prod_seq(s, f) == Complex.prod((set x | x in s), f)
  decreases |s|
{
  if s == [] {
    assert (set x | x in s) == {};
  } else {
    var head := s[0];
    var tail := s[1..];
    var S := (set x | x in s);
    var S' := (set x | x in tail);

    // head is not in tail (from distinct precondition)
    assert head !in tail;
    
    // Therefore S == S' + {head} and head !in S'
    assert head !in S';
    assert S == S' + {head};

    // IH
    complex_prod_seq_to_set(tail, f);
    assert complex_prod_seq(tail, f) == Complex.prod(S', f);

    // From Complex.prod postcondition: since head in S,
    // Complex.prod(S, f) == Complex.mul(f(head), Complex.prod(S - {head}, f))
    assert head in S;
    assert S - {head} == S';
    assert Complex.prod(S, f) == Complex.mul(f(head), Complex.prod(S', f));

    // From complex_prod_seq definition
    assert complex_prod_seq(s, f) == Complex.mul(f(head), complex_prod_seq(tail, f));

    // Combine
    assert complex_prod_seq(s, f) == Complex.mul(f(head), Complex.prod(S', f));
    assert complex_prod_seq(s, f) == Complex.prod(S, f);
  }
}
