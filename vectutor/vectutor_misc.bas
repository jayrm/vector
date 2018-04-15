'' ========================================================
'' vectutor_misc.bas
'' ========================================================

#include once "ogl_draw.bi"
#include once "ogl_font.bi"
#include once "vector2.bi"
#include once "vectutor.bi"
#include once "vectutor_color.bi"
#include once "mouse.bi"
#include once "sheet.bi"

extern GMOUSE as MOUSE

'' --------------------------------------------------------

private sub draw_scene( byref ctx as SHEET )
	
	SetColor( COLOR_RED )

    draw_point( type( 0, 0 ) )
    draw_line( type( 0, 0 ), type( 50, 10 ) )
    draw_point( type( 50, 10 ) )

	SetColor( COLOR_GREEN )
    
    draw_triangle( type( -100, 50 ), type( -80, 80 ), type( -70, 30 ) )

    draw_arrow( type( -50, 10 ), type( -10, 30 ), LINE_ARROW_NONE )
    draw_arrow( type( -50, 20 ), type( -10, 40 ), LINE_ARROW_TO )
    draw_arrow( type( -50, 30 ), type( -10, 50 ), LINE_ARROW_FROM )
    draw_arrow( type( -50, 40 ), type( -10, 60 ), LINE_ARROW_BOTH )
    draw_arrow( type( -50, 50 ), type( -10, 70 ) )
	draw_arrow_head( type( -50, 60 ), type( -40, -20 ) )
	draw_arrow_head( type( -10, 80 ), type( 40, 20 ) )

	SetColor( COLOR_TEXT )

    ogl_font_set_height( 4 )
    ogl_draw_string( "Hello", type<vector2>( 50, 50 ) )
	ogl_draw_string( "PRESS ESCAPE FOR MENU", type<vector2>( 0, -10 ) )

    ogl_draw_string( "m: " & gmouse.curr_screen.x & ", " & gmouse.curr_screen.y, type<vector2>( -80, 0 ) )
	ogl_draw_string( "p: " & gmouse.curr_world.x & ", " & gmouse.curr_world.y, type<vector2>( -80, -20 ) )

	SetColor( COLOR_BLUE )
	
	draw_disc( type( -100, -50) , 20 )
	draw_circle( type( -50, -50 ), 10 )
	draw_donut( type( 0, -50 ), 16, 20 )
	draw_point( type( 50, -50 ) )

end sub

function vectutor_misc( byval m as const integer = 0 ) as SHEET

	dim ctx as SHEET
	
	ctx.Title = "MISC"
	ctx.DrawScene = procptr( draw_scene )
	
	function = ctx

end function
