''	vector - geometric vector library
''	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)

#include once "vector2.bi"
#include once "line2.bi"

'' ------------------------------------
'' LINE2
'' ------------------------------------

namespace vectors

	constructor LINE2()
	end constructor

	constructor LINE2( byval a_ as const REAL, byval b_ as const REAL, byval c_ as const REAL )
		SetByCoeff( a_, b_, c_ )
	end constructor

	constructor LINE2( byref n as const VECTOR2, byval c_ as const REAL )
		SetByNormalDistance( n, c_ )
	end constructor

	constructor LINE2( byref p1 as const VECTOR2, byref p2 as const VECTOR2 )
		SetByTwoPoints( p1, p2 )
	end constructor

	destructor LINE2()
	end destructor

	sub LINE2.SetByCoeff( byval a_ as const REAL, byval b_ as const REAL, byval c_ as const REAL )
		a = a_
		b = b_
		c = c_
	end sub

	sub LINE2.SetByNormalDistance( byref n as const VECTOR2, byval c_ as const REAL )
		SetByCoeff( n.x, n.y, c_ )
	end sub

	sub LINE2.SetByPointDirection( byref p as const VECTOR2, byref r as const VECTOR2 )
		dim n as VECTOR2 = r.unit.perp
		dim c_ as REAL = -p.dot( n )
		SetByNormalDistance( n, c_ )
	end sub

	sub LINE2.SetByTwoPoints( byref p1 as const VECTOR2, byref p2 as const VECTOR2 )
		SetByPointDirection( p1, p2-p1 )
	end sub

	property LINE2.normal() as VECTOR2
		property = norm
	end property

	property LINE2.normal( byref n as const VECTOR2 )
		a = n.x
		b = n.y
	end property

	property LINE2.distance() as REAL
		property = c		
	end property

	property LINE2.distance( byval d as const REAL )
		c = d
	end property

	function LINE2.DistanceToPoint( byref p as const VECTOR2 ) as REAL
		function = p.dot( type<VECTOR2>(a,b) ) + c
	end function

	const function LINE2.IsPlane() as boolean
		if a = 0.0 and b = 0.0 and c = 0.0 then
			function = TRUE
		else
			function = FALSE
		end if
	end function

	const function LINE2.IsEmpty() as boolean
		if a = 0.0 and b = 0.0 and c <> 0.0 then
			function = TRUE
		else
			function = FALSE
		end if
	end function

	const function LINE2.Intersection( byref p1 as const VECTOR2, byref p2 as const VECTOR2, byref result as VECTOR2 ) as REAL

		dim d1 as REAL = DistanceToPoint( p1 )
		dim d2 as REAL = DistanceToPoint( p2 )
		dim d as REAL = d2 - d1

		dim r as REAL = -( d1 / d )
		
		result = r * (p2 - p1) + p1

		function = r

	end function

	const function LINE2.Intersection( byref l as const LINE2, byref result as VECTOR2 ) as REAL

		dim p1 as VECTOR2 = -l.distance * l.normal
		dim p2 as VECTOR2 = p1 + l.normal.perp
		
		function = Intersection( p1, p2, result ) 

	end function

	function INTERSECTION2.Calculate _
		( _
			byref l as const LINE2, _
			byref p1 as const VECTOR2, _
			byref p2 as const VECTOR2 _
		) as INTERSECTION2_TYPE

		dim d1 as REAL = l.DistanceToPoint( p1 )
		dim d2 as REAL = l.DistanceToPoint( p2 )
		dim dt as REAL = d2 - d1

		if dt = 0.0 then
			'' lines are parallel
			
			if d1 = 0.0 then
				typ = INTERSECTION2_TYPE_COINCIDENT
			else
				typ = INTERSECTION2_TYPE_PARALLEL
			end if
			
			r1 = 0.0
			r2 = 0.0
			d = d1
			p = type<VECTOR2>( 0.0, 0.0 )	

		else
			'' lines intersect
		
			typ = INTERSECTION2_TYPE_POINT
			r1 = -( d1 / dt )
			r2 = 0.0
			d = 0.0
			p = r1 * (p2 - p1) + p1

		end if

		function = typ	

	end function

	function INTERSECTION2.Calculate _
		( _
			byref l1 as const LINE2, _
			byref l2 as const LINE2 _
		) as INTERSECTION2_TYPE

		dim p1 as VECTOR2 = -l1.distance * l1.normal
		dim p2 as VECTOR2 = p1 + l1.normal.perp
		
		function = Calculate( l2, p1, p2 ) 
		
	end function

	function INTERSECTION2.Calculate _
		( _
			byref p1 as const VECTOR2, _
			byref p2 as const VECTOR2, _
			byref p3 as const VECTOR2, _
			byref p4 as const VECTOR2 _
		) as INTERSECTION2_TYPE

		function = typ

		'' Pa = P1 + sa(P2-P1)
		'' Pb = P3 + sb(P4-P1)
		'' Pa = Pb
		'' x1 + (sa/sd)(x2-x1) = x3 + (sb/sd)(x4-x3)
		'' y1 + (sa/sd)(y2-y1) = y3 + (sb/sd)(y4-y3)

		dim as REAL sd = (p2.x-p1.x)*(p4.y-p3.y)-(p4.x-p3.x)*(p2.y-p1.y)
		dim as REAL sa = (p4.x-p3.x)*(p1.y-p3.y)-(p1.x-p3.x)*(p4.y-p3.y)
		dim as REAL sb = (p2.x-p1.x)*(p1.y-p3.y)-(p1.x-p3.x)*(p2.y-p1.y)

		if sd = 0.0 then
		
			'' lines are parallel
			typ = INTERSECTION2_TYPE_PARALLEL
			r1 = 0.0
			r2 = 0.0
			d = 0.0
			p = type<VECTOR2>(0, 0)
			
		else
		
			'' intersection at point
			typ = INTERSECTION2_TYPE_POINT
			r1 = sa/sd
			r2 = sb/sd
			d = 0.0
			p = p1 + r1 * (p2-p1)
			q = p3 + r2 * (p4-p3)

		end if

	end function

end namespace
