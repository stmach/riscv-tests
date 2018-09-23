# See LICENSE for license details.

#*****************************************************************************
# move.S
#-----------------------------------------------------------------------------
#
# This test verifies that fmv.h.x, fmv.x.h, and fsgnj[x|n].h work properly.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

#TODO: make 32-bit compatible version
#define TEST_FSGNJH(n, insn, new_sign, rs1_sign, rs2_sign) \
  TEST_CASE(n, a0, 0x1234 | (-(new_sign) << 15), \
    li a1, ((rs1_sign) << 15) | 0x1234; \
    li a2, -(rs2_sign); \
    fmv.h.x f1, a1; \
    fmv.h.x f2, a2; \
    insn f0, f1, f2; \
    fmv.x.h a0, f0)

  TEST_FSGNJH(10, fsgnj.h, 0, 0, 0)
  TEST_FSGNJH(11, fsgnj.h, 1, 0, 1)
  TEST_FSGNJH(12, fsgnj.h, 0, 1, 0)
  TEST_FSGNJH(13, fsgnj.h, 1, 1, 1)

  TEST_FSGNJH(20, fsgnjn.h, 1, 0, 0)
  TEST_FSGNJH(21, fsgnjn.h, 0, 0, 1)
  TEST_FSGNJH(22, fsgnjn.h, 1, 1, 0)
  TEST_FSGNJH(23, fsgnjn.h, 0, 1, 1)

  TEST_FSGNJH(30, fsgnjx.h, 0, 0, 0)
  TEST_FSGNJH(31, fsgnjx.h, 1, 0, 1)
  TEST_FSGNJH(32, fsgnjx.h, 1, 1, 0)
  TEST_FSGNJH(33, fsgnjx.h, 0, 1, 1)

#if __riscv_flen >= 32
// Test fsgnj.h in conjunction with single-precision moves
#define TEST_FSGNJS(n, rd, rs1, rs2) \
  TEST_CASE(n, a0, (rd) | (-((rd) >> 15) << 16), \
    li a1, rs1; \
    li a2, rs2; \
    fmv.w.x f1, a1; \
    fmv.w.x f2, a2; \
    fsgnj.h f0, f1, f2; \
    fmv.x.h a0, f0); \
  TEST_CASE(1##n, a0, (rd) | 0xffffffffffff0000, \
    li a1, rs1; \
    li a2, rs2; \
    fmv.w.x f1, a1; \
    fmv.w.x f2, a2; \
    fsgnj.h f0, f1, f2; \
    fmv.x.w a0, f0)

  TEST_FSGNJS(40, 0x7e00, 0x7ffffffffffe1234, 0)
  TEST_FSGNJS(41, 0x7e00, 0xfffffffffffe1234, 0)
  TEST_FSGNJS(42, 0x7e00, 0x7fffffffffff1234, 0)
  TEST_FSGNJS(43, 0x1234, 0xffffffffffff1234, 0)

  TEST_FSGNJS(50, 0x7e00, 0x7ffffffffffe1234, 0x8000)
  TEST_FSGNJS(51, 0x7e00, 0xfffffffffffe1234, 0x8000)
  TEST_FSGNJS(52, 0x7e00, 0x7fffffffffff1234, 0x8000)
  TEST_FSGNJS(53, 0x1234, 0xffffffffffff1234, 0x8000)

  TEST_FSGNJS(60, 0xfe00, 0x7ffffffffffe1234, 0xffffffffffff8000)
  TEST_FSGNJS(61, 0xfe00, 0xfffffffffffe1234, 0xffffffffffff8000)
  TEST_FSGNJS(62, 0x9234, 0xffffffffffff1234, 0xffffffffffff8000)
  TEST_FSGNJS(63, 0x1234, 0xffffffffffff1234, 0x7fffffffffff8000)
#endif


#if __riscv_flen >= 64
// Test fsgnj.h in conjunction with double-precision moves
#define TEST_FSGNJD(n, rd, rs1, rs2) \
  TEST_CASE(n, a0, (rd) | (-((rd) >> 15) << 16), \
    li a1, rs1; \
    li a2, rs2; \
    fmv.d.x f1, a1; \
    fmv.d.x f2, a2; \
    fsgnj.h f0, f1, f2; \
    fmv.x.h a0, f0); \
  TEST_CASE(1##n, a0, (rd) | 0xffffffffffff0000, \
    li a1, rs1; \
    li a2, rs2; \
    fmv.d.x f1, a1; \
    fmv.d.x f2, a2; \
    fsgnj.h f0, f1, f2; \
    fmv.x.d a0, f0)

  TEST_FSGNJD(40, 0x7e00, 0x7ffffffffffe1234, 0)
  TEST_FSGNJD(41, 0x7e00, 0xfffffffffffe1234, 0)
  TEST_FSGNJD(42, 0x7e00, 0x7fffffffffff1234, 0)
  TEST_FSGNJD(43, 0x1234, 0xffffffffffff1234, 0)

  TEST_FSGNJD(50, 0x7e00, 0x7ffffffffffe1234, 0x8000)
  TEST_FSGNJD(51, 0x7e00, 0xfffffffffffe1234, 0x8000)
  TEST_FSGNJD(52, 0x7e00, 0x7fffffffffff1234, 0x8000)
  TEST_FSGNJD(53, 0x1234, 0xffffffffffff1234, 0x8000)

  TEST_FSGNJD(60, 0xfe00, 0x7ffffffffffe1234, 0xffffffffffff8000)
  TEST_FSGNJD(61, 0xfe00, 0xfffffffffffe1234, 0xffffffffffff8000)
  TEST_FSGNJD(62, 0x9234, 0xffffffffffff1234, 0xffffffffffff8000)
  TEST_FSGNJD(63, 0x1234, 0xffffffffffff1234, 0x7fffffffffff8000)

// Test fsgnj.d in conjunction with half-precision moves
#define TEST_FSGNJD_HP(n, isnan, rd, rs1, rs2) \
  TEST_CASE(n, a0, ((rd) & 0xffff) | (-(((rd) >> 15) & 1) << 16), \
    li a1, rs1; \
    li a2, rs2; \
    fmv.d.x f1, a1; \
    fmv.d.x f2, a2; \
    fsgnj.d f0, f1, f2; \
    feq.h a0, f0, f0; \
    addi a0, a0, -!(isnan); \
    bnez a0, 1f; \
    fmv.x.h a0, f0; \
    1:); \
  TEST_CASE(1##n, a0, rd, \
    li a1, rs1; \
    li a2, rs2; \
    fmv.d.x f1, a1; \
    fmv.d.x f2, a2; \
    fsgnj.d f0, f1, f2; \
    fmv.x.d a0, f0; \
    1:)

  TEST_FSGNJD_HP(70, 0, 0xffffffffffff1111, 0xffffffffffff1111, 0xffffffffffff1111)
  TEST_FSGNJD_HP(71, 1, 0x7fffffffffff1111, 0xffffffffffff1111, 0x7fffffffffff1111)
  TEST_FSGNJD_HP(72, 0, 0xffffffffffff1111, 0xffffffffffff1111, 0xffffffffffff9111)
  TEST_FSGNJD_HP(73, 0, 0xffffffffffff1111, 0xffffffffffff1111, 0x8000000000000000)
  TEST_FSGNJD_HP(74, 0, 0xffffffffffff1111, 0x7fffffffffff1111, 0xffffffffffff1111)
  TEST_FSGNJD_HP(75, 1, 0x7fffffffffff1111, 0x7fffffffffff1111, 0x7fffffffffff1111)
  TEST_FSGNJD_HP(76, 0, 0xffffffffffff1111, 0x7fffffffffff1111, 0xffffffffffff9111)
  TEST_FSGNJD_HP(77, 0, 0xffffffffffff1111, 0x7fffffffffff1111, 0x8000000000000000)
#endif


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
