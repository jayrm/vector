#include once "vectypes.bi"

namespace vectors

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
