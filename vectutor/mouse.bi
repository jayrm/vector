#ifndef __MOUSE_BI_INCLUDE__
#define __MOUSE_BI_INCLUDE__

'' ------------------------------------
'' MOUSE
'' ------------------------------------

	#include once "vector2.bi"

	using vectors

	enum MOUSE_BUTTONS
		MOUSE_BUTTON_LEFT = 1
		MOUSE_BUTTON_RIGHT = 2
		MOUSE_BUTTON_MIDDLE = 4
	end enum

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

		declare function ButtonState( byval b as const MOUSE_BUTTONS ) as boolean
		declare function ButtonPressed( byval b as const MOUSE_BUTTONS ) as boolean
		declare function ButtonReleased( byval b as const MOUSE_BUTTONS ) as boolean
		
	end type

#endif
