#include once "plane3.bi"

'':::::
public sub PlaneFromPointAndNormal _
	( _
		byref r as plane3, _
		byref a as vector3, _
		byref n as vector3 _
	) EXPORT

	r.n = n.unit
	r.d = - ( r.n * a )

end sub

'':::::
public function PlaneLineSegmentInterRatio _
	( _
		byref p as plane3, _
		byref a as vector3, _
		byref b as vector3, _
		byref ratio as real _
	) as BOOL EXPORT

	dim d1 as real = a * p.n - p.d
	dim d2 as real = b * p.n - p.d
	dim d as real = d1 - d2

	if( abs(d) < EPSILON ) then
		ratio = 0
		function = FALSE

	else
		'' Intersection point will be
		'' = a + ratio * ( b - a )
		ratio = d1 / d
		function = TRUE

	end if

end function

'':::::
public function PlaneRayInterRatio _
	( _
		byref p as plane3, _
		byref a as vector3, _
		byref m as vector3, _
		byref ratio as real _
	) as BOOL EXPORT

	dim d1 as real = a * p.n - p.d
	dim d as real = m * p.n

	if( abs(d) < EPSILON ) then
		ratio = 0
		function = FALSE

	else
		'' Intersection point will be
		'' = a + ratio * m
		ratio = d1 / d
		function = TRUE

	end if

end function

