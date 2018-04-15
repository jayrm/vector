'' ========================================================
'' ogl_font.bas
'' ========================================================

#include once "GL/gl.bi"
#include once "ogl_draw.bi"
#include once "vector2.bi"
#include once "hershey.bi"

using vectors

#include once "hershey_romans.bi"

#define BASE_GLYPH_SCALE (1.0/25.0)

dim shared as VECTOR2 glyph_scale = ( BASE_GLYPH_SCALE, BASE_GLYPH_SCALE )

dim shared last_char_w as REAL
dim shared last_string_w as REAL
dim shared current_pos as VECTOR2
dim shared glyph_spacing_y as REAL = BASE_GLYPH_SCALE * 2

sub ogl_font_set_scaling _
    ( _
        byref s as const VECTOR2 _
    )

    glyph_scale = s * BASE_GLYPH_SCALE

end sub

sub ogl_font_set_height _
    ( _
        byval h as const REAL _
    )
    
    glyph_scale.x = abs(h) * BASE_GLYPH_SCALE
    glyph_scale.y = h * BASE_GLYPH_SCALE
    
end sub

sub ogl_font_set_spacing _
    ( _
        byval h as const REAL _
    )
    
    glyph_spacing_y = h
    
end sub

sub ogl_font_set_current_pos _
	( _
		byref p as const VECTOR2 _
	)
	
	current_pos = p

end sub

sub ogl_draw_char _
    ( _
        byval ch as const integer, _
        byref p as const VECTOR2 _
    )

    dim x1 as integer
    dim x2 as integer
    dim x as integer
    dim y as integer
    dim i as integer
    dim p1 as VECTOR2
    dim t as VECTOR2

    if ch < 32 or ch > 127 then
        last_char_w = 0
        exit sub
    end if

	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
	glEnable( GL_BLEND )
	glLineWidth( 0.5 )
    glBegin( GL_LINE_STRIP )

    x1 = glyph_vectors_romans( glyph_index_romans( ch ).index + 0 ).x
    x2 = glyph_vectors_romans( glyph_index_romans( ch ).index + 0 ).y

    for i = 1 to glyph_index_romans( ch ).count - 1

        x = glyph_vectors_romans( glyph_index_romans( ch ).index + i ).x
        y = glyph_vectors_romans( glyph_index_romans( ch ).index + i ).y

        if( x = -50 and y = 0 ) then
            glEnd( )
            glBegin( GL_LINE_STRIP )
        else
            t.x = CREAL(x - x1) * glyph_scale.x + p.x
            t.y = -CREAL(y) * glyph_scale.y + p.y

            glVertex2d( t.x, t.y )
        end if

    next

    glEnd( )
	glDisable( GL_BLEND )

    last_char_w = (x2 - x1) * glyph_scale.x

end sub

sub ogl_draw_string overload _
	( _
        byref txt as const string _
	)

    dim t as VECTOR2 = current_pos
    dim ch as integer
    dim i as integer

	last_string_w = 0.0

    for i = 1 to len(txt)
        ch = asc(mid(txt,i,1))
        ogl_draw_char( ch, t )
        t.x += last_char_w
        last_string_w += last_char_w
    next 

	current_pos -= type( 0, glyph_spacing_y )

end sub

sub ogl_draw_string _
    ( _
        byref txt as const string, _
        byref p as const VECTOR2 _
    )

	current_pos = p
	ogl_draw_string( txt )

end sub

function ogl_font_get_height _
	( _
		byref txt as const string _
	) as REAL

	function = glyph_spacing_y

end function

function ogl_font_get_width _
	( _
		byref txt as const string _
	) as REAL

	dim w as real = 0

	for i as integer = 1 to len(txt)
		dim ch as integer = asc(mid(txt,i,1))
		select case ch
		case 32 to 127
			dim x1 as integer = glyph_vectors_romans( glyph_index_romans( ch ).index + 0 ).x
			dim x2 as integer = glyph_vectors_romans( glyph_index_romans( ch ).index + 0 ).y
			w += creal(x2 - x1) * glyph_scale.x
		end select
	next

	function = w

end function
