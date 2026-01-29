include "../definitions.dfy"
include "../library.dfy"

lemma amc12_2000_p6(p: nat, q: nat)
  requires prime(p)
  requires prime(q)
  requires 4 <= p <= 18
  requires 4 <= q <= 18
  ensures p*q - (p+q) != 194
{
  // First, let's establish which numbers in [4, 18] are not prime
  // We use the definition: prime(n) <==> 2 <= n && forall m | 2 <= m < n :: n % m != 0

  // Show that certain numbers are not prime by showing they have divisors
  assert !prime(4) by {
    assert 4 % 2 == 0 && 2 >= 2 && 2 < 4;
  }
  assert !prime(6) by {
    assert 6 % 2 == 0 && 2 >= 2 && 2 < 6;
  }
  assert !prime(8) by {
    assert 8 % 2 == 0 && 2 >= 2 && 2 < 8;
  }
  assert !prime(9) by {
    assert 9 % 3 == 0 && 3 >= 2 && 3 < 9;
  }
  assert !prime(10) by {
    assert 10 % 2 == 0 && 2 >= 2 && 2 < 10;
  }
  assert !prime(12) by {
    assert 12 % 2 == 0 && 2 >= 2 && 2 < 12;
  }
  assert !prime(14) by {
    assert 14 % 2 == 0 && 2 >= 2 && 2 < 14;
  }
  assert !prime(15) by {
    assert 15 % 3 == 0 && 3 >= 2 && 3 < 15;
  }
  assert !prime(16) by {
    assert 16 % 2 == 0 && 2 >= 2 && 2 < 16;
  }
  assert !prime(18) by {
    assert 18 % 2 == 0 && 2 >= 2 && 2 < 18;
  }

  // Since p is prime and 4 <= p <= 18, and we've shown which numbers are not prime,
  // p must be one of: 5, 7, 11, 13, 17
  assert p == 5 || p == 7 || p == 11 || p == 13 || p == 17;
  assert q == 5 || q == 7 || q == 11 || q == 13 || q == 17;

  // Now check all cases systematically
  if p == 5 {
    if q == 5 {
      assert p * q - (p + q) == 5 * 5 - (5 + 5) == 25 - 10 == 15;
    } else if q == 7 {
      assert p * q - (p + q) == 5 * 7 - (5 + 7) == 35 - 12 == 23;
    } else if q == 11 {
      assert p * q - (p + q) == 5 * 11 - (5 + 11) == 55 - 16 == 39;
    } else if q == 13 {
      assert p * q - (p + q) == 5 * 13 - (5 + 13) == 65 - 18 == 47;
    } else if q == 17 {
      assert p * q - (p + q) == 5 * 17 - (5 + 17) == 85 - 22 == 63;
    }
  } else if p == 7 {
    if q == 5 {
      assert p * q - (p + q) == 7 * 5 - (7 + 5) == 35 - 12 == 23;
    } else if q == 7 {
      assert p * q - (p + q) == 7 * 7 - (7 + 7) == 49 - 14 == 35;
    } else if q == 11 {
      assert p * q - (p + q) == 7 * 11 - (7 + 11) == 77 - 18 == 59;
    } else if q == 13 {
      assert p * q - (p + q) == 7 * 13 - (7 + 13) == 91 - 20 == 71;
    } else if q == 17 {
      assert p * q - (p + q) == 7 * 17 - (7 + 17) == 119 - 24 == 95;
    }
  } else if p == 11 {
    if q == 5 {
      assert p * q - (p + q) == 11 * 5 - (11 + 5) == 55 - 16 == 39;
    } else if q == 7 {
      assert p * q - (p + q) == 11 * 7 - (11 + 7) == 77 - 18 == 59;
    } else if q == 11 {
      assert p * q - (p + q) == 11 * 11 - (11 + 11) == 121 - 22 == 99;
    } else if q == 13 {
      assert p * q - (p + q) == 11 * 13 - (11 + 13) == 143 - 24 == 119;
    } else if q == 17 {
      assert p * q - (p + q) == 11 * 17 - (11 + 17) == 187 - 28 == 159;
    }
  } else if p == 13 {
    if q == 5 {
      assert p * q - (p + q) == 13 * 5 - (13 + 5) == 65 - 18 == 47;
    } else if q == 7 {
      assert p * q - (p + q) == 13 * 7 - (13 + 7) == 91 - 20 == 71;
    } else if q == 11 {
      assert p * q - (p + q) == 13 * 11 - (13 + 11) == 143 - 24 == 119;
    } else if q == 13 {
      assert p * q - (p + q) == 13 * 13 - (13 + 13) == 169 - 26 == 143;
    } else if q == 17 {
      assert p * q - (p + q) == 13 * 17 - (13 + 17) == 221 - 30 == 191;
    }
  } else if p == 17 {
    if q == 5 {
      assert p * q - (p + q) == 17 * 5 - (17 + 5) == 85 - 22 == 63;
    } else if q == 7 {
      assert p * q - (p + q) == 17 * 7 - (17 + 7) == 119 - 24 == 95;
    } else if q == 11 {
      assert p * q - (p + q) == 17 * 11 - (17 + 11) == 187 - 28 == 159;
    } else if q == 13 {
      assert p * q - (p + q) == 17 * 13 - (17 + 13) == 221 - 30 == 191;
    } else if q == 17 {
      assert p * q - (p + q) == 17 * 17 - (17 + 17) == 289 - 34 == 255;
    }
  }

  // All computed values are: 15, 23, 35, 39, 47, 59, 63, 71, 95, 99, 119, 143, 159, 191, 255
  // None of these equal 194
}
