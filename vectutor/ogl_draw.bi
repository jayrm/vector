'' ========================================================
'' ogl_draw.bi
'' ========================================================

#ifndef __OGL_DRAW_BI_INCLUDE__
#define __OGL_DRAW_BI_INCLUDE__

#include once "vector2.bi"
#include once "line2.bi"

using vectors

enum LINE_ARROW_STYLE
    LINE_ARROW_NONE = 0
    LINE_ARROW_TO = 1
    LINE_ARROW_FROM = 2
    LINE_ARROW_BOTH = 3
    
end enum

declare sub draw_triangle _
    ( _
        byref a as const VECTOR2, _
        byref b as const VECTOR2, _
        byref c as const VECTOR2 _
    )

declare sub draw_rectangle _
    ( _
        byref a as const VECTOR2, _
        byref b as const VECTOR2 _
	)	

declare sub draw_disc _
	( _
		byref c as const VECTOR2, _
		byval r as const REAL _
	)

declare sub draw_donut _
	( _
		byref c as const VECTOR2, _
		byval r1 as const REAL, _
		byval r2 as const REAL _
	)

declare sub draw_point _
    ( _
        byref p as const VECTOR2, _
        byval size as const REAL = 2.5 _
    )

declare sub draw_arrow_head _
    ( _
        byref p as const VECTOR2, _
        byref d as const VECTOR2, _
        byval headlength as const REAL = 10.0, _
        byval headwidth as const REAL = 5.0 _
    )

declare sub draw_line _
    ( _
        byref p1 as const VECTOR2, _
        byref p2 as const VECTOR2, _
        byval linewidth as const REAL = 1.0 _
    )

declare sub draw_arrow _
    ( _
        byref p1 as const VECTOR2, _
        byref p2 as const VECTOR2, _
        byval style as const LINE_ARROW_STYLE = LINE_ARROW_TO, _
        byval linewidth as const REAL = 1.0, _
        byval headlength as const REAL = 10.0, _
        byval headwidth as const REAL = 5.0 _
    )

declare sub draw_circle _
	( _
		byref c as const VECTOR2, _
		byval r as const REAL, _
        byval linewidth as const REAL = 1.0 _
	)

declare sub draw_line_eq _
	( _
		byref l as const LINE2 _
	)


#endif
