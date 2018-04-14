#ifndef __MOUSE_BI_INCLUDE__
#define __MOUSE_BI_INCLUDE__

'' ------------------------------------
'' MOUSE
'' ------------------------------------

	#include once "vector2.bi"

	using vectors

	#define MOUSE_BUTTON_LEFT 1
	#define MOUSE_BUTTON_RIGHT 2
	#define MOUSE_BUTTON_MIDDLE 4

	type MOUSE

		curr_screen as VECTOR2
		curr_world as VECTOR2
		curr_button as integer

		last_screen as VECTOR2
		last_world as VECTOR2
		last_button as integer
			
		declare constructor( )
		declare destructor( )	
			
		declare sub Update( )

		declare function ButtonState( b as integer ) as integer
		declare function ButtonPressed( b as integer ) as integer
		declare function ButtonReleased( b as integer ) as integer
		
	end type

#endif
