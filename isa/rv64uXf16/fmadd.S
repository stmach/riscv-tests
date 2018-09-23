# See LICENSE for license details.

#*****************************************************************************
# fmadd.S
#-----------------------------------------------------------------------------
#
# Test f[n]m{add|sub}.h instructions.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_FP_OP3_D( 2,  fmadd.h, 0, 0x4300, 0x3c00, 0x4100, 0x3c00 );
  TEST_FP_OP3_D( 3,  fmadd.h, 1, 0x64d4, 0xbc00, 0xe4d3, 0x3c66 );
  TEST_FP_OP3_D( 4,  fmadd.h, 0, 0xca00, 0x4000, 0xc500, 0xc000 );

  TEST_FP_OP3_D( 5, fnmadd.h, 0, 0xc300, 0x3c00, 0x4100, 0x3c00 );
  TEST_FP_OP3_D( 6, fnmadd.h, 1, 0xe4d4, 0xbc00, 0xe4d3, 0x3c66 );
  TEST_FP_OP3_D( 7, fnmadd.h, 0, 0x4a00, 0x4000, 0xc500, 0xc000 );

  TEST_FP_OP3_D( 8,  fmsub.h, 0, 0x3e00, 0x3c00, 0x4100, 0x3c00 );
  TEST_FP_OP3_D( 9,  fmsub.h, 1, 0x64d2, 0xbc00, 0xe4d3, 0x3c66 );
  TEST_FP_OP3_D(10,  fmsub.h, 0, 0xc800, 0x4000, 0xc500, 0xc000 );

  TEST_FP_OP3_D(11, fnmsub.h, 0, 0xbe00, 0x3c00, 0x4100, 0x3c00 );
  TEST_FP_OP3_D(12, fnmsub.h, 1, 0xe4d2, 0xbc00, 0xe4d3, 0x3c66 );
  TEST_FP_OP3_D(13, fnmsub.h, 0, 0x4800, 0x4000, 0xc500, 0xc000 );

  # TEST_FP_OP3_D( 2,  fmadd.h, 0,   3.5,  1.0,   2.5,  1.0 );
  # TEST_FP_OP3_D( 3,  fmadd.h, 1,  1236, -1.0, -1235,  1.1 );
  # TEST_FP_OP3_D( 4,  fmadd.h, 0, -12.0,  2.0,  -5.0, -2.0 );

  # TEST_FP_OP3_D( 5, fnmadd.h, 0,  -3.5,  1.0,   2.5,  1.0 );
  # TEST_FP_OP3_D( 6, fnmadd.h, 1, -1236, -1.0, -1235,  1.1 );
  # TEST_FP_OP3_D( 7, fnmadd.h, 0,  12.0,  2.0,  -5.0, -2.0 );

  # TEST_FP_OP3_D( 8,  fmsub.h, 0,  1.5,  1.0,   2.5,  1.0 );
  # TEST_FP_OP3_D( 9,  fmsub.h, 1, 1234, -1.0, -1235,  1.1 );
  # TEST_FP_OP3_D(10,  fmsub.h, 0, -8.0,  2.0,  -5.0, -2.0 );

  # TEST_FP_OP3_D(11, fnmsub.h, 0,  -1.5,  1.0,   2.5,  1.0 );
  # TEST_FP_OP3_D(12, fnmsub.h, 1, -1234, -1.0, -1235,  1.1 );
  # TEST_FP_OP3_D(13, fnmsub.h, 0,   8.0,  2.0,  -5.0, -2.0 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
