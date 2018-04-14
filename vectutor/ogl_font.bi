#ifndef __OGL_FONT_BI_INCLUDE__
#define __OGL_FONT_BI_INCLUDE__

#include once "vector2.bi"
using vectors

declare sub ogl_draw_char _
    ( _
        ch as integer, _
        p as VECTOR2 _
    )

declare sub ogl_draw_string overload _
    ( _
        txt as string _
    )

declare sub ogl_draw_string _
    ( _
        txt as string, _
        p as VECTOR2 _
    )

declare sub ogl_font_set_scaling _
    ( _
        s as VECTOR2 _
    )

declare sub ogl_font_set_height _
    ( _
        h as REAL _
    )

declare sub ogl_font_set_spacing _
    ( _
        h as REAL _
    )

declare sub ogl_font_set_current_pos _
	( _
		p as VECTOR2 _
	)

#endif
