'' ========================================================
'' ogl_draw.bas
'' ========================================================

#include once "GL/gl.bi"
#include once "ogl_stuff.bi"
#include once "ogl_draw.bi"

#ifndef PI
#define PI 3.1415926535897932384626433832795#
#endif

#define NARCSTEPS 16
#define ARCSTEP (PI/NARCSTEPS)

'' --------------------------------------------------------

sub draw_triangle _
        ( _
            a as VECTOR2, _
            b as VECTOR2, _
            c as VECTOR2 _
        )

    glBegin( GL_TRIANGLES )

        glVertex2d( a.x, a.y )
        glVertex2d( b.x, b.y )
        glVertex2d( c.x, c.y )

    glEnd( )

end sub

sub draw_rectangle _
        ( _
            a as VECTOR2, _
            b as VECTOR2 _
        )

    glBegin( GL_TRIANGLES )

        glVertex2d( a.x, a.y )
        glVertex2d( b.x, a.y )
        glVertex2d( a.x, b.y )

        glVertex2d( a.x, b.y )
        glVertex2d( b.x, a.y )
        glVertex2d( b.x, b.y )

    glEnd( )

end sub


sub draw_disc _
	( _
		c as VECTOR2, _
		r as REAL _
	)

	glBegin( GL_TRIANGLE_FAN )

    glVertex2d( c.x, c.y )

	for a as REAL = 0 to NARCSTEPS * 2
        dim x as REAL = cos(a*ARCSTEP) * r
        dim y as REAL = sin(a*ARCSTEP) * r
        glVertex2d( c.x + x, c.y + y )
	next	

    glEnd( )


/'
	for a as REAL = 0 to 2 * PI step ARCSTEP
	
		dim p1 as VECTOR2 = VECTOR2( cos(a), sin(a) ) * r + c
		dim p2 as VECTOR2 = VECTOR2( cos(a+ARCSTEP), sin(a+ARCSTEP) ) * r + c

		draw_triangle( c, p1, p2 )
	
	next	
'/

end sub

sub draw_donut _
	( _
		c as VECTOR2, _
		r1 as REAL, _
		r2 as REAL _
	)

	for a as REAL = 0 to NARCSTEPS * 2
	
		dim a1 as VECTOR2 = ( cos(a*ARCSTEP), sin(a*ARCSTEP) )
		dim a2 as VECTOR2 = ( cos((a+1.0)*ARCSTEP), sin((a+1.0)*ARCSTEP) )
		
		dim p1 as VECTOR2 = a1 * r1 + c
		dim p2 as VECTOR2 = a1 * r2 + c
		dim p3 as VECTOR2 = a2 * r1 + c
		dim p4 as VECTOR2 = a2 * r2 + c

		draw_triangle( p1, p2, p4 )
		draw_triangle( p1, p4, p3 )
	
	next	

end sub


sub draw_point _
    ( _
        p as VECTOR2, _
        size as REAL = 2.5 _
    )

	draw_disc( p, size )

end sub

sub draw_arrow_head _
    ( _
        p as VECTOR2, _
        d as VECTOR2, _
        headlength as REAL = 10.0, _
        headwidth as REAL = 5.0 _
    )

    dim l as VECTOR2 = d.Unit * headlength
    dim w as VECTOR2 = d.Unit.Perp * headwidth * 0.5

    draw_triangle( p - l + w, p, p - l - w )

end sub

sub draw_line _
    ( _
        p1 as VECTOR2, _
        p2 as VECTOR2, _
        linewidth as REAL = 1.0 _
    )

    dim t as VECTOR2 = type<vector2>(p2 - p1).Unit.Perp * linewidth * 0.5
    
    draw_triangle( p1 - t, p1 + t, p2 + t )
    draw_triangle( p2 + t, p2 - t, p1 - t )

end sub

sub draw_arrow _
    ( _
        p1 as VECTOR2, _
        p2 as VECTOR2, _
        style as LINE_ARROW_STYLE = LINE_ARROW_TO, _
        linewidth as REAL = 1.0, _
        headlength as REAL = 10.0, _
        headwidth as REAL = 5.0 _
    )

    dim a as VECTOR2 = p1
    dim b as VECTOR2 = p2
    dim d as VECTOR2 = type<vector2>(b - a).Unit
    dim t as VECTOR2 = d.Perp * linewidth * 0.5
    dim l as VECTOR2 = d * headlength
    dim w as VECTOR2 = d.Perp * headwidth * 0.5

    if( (style and LINE_ARROW_TO) <> 0 ) then
        draw_triangle( b - l + w, b, b - l - w )
        b -= l
    end if

    if( (style and LINE_ARROW_FROM) <> 0 ) then
        draw_triangle( a + l + w, a, a + l - w )
        a += l
    end if

    draw_triangle( a - t, a + t, b + t )
    draw_triangle( b + t, b - t, a - t )

end sub

sub draw_circle _
	( _
		c as VECTOR2, _
		r as REAL, _
        linewidth as REAL = 1.0 _
	)

	if( linewidth = REAL_ZERO ) then

		glBegin( GL_LINE_LOOP )
	
		for a as REAL = 0 to 2 * PI step PI / 16
			glVertex2d( c.x + cos(a) * r, c.y + sin(a) * r )
		next	
	
		glEnd()

	else
		draw_donut( c, r - linewidth / 2, r + linewidth / 2 )	

	end if

end sub

sub draw_line_eq _
	( _
		l as LINE2 _
	)

	dim p1 as VECTOR2 = l.normal * -l.distance
	dim p2 as VECTOR2 = l.normal * 20 + p1

	dim x1 as REAL = gfx_world_left()
	dim y1 as REAL = gfx_world_bottom()
	dim x2 as REAL = gfx_world_right()
	dim y2 as REAL = gfx_world_top()

	dim BL as VECTOR2 = (x1,y1)
	dim TL as VECTOR2 = (x1,y2)
	dim BR as VECTOR2 = (x2,y1)
	dim TR as VECTOR2 = (x2,y2)

	dim d_BL as REAL = l.DistanceToPoint( BL )
	dim d_TL as REAL = l.DistanceToPoint( TL )
	dim d_BR as REAL = l.DistanceToPoint( BR )
	dim d_TR as REAL = l.DistanceToPoint( TR )

	dim cp(1 to 2) as VECTOR2
	dim ncp as integer = 0

	'' Clip left
	if (ncp < 2 ) and (sgn( d_BL ) <> sgn( d_TL )) then
		ncp += 1
		cp(ncp) = BL - ( TL - BL ) * d_BL / (d_TL - d_BL)
	end if
	
	'' Clip right
	if (ncp < 2 ) and (sgn( d_BR ) <> sgn( d_TR )) then
		ncp += 1
		cp(ncp) = BR - ( TR - BR ) * d_BR / (d_TR - d_BR)
	end if

	'' Clip bottom
	if (ncp < 2 ) and (sgn( d_BL ) <> sgn( d_BR )) then
		ncp += 1
		cp(ncp) = BL - ( BR - BL ) * d_BL / (d_BR - d_BL)
	end if
	
	'' Clip top
	if (ncp < 2 ) and (sgn( d_TL ) <> sgn( d_TR )) then
		ncp += 1
		cp(ncp) = TL - ( TR - TL ) * d_TL / (d_TR - d_TL)
	end if

	draw_arrow( p1, p2, LINE_ARROW_TO ) 

	if( ncp > 0 ) then
		draw_point( cp(1) )
	end if
	
	if( ncp > 1 ) then
		draw_point( cp(2) )
		draw_line( cp(1), cp(2) )
	end if
	
end sub
