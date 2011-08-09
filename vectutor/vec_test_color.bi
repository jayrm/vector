#ifndef __VEC_TEST_COLOR_BI_INCLUDE__
#define __VEC_TEST_COLOR_BI_INCLUDE__

#include once "real.bi"

using vectors

enum VEC_TEST_COLOR

  COLOR_TEXT
  COLOR_POINTS
  COLOR_CONS
  
  COLOR_BLACK
  COLOR_BLUE
  COLOR_GREEN
  COLOR_CYAN
  COLOR_RED
  COLOR_MAGENTA
  COLOR_YELLOW
  COLOR_WHITE

  
  VEC_TEST_COLORS

end enum

declare sub SetColor( index as VEC_TEST_COLOR, intensity as REAL = 1.0 )

#endif