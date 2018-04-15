'' ========================================================
'' vectutor_hull.bas
'' ========================================================

#include once "GL/gl.bi"
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

	'' Draw all the points

	SetColor( COLOR_POINTS )
	for i as integer = 1 to points.Count
		draw_point( points.v(i) )
	next

	dim hull as VECTOR2_ARRAY = points.ConvexHull()

	SetColor( COLOR_CONS )
	if hull.count > 1 then
		for i as integer = 1 to hull.Count - 1
			draw_arrow( hull.v(i), hull.v(i+1), LINE_ARROW_TO )
		next
		draw_arrow( hull.v(hull.count), hull.v(1), LINE_ARROW_TO )
	end if

    SetColor( COLOR_TEXT )
    ogl_draw_string( "points: " & points.Count )

end sub

function vectutor_hull( byval m as const integer = 0 ) as SHEET
	
	dim ctx as SHEET
	
	ctx.Title = "BOUNDING CONVEX HULL"
	ctx.DrawScene = procptr( draw_scene )
	ctx.MaxPoints = -1
	ctx.Points = @points
	
	function = ctx

end function
