#include once "ogl_stuff.bi"
#include once "ogl_font.bi"
#include once "ogl_draw.bi"
#include once "vec_test.bi"
#include once "vec_test_color.bi"
#include once "timer.bi"
#include once "GL/gl.bi"
#include once "fbgfx.bi"
#include once "mouse.bi"

'' ========================================================

declare function vec_test_misc( m as integer = 0 ) as TEST_CTX
declare function vec_test_points( m as integer = 0 ) as TEST_CTX
declare function vec_test_line( m as integer = 0 ) as TEST_CTX
declare function vec_test_triangle( m as integer = 0 ) as TEST_CTX
declare function vec_test_hull( m as integer = 0 ) as TEST_CTX
declare function vec_test_circle( m as integer = 0 ) as TEST_CTX
declare function vec_test_angle( m as integer = 0 ) as TEST_CTX

type TEST_CTX_CONSTRUCTOR as function( m as integer = 0 ) as TEST_CTX

extern GTIMER as SYSTIMER

dim shared ctx_list( 1 to 7 ) as TEST_CTX_CONSTRUCTOR = _
{ _
	procptr( vec_test_misc ), _
	procptr( vec_test_points ), _
	procptr( vec_test_line ), _
	procptr( vec_test_triangle ), _
	procptr( vec_test_hull ), _
	procptr( vec_test_circle ), _
	procptr( vec_test_angle ) _
} 

dim shared ctx as TEST_CTX

dim shared ctx_index as integer = 0

function vec_test( i as integer = 0, m as integer = 0 ) as TEST_CTX
	ctx_index = i
	if ctx_index < 1 then ctx_index = 1
	if ctx_index > 7 then ctx_index = 7
	function = ctx_list(ctx_index)(m)
end function 

'' ========================================================

extern GMOUSE as MOUSE 

dim shared captured_idx as integer = 0
dim shared key_space as BOOLEAN

private sub def_HandleInput( ctx as TEST_CTX )

	if multikey(fb.SC_SPACE) then
		if key_space = FALSE then
			key_space = TRUE
			if ctx.MaxModes > 1 then
				ctx = vec_test( ctx_index, (ctx.Mode mod ctx.MaxModes) + 1 )
			end if
		end if		
	else
		key_space = FALSE 
	end if
	
	dim n as integer = 0
	if ctx.points <> NULL then
		n = ctx.points->near( GMOUSE.curr_world, 2 )
	end if
	
	if( captured_idx > 0 ) then

		if ctx.MovePoint <> NULL then
			ctx.MovePoint( ctx, captured_idx, GMOUSE.curr_world )
		end if
		'' ctx.points->v( captured_idx ) = GMOUSE.curr_world
	
		if GMOUSE.ButtonReleased( MOUSE_BUTTON_LEFT ) then
			captured_idx = 0
		end if
	else
	
		if GMOUSE.ButtonPressed( MOUSE_BUTTON_LEFT ) then
			if( n > 0 ) then
				captured_idx = n
			else
				if ctx.AddPoint <> NULL then
					ctx.AddPoint( ctx, GMOUSE.curr_world )
				end if
				'' ctx.points->add( GMOUSE.curr_world )
			end if		
		end if
		
		if GMOUSE.ButtonPressed( MOUSE_BUTTON_RIGHT ) then
			if( n > 0 ) then
				if ctx.DeletePoint <> NULL then
					ctx.DeletePoint( ctx, n )
				end if 
				'' ctx.points->remove( n )
			end if
		end if
	
	end if
	
end sub

private function def_AddPoint( ctx as TEST_CTX, p as VECTOR2 ) as BOOLEAN
	function = FALSE
	if ctx.points <> NULL then
		if ctx.maxpoints = -1 or ctx.points->count < ctx.maxpoints then
			ctx.points->add( p )
			function = TRUE
		end if
	end if
end function

private function def_DeletePoint( ctx as TEST_CTX, index as integer ) as BOOLEAN
	function = FALSE
	if ctx.points <> NULL then
		ctx.points->remove( index )
		function = TRUE
	end if
end function

private function def_MovePoint( ctx as TEST_CTX, index as integer, p as VECTOR2 ) as BOOLEAN
	function = FALSE
	if ctx.points <> NULL then
		ctx.points->v(index) = p
		function = TRUE
	end if
end function

constructor TEST_CTX( )

	Title = ""
	
	HandleInput = procptr( def_HandleInput )
	DrawScene = NULL

	AddPoint = procptr( def_AddPoint )
	DeletePoint = procptr( def_DeletePoint )
	MovePoint = procptr( def_MovePoint )

	MaxPoints = 0
	Points = NULL
	
	MaxModes = 0

end constructor

destructor TEST_CTX( )
	Title = ""
end destructor

private sub draw_menu( idx as integer, p as VECTOR2 )

	dim sel as integer = 0

	dim a( 1 to 7 ) as string = _
		{ _
			"Misc", _
			"Points", _
			"Line", _
			"Triangle", _
			"Hull", _
			"Circle", _
			"Angle" _
		}

	gfx_screen_mode( )

	ogl_font_set_height( -20 )
	ogl_font_set_spacing( -30 )

	SetColor( COLOR_BLUE )
	draw_line( type( 0,0 ), type( 100, 100), 5 )
	
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

sub menu_input( )

	dim p as VECTOR2 = GMOUSE.curr_screen 

	dim sel as integer = 0

	for i as integer = 1 to 7
		dim p1 as VECTOR2 = (  48, (i-1)*40 - 20 + 50 )
		dim p2 as VECTOR2 = ( 202, (i-1)*40 + 20 + 50 )
		if p.x >= p1.x andalso p.x <= p2.x andalso p.y >= p1.y andalso p.y <= p2.y then
			sel = i
			exit for
		end if
	next 

	if sel > 0 then
		ctx = vec_test( sel )			
	end if

end sub

'' ========================================================
'' vec_test.bas
'' ========================================================

gfx_init( )

ctx = vec_test( 0, 0 )

do
	dim menu_mode as BOOLEAN = FALSE

	GTIMER.Update( )
	GMOUSE.Update( )

    if multikey(fb.sc_escape) then
        exit do
    end if

    gfx_clear( )
    
    if multikey(fb.SC_CONTROL) then
    	menu_mode = TRUE
    end if
    
    if menu_mode = FALSE then
	    ctx.HandleInput( ctx )
	end if

	gfx_world_mode( )

	ogl_font_set_height( gfx_mapscreenHtoworldH(10) )
	ogl_font_set_spacing( gfx_mapscreenHtoworldH(15) )

	ogl_font_set_current_pos( gfx_mapscreenXYtoworldXY( type(10, 30) ))

    ctx.DrawScene( ctx )

	SetColor( COLOR_TEXT )
    ogl_draw_string( ctx.title, gfx_mapscreenXYtoworldXY( type(10, 15) ))
    ogl_draw_string( "fps: " & cint(GTIMER.fps), gfx_mapscreenXYtoworldXY(type(580, 15) ))

	if menu_mode = TRUE then

		glEnable( GL_BLEND )
		glBlendFunc( GL_SRC_ALPHA, GL_SRC_ALPHA )
		glColor4f( 0.0, 0.0, 0.0, 0.25 )
		draw_rectangle( type( gfx_world_left(), gfx_world_bottom() ), _
			type( gfx_world_right(), gfx_world_top() ) )
		glDisable( GL_BLEND )

    	draw_menu( ctx_index, GMOUSE.curr_screen )
    	menu_input( )
    
	end if

    gfx_flush( )
    flip( )

loop

gfx_exit( )
