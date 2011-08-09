'' ========================================================
'' ogl_stuff.bi
'' ========================================================

#ifndef __OGL_STUFF_BI_INCLUDE__
#define __OGL_STUFF_BI_INCLUDE__

#include once "vector2.bi"

using vectors

declare sub gfx_init( )
declare sub gfx_exit( ) 
declare sub gfx_clear( )
declare sub gfx_flush( )

declare sub gfx_world_mode( )
declare sub gfx_screen_mode( )

declare function gfx_world_left() as REAL
declare function gfx_world_right() as REAL
declare function gfx_world_top() as REAL
declare function gfx_world_bottom() as REAL

declare function gfx_mapscreenXtoworldX( x as const REAL ) as REAL
declare function gfx_mapscreenYtoworldY( y as const REAL ) as REAL
declare function gfx_mapscreenWtoworldW( w as const REAL ) as REAL
declare function gfx_mapscreenHtoworldH( h as const REAL ) as REAL

declare function gfx_mapworldXtoscreenX( x as const REAL ) as REAL
declare function gfx_mapworldYtoscreenY( y as const REAL ) as REAL
declare function gfx_mapworldWtoscreenW( w as const REAL ) as REAL
declare function gfx_mapworldHtoscreenH( h as const REAL ) as REAL

declare function gfx_mapscreenXYtoworldXY( a as VECTOR2 ) as VECTOR2
declare function gfx_mapworldXYtoscreenXY( a as VECTOR2 ) as VECTOR2

declare function gfx_mapscreenWHtoworldWH( a as VECTOR2 ) as VECTOR2
declare function gfx_mapworldWHtoscreenWH( a as VECTOR2 ) as VECTOR2

#endif
