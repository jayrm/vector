'' ========================================================
'' vectutor_points.bas
'' ========================================================

#include once "ogl_draw.bi"
#include once "ogl_font.bi"
#include once "vector2.bi"
#include once "vector2_array.bi"
#include once "vectutor.bi"
#include once "vectutor_color.bi"
#include once "sheet.bi"

'' --------------------------------------------------------
dim shared points as VECTOR2_ARRAY

private sub draw_scene( byref ctx as SHEET )

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
	ogl_draw_string( "press ESCAPE key for MENU" )

end sub

function vectutor_points( byval m as const integer = 0 ) as SHEET

	dim ctx as SHEET
	
	ctx.Title = "POINTS"
	ctx.DrawScene = procptr( draw_scene )
	ctx.Points = @points
	ctx.MaxPoints = -1
	
	function = ctx

end function
