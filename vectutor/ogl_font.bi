#ifndef __OGL_FONT_BI_INCLUDE__
#define __OGL_FONT_BI_INCLUDE__

#include once "vector2.bi"
using vectors

declare sub ogl_draw_char _
    ( _
        byval ch as const integer, _
        byref p as const VECTOR2 _
    )

declare sub ogl_draw_string overload _
    ( _
        byref txt as const string _
    )

declare sub ogl_draw_string _
    ( _
        byref txt as const string, _
        byref p as const VECTOR2 _
    )

declare sub ogl_font_set_scaling _
    ( _
        byref s as const VECTOR2 _
    )

declare sub ogl_font_set_height _
    ( _
        byval h as const REAL _
    )

declare sub ogl_font_set_spacing _
    ( _
        byval h as const REAL _
    )

declare sub ogl_font_set_current_pos _
	( _
		byref p as const VECTOR2 _
	)

declare function ogl_font_get_height _
	( _
		byref txt as const string _
	) as REAL

declare function ogl_font_get_width _
	( _
		byref txt as const string _
	) as REAL

#endif
