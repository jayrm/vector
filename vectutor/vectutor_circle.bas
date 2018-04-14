'' ========================================================
'' vectutor_circle.bas
'' ========================================================

#include once "ogl_draw.bi"
#include once "ogl_font.bi"
#include once "vector2.bi"
#include once "vector2_array.bi"
#include once "vectutor.bi"
#include once "vectutor_color.bi"

using vectors

'' --------------------------------------------------------
dim shared points as VECTOR2_ARRAY

private function MovePoint( ctx as TEST_CTX, index as integer, p as VECTOR2 ) as BOOLEAN

	dim calc as BOOLEAN = FALSE

	select case ctx.mode
	case 1
		calc = (index mod 2 = 1) and (points.count >= index + 1)
	case 2
		calc = (index = 1) and (points.count >= 2)
	end select
	
	if calc = TRUE then
		dim t as VECTOR2 = points.v(index + 1) - points.v(index)
		points.v( index + 1 ) = p + t
	end if

	points.v(index) = p
	
	function = TRUE

end function

private sub draw_common( ctx as TEST_CTX )

	'' Draw all the points
	SetColor( COLOR_POINTS )
	for i as integer = 1 to points.Count
		draw_point( points.v(i), 2 )
	next

	'' Show stats
    SetColor( COLOR_TEXT )
    ogl_draw_string( "points: " & points.Count )

end sub

private sub draw_scene_circle_circle( ctx as TEST_CTX )

	if points.count >= 2 then

		dim c1 as VECTOR2 = points.v(1)
		dim c2 as VECTOR2 = points.v(2)
	
		'' First point is center, second point is on the circle
		dim r1 as REAL = (c2 -c1).magnitude

		SetColor( COLOR_POINTS, 0.5 )
		draw_circle( c1, r1 )

		draw_arrow( c1, c2, LINE_ARROW_TO, 0.5)
	
		if points.count >= 4 then

			'' Third point is center, fourth point is on the circle

			dim c3 as VECTOR2 = points.v(3)
			dim c4 as VECTOR2 = points.v(4)
		
			dim a as VECTOR2 = c4 - c3
			dim r2 as REAL = a.magnitude
	
			SetColor( COLOR_POINTS, 0.25 )
			draw_circle( points.v(3), r2 )

			draw_arrow( c3, c4, LINE_ARROW_TO, 0.5)
			
			dim v as VECTOR2 = (c3 - c1)
			dim c as REAL = v.magnitude
			dim s as REAL = ( r1 * r1 - r2 * r2 + c * c ) / ( 2 * c )
			dim h2 as REAL = ( r1 * r1 ) - ( s * s )
			
			if h2 >= 0.0 then

				dim h as REAL = sqr(h2)
				dim p1 as VECTOR2 = c1 + s * v.unit + h * v.unit.perp
				dim p2 as VECTOR2 = c1 + s * v.unit - h * v.unit.perp
				 
				SetColor( COLOR_GREEN )
				draw_point( p1, 2 )
				draw_point( p2, 2 )
			
			end if 
		
		end if

	end if
	
	draw_common( ctx )

end sub

private sub draw_scene_circle_line( ctx as TEST_CTX )

	if points.count >= 2 then
	
		dim c1 as VECTOR2 = points.v(1)
		dim c2 as VECTOR2 = points.v(2)
	
		'' First point is center, second point is on the circle
		dim r1 as REAL = (c2 - c1).magnitude

		SetColor( COLOR_POINTS, 0.5 )
		draw_circle( c1, r1 )

		draw_arrow( c1, c2, LINE_ARROW_TO, 0.5)
	
		if points.count >= 4 then

			'' Third point is on the line, fourth point is on the line

			dim L as LINE2 = LINE2( points.v(3), points.v(4) )
			SetColor( COLOR_POINTS, 0.25 )
			draw_line_eq( L )
			
			dim d as REAL = L.DistanceToPoint( points.v(1) )
			dim e as REAL = r1 * r1 - d * d
			
			if e >= 0.0 then
			
				dim p1 as VECTOR2 = c1 - d * L.normal + sqr(e) * L.normal.perp 
				dim p2 as VECTOR2 = c1 - d * L.normal - sqr(e) * L.normal.perp
			
				SetColor( COLOR_GREEN )
				draw_point( p1 )
				draw_point( p2 )
				
			end if
		
		end if

	end if

	draw_common( ctx )

end sub

private sub draw_scene_circle_2line_tangent( ctx as TEST_CTX )

	if points.count >= 2 then
	
		dim L1 as LINE2 = LINE2( points.v(1), points.v(2) )

		SetColor( COLOR_POINTS, 0.5 )
		draw_line_eq( L1 )

		if points.count >= 3 then
		
			dim L2 as LINE2 = LINE2( points.v(1), points.v(3) )
			
			SetColor( COLOR_POINTS, 0.25 )
			draw_line_eq( L2 )
			
			if points.count >= 4 then
			
				dim u1 as VECTOR2 = type(points.v(2)-points.v(1)).unit
				dim u2 as VECTOR2 = type(points.v(3)-points.v(1)).unit
				dim u3 as VECTOR2 = type(u1 + u2).unit

				dim r as REAL = (points.v(4)-points.v(1)).magnitude
				
				dim d as REAL = r / sqr( (1 - u1.dot( u2 )) / 2 ) 
				
				dim q as VECTOR2 = points.v(1) + u3 * d
			
				SetColor( COLOR_CONS )
				draw_circle( q, r )
			
			end if
		
		end if
		
	end if
				
	draw_common( ctx )

end sub

function vectutor_circle( m as integer = 0 ) as TEST_CTX

	dim ctx as TEST_CTX

	ctx.MaxModes = 3
	ctx.Points = @points
	ctx.MaxPoints = 4 

	if m <> 0 then
		ctx.Mode = m
	end if
	
	if ctx.Mode < 1 then ctx.Mode = 1
	if ctx.Mode > ctx.MaxModes then ctx.Mode = ctx.MaxModes

	select case ctx.Mode
	case 1
		ctx.Title = "CIRCLE - CIRCLE"
		ctx.DrawScene = procptr( draw_scene_circle_circle )
		ctx.MovePoint = procptr( MovePoint )
		
	case 2
		ctx.Title = "CIRCLE - LINE"
		ctx.DrawScene = procptr( draw_scene_circle_line )
		ctx.MovePoint = procptr( MovePoint )

	case 3
		ctx.Title = "CIRCLE - 2 LINE TANGENTS"
		ctx.DrawScene = procptr( draw_scene_circle_2line_tangent )
	
	end select

	function = ctx
	 
end function
