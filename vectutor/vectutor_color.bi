#ifndef __vectutor_COLOR_BI_INCLUDE__
#define __vectutor_COLOR_BI_INCLUDE__

	#include once "real.bi"

	enum vectutor_COLOR

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

  
	  vectutor_COLORS

	end enum

	declare sub SetColor( byval index as const vectutor_COLOR, byval intensity as const REAL = 1.0 )

#endif
