''	vector - geometric vector library
''	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)

#include once "angle.bi"

'' ------------------------------------
'' ANGLE
'' ------------------------------------

namespace angles

	''
	public function Deg2Rad( byval angle as const degrees ) as radians EXPORT
		function = angle * PI / 180.0#
	end function

	''
	public function Deg2Grad( byval angle as const degrees ) as gradians EXPORT
		function = angle * 100.0# / 90.0#
	end function

	''
	public function Deg2Turn( byval angle as const degrees ) as turns EXPORT
		function = angle / 360.0#
	end function

	''
	public function Rad2Deg( byval angle as const radians ) as degrees EXPORT
		function = angle * 180.0# / PI
	end function

	''
	public function Rad2Grad( byval angle as const radians ) as gradians EXPORT
		function = angle * 200.0# / PI
	end function

	''
	public function Rad2Turn( byval angle as const radians ) as turns EXPORT
		function = angle / (2.0# * PI)
	end function

	''
	public function Grad2Rad( byval angle as const gradians ) as radians EXPORT
		function = angle * PI / 200.0#
	end function

	''
	public function Grad2Deg( byval angle as const gradians ) as degrees EXPORT
		function = angle * 360.0# / 400.0#
	end function

	''
	public function Grad2Turn( byval angle as const gradians ) as turns EXPORT
		function = angle / 400.0#
	end function

	''
	public function Turn2Rad( byval angle as const turns ) as radians EXPORT
		function = angle * 2.0# * PI
	end function

	''
	public function Turn2Deg( byval angle as const turns ) as degrees EXPORT
		function = angle * 360.0#
	end function

	''
	public function Turn2Grad( byval angle as const turns ) as gradians EXPORT
		function = angle * 400.0#
	end function

	'' Fix### functions assumes that angles are never that far
	'' off from the desired range to start with.

	'':::::
	public function FixAngle180( byval angle as real ) as real EXPORT
		while( angle >= 180.0 )
			angle -= 360.0
		wend
		while( angle < -180.0 )
			angle += 360.0
		wend
		function = angle
	end function

	'':::::
	public function FixAngle360( byval angle as real ) as real EXPORT
		while( angle >= 360.0 )
			angle -= 360.0
		wend
		while( angle < 0 )
			angle += 360.0
		wend
		function = angle
	end function

	'':::::
	public function FixAnglePI( byval angle as real ) as real EXPORT
		while( angle >= PI )
			angle -= TWO_PI
		wend
		while( angle < -PI )
			angle += TWO_PI
		wend
		function = angle
	end function

	'':::::
	public function FixAnglePI2( byval angle as real ) as real EXPORT
		while( angle >= TWO_PI )
			angle -= TWO_PI
		wend
		while( angle < 0 )
			angle += TWO_PI
		wend
		function = angle
	end function

end namespace