# See LICENSE for license details.

#*****************************************************************************
# fmin.S
#-----------------------------------------------------------------------------
#
# Test f{min|max}.h instructinos.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_FP_OP2_D( 2,  fmin.h, 0,  0x3c00, 0x4100, 0x3c00 );
  TEST_FP_OP2_D( 3,  fmin.h, 0,  0xe4d3, 0xe4d3, 0x3c66 );
  TEST_FP_OP2_D( 4,  fmin.h, 0,  0xe4d3, 0x3c66, 0xe4d3 );
  TEST_FP_OP2_D( 5,  fmin.h, 0,  0xe4d3, 0xfe33, 0xe4d3 );
  TEST_FP_OP2_D( 6,  fmin.h, 0,  0x0002, 0x4248, 0x0002 );
  TEST_FP_OP2_D( 7,  fmin.h, 0,  0xc000, 0xbc00, 0xc000 );

  TEST_FP_OP2_D(12,  fmax.h, 0,  0x4100, 0x4100, 0x3c00 );
  TEST_FP_OP2_D(13,  fmax.h, 0,  0x3c66, 0xe4d3, 0x3c66 );
  TEST_FP_OP2_D(14,  fmax.h, 0,  0x3c66, 0x3c66, 0xe4d3 );
  TEST_FP_OP2_D(15,  fmax.h, 0,  0xe4d3, 0xfe33, 0xe4d3 );
  TEST_FP_OP2_D(16,  fmax.h, 0,  0x4248, 0x4248, 0x0002 );
  TEST_FP_OP2_D(17,  fmax.h, 0,  0xbc00, 0xbc00, 0xc000 );

  # FMIN(sNaN, x) = x
  TEST_FP_OP2_D(20,  fmax.h, 0x10, 0x3c00, sNaNh, 0x3c00);
  # FMIN(qNaN, qNaN) = canonical NaN
  TEST_FP_OP2_D(21,  fmax.h, 0x00, qNaNh, 0xfe33, 0xfe33);

  # -0.0 < +0.0
  TEST_FP_OP2_D(30,  fmin.h, 0, 0x8000, 0x8000, 0x0000 );
  TEST_FP_OP2_D(31,  fmin.h, 0, 0x8000, 0x0000, 0x8000 );
  TEST_FP_OP2_D(32,  fmax.h, 0, 0x0000, 0x8000, 0x0000 );
  TEST_FP_OP2_D(33,  fmax.h, 0, 0x0000, 0x0000, 0x8000 );

  # TEST_FP_OP2_D( 2,  fmin.h, 0,        1.0,        2.5,        1.0 );
  # TEST_FP_OP2_D( 3,  fmin.h, 0,      -1235,      -1235,        1.1 );
  # TEST_FP_OP2_D( 4,  fmin.h, 0,      -1235,        1.1,      -1235 );
  # TEST_FP_OP2_D( 5,  fmin.h, 0,      -1235,        NaN,      -1235 );
  # TEST_FP_OP2_D( 6,  fmin.h, 0,  0.0000001, 3.14159265,  0.0000001 );
  # TEST_FP_OP2_D( 7,  fmin.h, 0,       -2.0,       -1.0,       -2.0 );

  # TEST_FP_OP2_D(12,  fmax.h, 0,        2.5,        2.5,        1.0 );
  # TEST_FP_OP2_D(13,  fmax.h, 0,        1.1,      -1235,        1.1 );
  # TEST_FP_OP2_D(14,  fmax.h, 0,        1.1,        1.1,      -1235 );
  # TEST_FP_OP2_D(15,  fmax.h, 0,      -1235,        NaN,      -1235 );
  # TEST_FP_OP2_D(16,  fmax.h, 0, 3.14159265, 3.14159265,  0.0000001 );
  # TEST_FP_OP2_D(17,  fmax.h, 0,       -1.0,       -1.0,       -2.0 );

  # # FMIN(sNaN, x) = x
  # TEST_FP_OP2_D(20,  fmax.h, 0x10, 1.0, sNaNh, 1.0);
  # # FMIN(qNaN, qNaN) = canonical NaN
  # TEST_FP_OP2_D(21,  fmax.h, 0x00, qNaNh, NaN, NaN);

  # # -0.0 < +0.0
  # TEST_FP_OP2_D(30,  fmin.h, 0,       -0.0,       -0.0,        0.0 );
  # TEST_FP_OP2_D(31,  fmin.h, 0,       -0.0,        0.0,       -0.0 );
  # TEST_FP_OP2_D(32,  fmax.h, 0,        0.0,       -0.0,        0.0 );
  # TEST_FP_OP2_D(33,  fmax.h, 0,        0.0,        0.0,       -0.0 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
