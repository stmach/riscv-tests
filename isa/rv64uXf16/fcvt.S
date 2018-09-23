# See LICENSE for license details.

#*****************************************************************************
# fcvt.S
#-----------------------------------------------------------------------------
#
# Test fcvt.h.{wu|w|lu|l}, fcvt.s.d, and fcvt.d.s instructions.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_INT_FP_OP_H(2,  fcvt.h.w,                0x4000,  2);
  TEST_INT_FP_OP_H(3,  fcvt.h.w,                0xc000, -2);

  TEST_INT_FP_OP_H(4, fcvt.h.wu,                0x4000,  2);
  TEST_INT_FP_OP_H(5, fcvt.h.wu,                0x7c00, -2);

#if __riscv_xlen >= 64
  TEST_INT_FP_OP_H(6,  fcvt.h.l,                0x4000,  2);
  TEST_INT_FP_OP_H(7,  fcvt.h.l,                0xc000, -2);

  TEST_INT_FP_OP_H(8, fcvt.h.lu,                0x4000,  2);
  TEST_INT_FP_OP_H(9, fcvt.h.lu,                0x7c00, -2);
#endif

#if __riscv_flen >= 32
  TEST_FCVT_H_S(10,   -1.5,   -1.5)
  TEST_FCVT_S_H(12, 0xbe00, 0xbe00)
#endif
#if __riscv_flen >= 64
  TEST_FCVT_H_D(11,   -1.5,   -1.5)
  TEST_FCVT_D_H(13, 0xbe00, 0xbe00)
#endif

#   TEST_INT_FP_OP_H(2,  fcvt.h.w,                   2.0,  2);
#   TEST_INT_FP_OP_H(3,  fcvt.h.w,                  -2.0, -2);

#   TEST_INT_FP_OP_H(4, fcvt.h.wu,                   2.0,  2);
#   TEST_INT_FP_OP_H(5, fcvt.h.wu,                   Inf, -2);

# #if __riscv_xlen >= 64
#   TEST_INT_FP_OP_H(6,  fcvt.h.l,                   2.0,  2);
#   TEST_INT_FP_OP_H(7,  fcvt.h.l,                  -2.0, -2);

#   TEST_INT_FP_OP_H(8, fcvt.h.lu,                   2.0,  2);
#   TEST_INT_FP_OP_H(9, fcvt.h.lu,                   Inf, -2);
# #endif

# #if __riscv_flen >= 32
#   TEST_FCVT_H_S(10, -1.5, -1.5)
#   TEST_FCVT_S_H(12, -1.5, -1.5)
# #endif
# #if __riscv_flen >= 64
#   TEST_FCVT_H_D(11, -1.5, -1.5)
#   TEST_FCVT_D_H(13, -1.5, -1.5)
# #endif

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
