#include once "angle.bi"

''
function Deg2Rad( byval angle as degrees ) as radians EXPORT
	function = angle * PI / 180.0#
end function

''
function Deg2Grad( byval angle as degrees ) as gradians EXPORT
	function = angle * 100.0# / 90.0#
end function

''
function Deg2Turn( byval angle as degrees ) as turns EXPORT
	function = angle / 360.0#
end function

''
function Rad2Deg( byval angle as radians ) as degrees EXPORT
	function = angle * 180.0# / PI
end function

''
function Rad2Grad( byval angle as radians ) as gradians EXPORT
	function = angle * 200.0# / PI
end function

''
function Rad2Turn( byval angle as radians ) as turns EXPORT
	function = angle / (2.0# * PI)
end function

''
function Grad2Rad( byval angle as gradians ) as radians EXPORT
	function = angle * PI / 200.0#
end function

''
function Grad2Deg( byval angle as gradians ) as degrees EXPORT
	function = angle * 360.0# / 400.0#
end function

''
function Grad2Turn( byval angle as gradians ) as turns EXPORT
	function = angle / 400.0#
end function

''
function Turn2Rad( byval angle as turns ) as radians EXPORT
	function = angle * 2.0# * PI
end function

''
function Turn2Deg( byval angle as turns ) as degrees EXPORT
	function = angle * 360.0#
end function

''
function Turn2Grad( byval angle as turns ) as gradians EXPORT
	function = angle * 400.0#
end function
