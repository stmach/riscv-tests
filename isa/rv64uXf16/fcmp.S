# See LICENSE for license details.

#*****************************************************************************
# fcmp.S
#-----------------------------------------------------------------------------
#
# Test f{eq|lt|le}.h instructions.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  # TEST_FP_CMP_OP_H( 2, feq.h, 0x00, 1, 0xbd71, 0xbd71)
  # TEST_FP_CMP_OP_H( 3, fle.h, 0x00, 1, 0xbd71, 0xbd71)
  # TEST_FP_CMP_OP_H( 4, flt.h, 0x00, 0, 0xbd71, 0xbd71)

  # TEST_FP_CMP_OP_H( 5, feq.h, 0x00, 0, 0xbd7b, 0xbd71)
  # TEST_FP_CMP_OP_H( 6, fle.h, 0x00, 1, 0xbd7b, 0xbd71)
  # TEST_FP_CMP_OP_H( 7, flt.h, 0x00, 1, 0xbd7b, 0xbd71)

  # # Only sNaN should signal invalid for feq.
  # TEST_FP_CMP_OP_H( 8, feq.h, 0x00, 0, qNaNh, 0)
  # TEST_FP_CMP_OP_H( 9, feq.h, 0x00, 0, qNaNh, qNaNh)
  # TEST_FP_CMP_OP_H(10, feq.h, 0x10, 0, sNaNh, 0)

  # # qNaN should signal invalid for fle/flt.
  # TEST_FP_CMP_OP_H(11, flt.h, 0x10, 0, qNaNh, 0)
  # TEST_FP_CMP_OP_H(12, flt.h, 0x10, 0, qNaNh, qNaNh)
  # TEST_FP_CMP_OP_H(13, flt.h, 0x10, 0, sNaNh, 0)
  # TEST_FP_CMP_OP_H(14, fle.h, 0x10, 0, qNaNh, 0)
  # TEST_FP_CMP_OP_H(15, fle.h, 0x10, 0, qNaNh, qNaNh)
  # TEST_FP_CMP_OP_H(16, fle.h, 0x10, 0, sNaNh, 0)

  TEST_FP_CMP_OP_H( 2, feq.h, 0x00, 1, -1.36, -1.36)
  TEST_FP_CMP_OP_H( 3, fle.h, 0x00, 1, -1.36, -1.36)
  TEST_FP_CMP_OP_H( 4, flt.h, 0x00, 0, -1.36, -1.36)

  TEST_FP_CMP_OP_H( 5, feq.h, 0x00, 0, -1.37, -1.36)
  TEST_FP_CMP_OP_H( 6, fle.h, 0x00, 1, -1.37, -1.36)
  TEST_FP_CMP_OP_H( 7, flt.h, 0x00, 1, -1.37, -1.36)

  # Only sNaN should signal invalid for feq.
  TEST_FP_CMP_OP_H( 8, feq.h, 0x00, 0, NaN, 0)
  TEST_FP_CMP_OP_H( 9, feq.h, 0x00, 0, NaN, NaN)
  TEST_FP_CMP_OP_H(10, feq.h, 0x10, 0, sNaNh, 0)

  # qNaN should signal invalid for fle/flt.
  TEST_FP_CMP_OP_H(11, flt.h, 0x10, 0, NaN, 0)
  TEST_FP_CMP_OP_H(12, flt.h, 0x10, 0, NaN, NaN)
  TEST_FP_CMP_OP_H(13, flt.h, 0x10, 0, sNaNh, 0)
  TEST_FP_CMP_OP_H(14, fle.h, 0x10, 0, NaN, 0)
  TEST_FP_CMP_OP_H(15, fle.h, 0x10, 0, NaN, NaN)
  TEST_FP_CMP_OP_H(16, fle.h, 0x10, 0, sNaNh, 0)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
