#ifndef __PLANE3_BI
#define __PLANE3_BI

#include once "vector3.bi"

type plane3
	union
		type
			n as vector3
			d as real
		end type
		e(0 to 3) as real
		type
			x as real
			y as real
			z as real
		end type
		type
			a as real
			b as real
			c as real
		end type
	end union
end type

declare sub PlaneFromPointAndNormal _
	( _
		byref r as plane3, _
		byref a as vector3, _
		byref n as vector3 _
	)

declare function PlaneLineSegmentInterRatio _
	( _
		byref p as plane3, _
		byref a as vector3, _
		byref b as vector3, _
		byref ratio as real _
	) as BOOL

declare function PlaneRayInterRatio _
	( _
		byref p as plane3, _
		byref a as vector3, _
		byref m as vector3, _
		byref ratio as real _
	) as BOOL

#endif
