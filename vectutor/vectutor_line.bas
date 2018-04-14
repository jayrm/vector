'' ========================================================
'' vectutor_line.bas
'' ========================================================

#include once "ogl_draw.bi"
#include once "ogl_font.bi"
#include once "vector2.bi"
#include once "vector2_array.bi"
#include once "vectutor.bi"
#include once "vectutor_color.bi"

'' --------------------------------------------------------
dim shared points as VECTOR2_ARRAY

private sub draw_common( ctx as TEST_CTX )

	'' Draw all the points
	SetColor( COLOR_POINTS )
	for i as integer = 1 to points.count
		draw_point( points.v(i) )
	next

end sub

private sub draw_scene_line_lineseg( ctx as TEST_CTX )

	if points.count >= 2 then
	
		'' First two points are the line equation

		dim l as LINE2 = LINE2( points.v(1), points.v(2) )

		SetColor( COLOR_POINTS, 0.5 )
		draw_line_eq( l )	

		'' Next two points are the line segment

		if points.count >= 4 then

			SetColor( COLOR_POINTS, 0.25 )
			draw_line( points.v(3), points.v(4) )
		
			'' Compute intersection between line segment and line equation
			
			dim p as VECTOR2
			dim r as REAL = l.Intersection( points.v(3), points.v(4), p )
			
			if r < 0.0 then
				SetColor( COLOR_RED )
			elseif r > 1.0 then
				SetColor( COLOR_BLUE )
			else
				SetColor( COLOR_GREEN )
			end if
			
			draw_point( p )

			SetColor( COLOR_TEXT )

		    ogl_draw_string( "r : " & r )
		    ogl_draw_string( "p : " & p )

		end if
		
	end if
	
	draw_common( ctx )

end sub

private sub draw_scene_line_line( ctx as TEST_CTX )

	'' First two points are line equation #1

	if points.count >= 2 then
		dim L1 as LINE2 = LINE2( points.v(1), points.v(2) )

		SetColor( COLOR_POINTS, 0.5 )
		draw_line_eq( L1 )
		
		'' Next two points are line equation #2	

		if points.count >= 4 then
		
			dim L2 as LINE2 = LINE2( points.v(3), points.v(4) )

			SetColor( COLOR_POINTS, 0.25 )
			draw_line_eq( L2 )
			
			'' Compute intersection between line equation 1 and 2

			dim p as VECTOR2			
			dim r as REAL = L2.Intersection( L1, p )
			
			SetColor( COLOR_GREEN )
			draw_point( p )
		
		end if
	
	end if
	
	draw_common( ctx )

end sub

private sub draw_scene_line_distance( ctx as TEST_CTX )

	'' First two points are the line equation

	if points.count >= 2 then
		dim l as LINE2 = LINE2( points.v(1), points.v(2) )
		SetColor( COLOR_POINTS, 0.5 )
		draw_line_eq( l )	
	end if
	
	'' Next two points are used to calculate a distance from the line
	'' equation to those points
	
	for i as integer = 3 to points.count

		dim l as LINE2 = LINE2( points.v(1), points.v(2) )
	
		dim d as REAL = l.DistanceToPoint( points.v(i) )
		dim p as VECTOR2 = points.v(i) - l.normal * d
		
		SetColor( COLOR_GREEN )
		draw_line( points.v(i), p )

		SetColor( COLOR_TEXT )
	    ogl_draw_string( "d" & (i - 2) & " : " & d )
	
	next

	draw_common( ctx )

end sub

private sub draw_scene_lineseg_lineseg( ctx as TEST_CTX )

	'' First two points are the first line segment

	if points.count >= 2 then
		SetColor( COLOR_POINTS, 0.5 )
		draw_line( points.v(1), points.v(2) )	
	end if
	
	'' Next two points are the second line segment
	
	if points.count >= 4 then

		SetColor( COLOR_POINTS, 0.25 )
		draw_line( points.v(3), points.v(4) )
		
		dim i as INTERSECTION2
		
		i.Calculate( points.v(1), points.v(2), points.v(3), points.v(4) )

		if i.r1 >= 0.0 and i.r1 <= 1.0 and i.r2 >= 0.0 and i.r2 <= 1.0 then
			SetColor( COLOR_GREEN )
		elseif i.r1 >= 0.0 and i.r1 <= 1.0 or i.r2 >= 0.0 and i.r2 <= 1.0 then
			SetColor( COLOR_BLUE )
		else
			SetColor( COLOR_RED )
		end if

		draw_point( i.p )
		draw_point( i.q )

		SetColor( COLOR_TEXT )
	    ogl_draw_string( "r1 : " & i.r1 )
	    ogl_draw_string( "r2 : " & i.r2 )
	    ogl_draw_string( "p  : " & i.p )
	    ogl_draw_string( "q  : " & i.q )

	end if	

	draw_common( ctx )

end sub


function vectutor_line( m as integer = 0 ) as TEST_CTX

	dim ctx as TEST_CTX

	ctx.MaxModes = 4
	ctx.Points = @points
	ctx.MaxPoints = 4 

	if m <> 0 then
		ctx.Mode = m
	end if
	
	if ctx.Mode < 1 then ctx.Mode = 1
	if ctx.Mode > ctx.MaxModes then ctx.Mode = ctx.MaxModes
	 
	select case ctx.Mode
	case 1
		ctx.Title = "LINE - LINE SEGMENT"
		ctx.DrawScene = procptr( draw_scene_line_lineseg )
		
	case 2
		ctx.Title = "LINE - LINE"
		ctx.DrawScene = procptr( draw_scene_line_line )
		
	case 3
		ctx.Title = "LINE - DISTANCE"
		ctx.DrawScene = procptr( draw_scene_line_distance )

	case 4
		ctx.Title = "LINE SEGMENT - LINE SEGMENT"
		ctx.DrawScene = procptr( draw_scene_lineseg_lineseg )

	end select

	function = ctx

end function
