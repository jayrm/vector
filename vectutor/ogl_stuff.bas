'' ========================================================
'' og_stuff.bas
'' ========================================================

#include once "fbgfx.bi"
#include once "GL/gl.bi"
#include once "vector2.bi"

#define SCREEN_W 1024.0
#define SCREEN_H 768.0

#define WORLD_X 0.0
#define WORLD_Y 0.0
#define WORLD_W 250.0
#define WORLD_H (WORLD_W * SCREEN_H / SCREEN_W)

#define WORLD_L (WORLD_X - WORLD_W / 2.0 ) 
#define WORLD_R (WORLD_X + WORLD_W / 2.0 ) 
#define WORLD_B (WORLD_Y - WORLD_H / 2.0 ) 
#define WORLD_T (WORLD_Y + WORLD_H / 2.0 ) 

using vectors

'' --------------------------------------------------------

sub gfx_init( )

    screenres SCREEN_W, SCREEN_H, 16, , fb.GFX_OPENGL

    '' set up our viewport
    glViewport(0, 0, SCREEN_W, SCREEN_H)

    '' set up view
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()

    glOrtho(WORLD_L, WORLD_R, WORLD_B, WORLD_T, 1.0, -1.0 )
    
    '' set up rendering
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()

    '' set up color properties
    glClearColor( 0.125, 0.125, 0.125, 0 )
    
    glEnable( GL_LINE_SMOOTH )
    glEnable( GL_BLEND )
    glHint( GL_LINE_SMOOTH_HINT, GL_NICEST )

end sub

sub gfx_world_mode( )

    '' set up view
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()

    glOrtho(WORLD_L, WORLD_R, WORLD_B, WORLD_T, 1.0, -1.0 )
    
    '' set up rendering
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()

end sub

sub gfx_screen_mode( )

    '' set up view
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()

    glOrtho(0, SCREEN_W, SCREEN_H, 0, 1.0, -1.0 )
    
    '' set up rendering
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()

end sub

sub gfx_exit( )
end sub

sub gfx_clear( )
    glClear( GL_COLOR_BUFFER_BIT )
end sub

sub gfx_flush( )
    glFlush()
end sub

function gfx_world_left() as REAL
	function = WORLD_L
end function

function gfx_world_right() as REAL
	function = WORLD_R
end function

function gfx_world_top() as REAL
	function = WORLD_T
end function

function gfx_world_bottom() as REAL
	function = WORLD_B
end function

function gfx_mapscreenXtoworldX( x as const REAL ) as REAL
	function = (x + 0.5) / (SCREEN_W - 1.0) * WORLD_W + WORLD_L
end function

function gfx_mapscreenYtoworldY( y as const REAL ) as REAL
	function = (0.5 - y) / (SCREEN_H - 1.0) * WORLD_H - WORLD_B
end function

function gfx_mapscreenWtoworldW( w as const REAL ) as REAL
	function = w / SCREEN_W * WORLD_W
end function

function gfx_mapscreenHtoworldH( h as const REAL ) as REAL
	function = h / SCREEN_H * WORLD_H
end function

function gfx_mapworldXtoscreenX( x as const REAL ) as REAL
	function = (x - WORLD_L) / WORLD_W * (SCREEN_W - 1.0) - 0.5
end function

function gfx_mapworldYtoscreenY( y as const REAL ) as REAL
	function = -((y + WORLD_B) / WORLD_H * (SCREEN_H - 1.0) - 0.5)
end function

function gfx_mapworldWtoscreenW( w as const REAL ) as REAL
	function = w / WORLD_W * SCREEN_W
end function

function gfx_mapworldHtoscreenH( h as const REAL ) as REAL
	function = h / WORLD_H * SCREEN_H
end function

function gfx_mapscreenXYtoworldXY( a as VECTOR2 ) as VECTOR2
	function = type _
		( _
			gfx_mapscreenXtoworldX( a.x ), _
			gfx_mapscreenYtoworldY( a.y ) _
		)
end function

function gfx_mapworldXYtoscreenXY( a as VECTOR2 ) as VECTOR2
	function = type _
		( _
			gfx_mapworldXtoscreenX( a.x ), _
			gfx_mapworldYtoscreenY( a.y ) _
		)
end function

function gfx_mapscreenWHtoworldWH( a as VECTOR2 ) as VECTOR2
	function = type _
		( _
			gfx_mapscreenWtoworldW( a.x ), _
			gfx_mapscreenHtoworldH( a.y ) _
		)
end function

function gfx_mapworldWHtoscreenWH( a as VECTOR2 ) as VECTOR2
	function = type _
		( _
			gfx_mapworldWtoscreenW( a.x ), _
			gfx_mapworldHtoscreenH( a.y ) _
		)
end function


