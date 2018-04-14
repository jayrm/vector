#include once "vector2.bi"
#include once "glscreen.bi"
#include once "mouse.bi"

'' ------------------------------------
'' MOUSE
'' ------------------------------------

extern GMOUSE as MOUSE
extern gls as GLSCREEN

dim shared GMOUSE as MOUSE

constructor MOUSE( )
end constructor

destructor MOUSE( )
end destructor

sub MOUSE.Update( )

	last_screen = curr_screen
	last_world = curr_world
	last_button = curr_button
	
	static as integer mx, my, mz, mb
	
	GetMouse( mx, my, mz, mb )
	
	if( mx >= 0 and my >= 0 ) then
	
		curr_screen.x = mx
		curr_screen.y = my
		
		curr_world = gls.MapDisplayXYtoWorldXY( curr_screen )
		
		curr_button = mb

	end if
	
end sub

function MOUSE.ButtonState( b as integer ) as integer
	function = (( curr_button and b ) <> 0 )
end function

function MOUSE.ButtonPressed( b as integer ) as integer
	if ( ((last_button and b) = 0) and ((curr_button and b) <> 0) ) then
		function = not 0
	end if
end function

function MOUSE.ButtonReleased( b as integer ) as integer
	if ( ((last_button and b) <> 0) and ((curr_button and b) = 0) ) then
		function = not 0
	end if
end function
