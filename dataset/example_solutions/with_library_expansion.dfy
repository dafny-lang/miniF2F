include "../definitions.dfy"
include "../library.dfy"

lemma aime_1988_p3(x: real)
  requires 0.0 < x
  requires logb(2.0, logb(8.0, x)) == logb(8.0, logb(2.0, x))
  ensures Real.pow(logb(2.0, x), 2) == 27.0
{
  // Let y = log₂(x)
  var y := logb(2.0, x);

  // First establish that log₂(8) = 3
  lemma_log2_8();
  var log2_8 := logb(2.0, 8.0);
  assert log2_8 == 3.0;

  // Establish log₈(x) = y/3
  var log8_x := logb(8.0, x);
  assert log8_x == y / 3.0 by {
    logb_change_base(8.0, 2.0, x);
  }

  // From the constraint, we need to determine the sign of y
  // For log₂(log₈(x)) to be defined, we need log₈(x) > 0, so y/3 > 0, thus y > 0
  // For log₈(log₂(x)) to be defined, we need log₂(x) > 0, so y > 0
  assert y > 0.0 by {
    // log₂(log₈(x)) is defined, so log₈(x) > 0
    // log₈(x) = y/3, so y/3 > 0, thus y > 0
  }

  // Now compute log₈(y)
  var log8_y := logb(8.0, y);
  assert log8_y == logb(2.0, y) / 3.0 by {
    logb_change_base(8.0, 2.0, y);
  }

  // From the constraint: log₂(y/3) = log₈(y)
  var lhs := logb(2.0, log8_x);
  var rhs := logb(8.0, y);
  assert lhs == rhs; // This is our constraint

  // lhs = log₂(y/3)
  assert lhs == logb(2.0, y / 3.0);

  // Expand log₂(y/3)
  var log2_y := logb(2.0, y);
  var log2_3 := logb(2.0, 3.0);

  calc {
     logb(2.0, y / 3.0);
  == { logb_div(2.0, y, 3.0); }
     logb(2.0, y) - logb(2.0, 3.0);
  == log2_y - log2_3;
  }

  // So we have: log2_y - log2_3 = log2_y / 3
  assert log2_y - log2_3 == log2_y / 3.0;

  // Solve for log2_y
  // log2_y - log2_y/3 = log2_3
  // (2/3)log2_y = log2_3
  // log2_y = (3/2)log2_3
  assert (2.0 / 3.0) * log2_y == log2_3;
  assert log2_y == (3.0 / 2.0) * log2_3;

  // log2_y = (3/2)log2_3 = log₂(3^(3/2))
  calc {
     log2_y;
  == (3.0 / 2.0) * log2_3;
  == { logb_rpow(2.0, 3.0, 3.0 / 2.0); }
     logb(2.0, rpow(3.0, 3.0 / 2.0));
  }

  // Therefore y = 3^(3/2)
  var target := rpow(3.0, 3.0 / 2.0);
  assert logb(2.0, y) == logb(2.0, target);
  assert y == target by {
    rpow_logb(2.0, y);
    rpow_logb(2.0, target);
  }

  // y² = (3^(3/2))² = 3^3 = 27
  calc {
     Real.pow(y, 2);
  == y * y;
  == target * target;
  == rpow(3.0, 3.0 / 2.0) * rpow(3.0, 3.0 / 2.0);
  == { rpow_add(3.0, 3.0 / 2.0, 3.0 / 2.0); }
     rpow(3.0, 3.0 / 2.0 + 3.0 / 2.0);
  == rpow(3.0, 3.0);
  == { pow_eq_rpow(3.0, 3); }
     Real.pow(3.0, 3);
  == 27.0;
  }
}

lemma lemma_log2_8()
  ensures logb(2.0, 8.0) == 3.0
{
  calc {
     logb(2.0, 8.0);
  == logb(2.0, Real.pow(2.0, 3));
  == { logb_pow(2.0, 2.0, 3); }
     3.0 * logb(2.0, 2.0);
  == { logb_base(2.0); }
     3.0 * 1.0;
  == 3.0;
  }
}
