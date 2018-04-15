#include once "fbgfx.bi"
#include once "mouse.bi"
#include once "vector2_array.bi"
#include once "sheet.bi"

extern GMOUSE as MOUSE 

'' ------------------------------------
'' SHEET_INTERFACE
'' ------------------------------------

declare function vectutor_basic( byval m as const integer = 0 ) as SHEET
declare function vectutor_misc( byval m as const integer = 0 ) as SHEET
declare function vectutor_points( byval m as const integer = 0 ) as SHEET
declare function vectutor_line( byval m as const integer = 0 ) as SHEET
declare function vectutor_triangle( byval m as const integer = 0 ) as SHEET
declare function vectutor_hull( byval m as const integer = 0 ) as SHEET
declare function vectutor_circle( byval m as const integer = 0 ) as SHEET
declare function vectutor_angle( byval m as const integer = 0 ) as SHEET

dim shared ctx_list( 1 to 8 ) as SHEET_INTERFACE = _
{ _
	procptr( vectutor_basic ), _
	procptr( vectutor_misc ), _
	procptr( vectutor_points ), _
	procptr( vectutor_line ), _
	procptr( vectutor_triangle ), _
	procptr( vectutor_hull ), _
	procptr( vectutor_circle ), _
	procptr( vectutor_angle ) _
} 

function GetSheetInterface( byval i as const integer = 0, byval m as const integer = 0 ) as SHEET
	dim ctx_index as integer = i
	if ctx_index < lbound(ctx_list) then ctx_index = lbound(ctx_list)
	if ctx_index > ubound(ctx_list) then ctx_index = ubound(ctx_list)
	function = ctx_list(ctx_index)(m)
end function 


'' ------------------------------------
'' SHEET
'' ------------------------------------

dim shared captured_idx as integer = 0

private sub def_HandleInput( byref ctx as SHEET )

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

private function def_AddPoint( byref ctx as SHEET, byref p as const VECTOR2 ) as BOOLEAN
	function = FALSE
	if ctx.points <> NULL then
		if ctx.maxpoints = -1 or ctx.points->count < ctx.maxpoints then
			ctx.points->add( p )
			function = TRUE
		end if
	end if
end function

private function def_DeletePoint( byref ctx as SHEET, byval index as const integer ) as BOOLEAN
	function = FALSE
	if ctx.points <> NULL then
		ctx.points->remove( index )
		function = TRUE
	end if
end function

private function def_MovePoint( byref ctx as SHEET, byval index as const integer, byref p as const VECTOR2 ) as BOOLEAN
	function = FALSE
	if ctx.points <> NULL then
		ctx.points->v(index) = p
		function = TRUE
	end if
end function

constructor SHEET( )

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

destructor SHEET( )
	Title = ""
end destructor
