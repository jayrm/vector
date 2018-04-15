#include once "ogl_font.bi"
#include once "ogl_draw.bi"
#include once "vectutor.bi"
#include once "vectutor_color.bi"
#include once "timer.bi"
#include once "GL/gl.bi"
#include once "fbgfx.bi"
#include once "mouse.bi"
#include once "glscreen.bi"
#include once "sheet.bi"

extern gls as GLSCREEN
extern GMOUSE as MOUSE
extern GTIMER as SYSTIMER

dim shared ctx as SHEET
dim shared ctx_index as integer = 0

'' ========================================================

private sub draw_menu( byval idx as const integer, byref p as const VECTOR2 )

	dim sel as integer = 0

	'' !!! TODO !!! - get titles from SHEET

	dim a( 1 to 8 ) as string = _
		{ _
			"Basic", _
			"Misc", _
			"Points", _
			"Line", _
			"Triangle", _
			"Hull", _
			"Circle", _
			"Angle" _
		}

	ogl_font_set_height( -20 )
	ogl_font_set_spacing( -30 )

	if idx > 0 then
		dim p1 as VECTOR2 = (  48, (idx-1)*40 - 20 + 50 )
		dim p2 as VECTOR2 = ( 202, (idx-1)*40 + 20 + 50 )
		SetColor( COLOR_YELLOW )
		draw_line( type( p1.x, p1.y ), type( p2.x, p1.y ) )
		draw_line( type( p2.x, p1.y ), type( p2.x, p2.y ) )
		draw_line( type( p2.x, p2.y ), type( p1.x, p2.y ) )
		draw_line( type( p1.x, p2.y ), type( p1.x, p1.y ) )
	end if
	
	for i as integer = lbound(a) to ubound(a)
		dim p1 as VECTOR2 = (  48, (i-1)*40 - 20 + 50 )
		dim p2 as VECTOR2 = ( 202, (i-1)*40 + 20 + 50 )
		if p.x >= p1.x andalso p.x <= p2.x andalso p.y >= p1.y andalso p.y <= p2.y then
			sel = i
			exit for
		end if
	next 

	if sel > 0 then
		dim p1 as VECTOR2 = (  48, (sel-1)*40 - 20 + 50 )
		dim p2 as VECTOR2 = ( 202, (sel-1)*40 + 20 + 50)
		SetColor( COLOR_GREEN )
		draw_line( type( p1.x, p1.y ), type( p2.x, p1.y ) )
		draw_line( type( p2.x, p1.y ), type( p2.x, p2.y ) )
		draw_line( type( p2.x, p2.y ), type( p1.x, p2.y ) )
		draw_line( type( p1.x, p2.y ), type( p1.x, p1.y ) )
	end if
	
	SetColor( COLOR_TEXT )
	for i as integer = lbound(a) to ubound(a)
		ogl_draw_string( a(i), type<vector2>( 50, 50 + (i-1)*40 ) )
	next	

end sub

function menu_input( ) as boolean

	dim p as VECTOR2 = GMOUSE.curr_screen 

	dim sel as integer = 0

	for i as integer = 1 to 8
		dim p1 as VECTOR2 = (  48, (i-1)*40 - 20 + 50 )
		dim p2 as VECTOR2 = ( 202, (i-1)*40 + 20 + 50 )
		if p.x >= p1.x andalso p.x <= p2.x andalso p.y >= p1.y andalso p.y <= p2.y then
			if GMOUSE.ButtonPressed( MOUSE_BUTTON_LEFT ) then
				sel = i
				exit for
			end if
		end if
	next 

	if sel > 0 then
		ctx = GetSheetInterface( sel )
		function = true		
	end if

end function

function EscapeKeyPressed() as boolean
	static last as boolean = false
	static curr as boolean = false
	curr = MultiKey(fb.SC_ESCAPE)
	function = cbool( curr andalso not last )
	last = curr
end function

function SpaceKeyPressed() as boolean
	static last as boolean = false
	static curr as boolean = false
	curr = MultiKey(fb.SC_SPACE)
	function = cbool( curr andalso not last )
	last = curr
end function


'' ========================================================
'' vectutor_main.bas
'' ========================================================

public sub MainLoop()

	dim menu_mode as BOOLEAN = FALSE

	ctx = GetSheetInterface( 0, 0 )

	do

		GTIMER.Update( )
		GMOUSE.Update( )

		'' CTRL+Q = insta-quit.
		if( multikey(fb.sc_q) andalso multikey(fb.sc_control) ) then
			exit do
		end if

		if EscapeKeyPressed() then
    		menu_mode = not menu_mode
		end if
    
		if menu_mode = FALSE then
			if( SpaceKeyPressed() ) then
				if ctx.MaxModes > 1 then
					ctx = GetSheetInterface( ctx_index, (ctx.Mode mod ctx.MaxModes) + 1 )
				end if
			else
				ctx.HandleInput( ctx )
			end if
		end if

		gls.BeginFrame()

		gls.WorldOrtho

		glEnable( GL_BLEND )

		ogl_font_set_height( gls.MapDisplayHtoWorldH(-10) )
		ogl_font_set_spacing( gls.MapDisplayHtoWorldH(-15) )
		ogl_font_set_current_pos( gls.MapDisplayXYtoWorldXY( type(10, 30) ))

		ctx.DrawScene( ctx )

		gls.DisplayOrtho

		ogl_font_set_height( -10 )
		ogl_font_set_spacing( -15 )

		SetColor( COLOR_TEXT )
		ogl_draw_string( ctx.title, type<vector2>(10, 15) )
		ogl_draw_string( "fps: " & cint(GTIMER.fps), type<vector2>(gls.GetDisplayWidth()-ogl_font_get_width("fps: XXXX"), 15) )

		if menu_mode = TRUE then

			glEnable( GL_BLEND )
			glBlendFunc( GL_SRC_ALPHA, GL_SRC_ALPHA )
			glColor4f( 0.25, 0.25, 0.25, 0.1 )
			draw_rectangle( type(0, 0), type( gls.GetDisplayWidth(), -gls.GetDisplayHeight() ) )

    		draw_menu( ctx_index, GMOUSE.curr_screen )
    		if( menu_input( ) ) then
				menu_mode = FALSE
			end if

		end if

		gls.EndFrame()
		gls.Flip()

	loop

end sub
