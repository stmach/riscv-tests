# See LICENSE for license details.

#*****************************************************************************
# fadd.S
#-----------------------------------------------------------------------------
#
# Test f{add|sub|mul}.h instructions.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_FP_OP2_H( 2,  fadd.h, 0,             0x4300,     0x4100,     0x3c00 );
  TEST_FP_OP2_H( 3,  fadd.h, 1,             0xe4d2,     0xe4d3,     0x3c66 );
  TEST_FP_OP2_H( 4,  fadd.h, 1,             0x4248,     0x4248,     0x0002 );

  TEST_FP_OP2_H( 5,  fsub.h, 0,             0x3e00,     0x4100,     0x3c00 );
  TEST_FP_OP2_H( 6,  fsub.h, 1,             0xe4d2,     0xe4d3,     0xbc66 );
  TEST_FP_OP2_H( 7,  fsub.h, 1,             0x4248,     0x4248,     0x0002 );

  TEST_FP_OP2_H( 8,  fmul.h, 0,             0x4100,     0x4100,     0x3c00 );
  TEST_FP_OP2_H( 9,  fmul.h, 1,             0x654e,     0xe4d3,     0xbc66 );
  TEST_FP_OP2_H(10,  fmul.h, 1,             0x0006,     0x4248,     0x0002 );

  # Is the canonical NaN generated for Inf - Inf?
  TEST_FP_OP2_H(11,  fsub.h, 0x10, qNaNh, Inf, Inf);

  # TEST_FP_OP2_H( 2,  fadd.h, 0,                3.5,        2.5,        1.0 );
  # TEST_FP_OP2_H( 3,  fadd.h, 1,              -1234,      -1235,        1.1 );
  # TEST_FP_OP2_H( 4,  fadd.h, 1,         3.14159265, 3.14159265,  0.0000001 );

  # TEST_FP_OP2_H( 5,  fsub.h, 0,                1.5,        2.5,        1.0 );
  # TEST_FP_OP2_H( 6,  fsub.h, 1,              -1234,      -1235,       -1.1 );
  # TEST_FP_OP2_H( 7,  fsub.h, 1,         3.14159265, 3.14159265,  0.0000001 );

  # TEST_FP_OP2_H( 8,  fmul.h, 0,                2.5,        2.5,        1.0 );
  # TEST_FP_OP2_H( 9,  fmul.h, 1,               1358,      -1235,       -1.1 );
  # TEST_FP_OP2_H(10,  fmul.h, 1,            3.6e-07, 3.14159265,  0.0000001 );

  # # Is the canonical NaN generated for Inf - Inf?
  # TEST_FP_OP2_H(11,  fsub.h, 0x10, qNaNh, Inf, Inf);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
