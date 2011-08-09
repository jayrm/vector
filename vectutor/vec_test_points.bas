'' ========================================================
'' vec_test_points.bas
'' ========================================================

#include once "ogl_stuff.bi"
#include once "ogl_draw.bi"
#include once "ogl_font.bi"
#include once "vector2.bi"
#include once "vector2_array.bi"
#include once "vec_test.bi"
#include once "vec_test_color.bi"

'' --------------------------------------------------------
dim shared points as VECTOR2_ARRAY

private sub draw_scene( ctx as TEST_CTX )

	SetColor( COLOR_POINTS, 0.5 )
	for i as integer = 1 to points.Count - 1
		draw_arrow( points.v(i), points.v(i+1), LINE_ARROW_TO )
	next

	'' Draw all the points
	SetColor( COLOR_POINTS )
	for i as integer = 1 to points.Count
		draw_point( points.v(i) )
	next

	SetColor( COLOR_TEXT )
    ogl_draw_string( "points: " & points.Count )
	ogl_draw_string( "click left mouse button to add points" )
	ogl_draw_string( "click right mouse button to remove points" )
	ogl_draw_string( "click left+drag to move points" )
	ogl_draw_string( "hold CTRL key for MENU" )

end sub

function vec_test_points( m as integer = 0 ) as TEST_CTX

	dim ctx as TEST_CTX 
	
	ctx.Title = "POINTS"
	ctx.DrawScene = procptr( draw_scene )
	ctx.Points = @points
	ctx.MaxPoints = -1
	
	function = ctx

end function
