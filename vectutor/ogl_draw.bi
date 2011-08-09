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
        a as VECTOR2, _
        b as VECTOR2, _
        c as VECTOR2 _
    )

declare sub draw_rectangle _
    ( _
        a as VECTOR2, _
        b as VECTOR2 _
	)	

declare sub draw_disc _
	( _
		c as VECTOR2, _
		r as REAL _
	)

declare sub draw_donut _
	( _
		c as VECTOR2, _
		r1 as REAL, _
		r2 as REAL _
	)

declare sub draw_point _
    ( _
        p as VECTOR2, _
        size as REAL = 2.5 _
    )

declare sub draw_arrow_head _
    ( _
        p as VECTOR2, _
        d as VECTOR2, _
        headlength as REAL = 10.0, _
        headwidth as REAL = 5.0 _
    )

declare sub draw_line _
    ( _
        p1 as VECTOR2, _
        p2 as VECTOR2, _
        linewidth as REAL = 1.0 _
    )

declare sub draw_arrow _
    ( _
        p1 as VECTOR2, _
        p2 as VECTOR2, _
        style as LINE_ARROW_STYLE = LINE_ARROW_TO, _
        linewidth as REAL = 1.0, _
        headlength as REAL = 10.0, _
        headwidth as REAL = 5.0 _
    )

declare sub draw_circle _
	( _
		c as VECTOR2, _
		r as REAL, _
        linewidth as REAL = 1.0 _
	)

declare sub draw_line_eq _
	( _
		l as LINE2 _
	)


#endif
