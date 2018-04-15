#ifndef __LINE2_BI_INCLUDE__
#define __LINE2_BI_INCLUDE__

	#include once "vector2.bi"

	namespace vectors

		type LINE2

			'' of the form Ax + By + C = 0

			union
				type
					a as REAL
					b as REAL
					c as REAL
				end type
				type
					norm as vector2
				end type
			end union

			declare constructor()
			declare constructor( byval a_ as const REAL, byval b_ as const REAL, byval c_ as const REAL )
			declare constructor( byref p1 as const VECTOR2, byref p2 as const VECTOR2 )
			declare constructor( byref n as const VECTOR2, byval c_ as const REAL )
			declare destructor()
			
			declare sub SetByCoeff( byval a_ as const REAL, byval b_ as const REAL, byval c_ as const REAL )
			declare sub SetByNormalDistance( byref n as const VECTOR2, byval c_ as const REAL )
			declare sub SetByPointDirection( byref as const VECTOR2, byref r as const VECTOR2 )
			declare sub SetByTwoPoints( byref p1 as const VECTOR2, byref p2 as const VECTOR2 )

			declare const property normal() as VECTOR2
			declare property normal( byref n as const VECTOR2 )
			
			declare const property distance() as REAL
			declare property distance( byval d as const REAL )
			
			declare const function DistanceToPoint( byref p as const VECTOR2 ) as REAL
			declare const function IsPlane() as boolean
			declare const function IsEmpty() as boolean

			declare const function Intersection( byref p1 as const VECTOR2, byref p2 as const VECTOR2, byref result as VECTOR2 ) as REAL
			declare const function Intersection( byref l as const LINE2, byref result as VECTOR2 ) as REAL

		end type

		enum INTERSECTION2_TYPE
			INTERSECTION2_TYPE_POINT
			INTERSECTION2_TYPE_PARALLEL
			INTERSECTION2_TYPE_COINCIDENT
		end enum

		type INTERSECTION2

			typ as INTERSECTION2_TYPE
			r1 as REAL
			r2 as REAL
			d as REAL
			p as VECTOR2
			q as VECTOR2

			declare function Calculate _
				( _
					byref l as const LINE2, _
					byref p1 as const VECTOR2, _
					byref p2 as const VECTOR2 _
				) as INTERSECTION2_TYPE
				
			declare function Calculate _
				( _
					byref l1 as const LINE2, _
					byref l2 as const LINE2 _
				) as INTERSECTION2_TYPE
				
			declare function Calculate _
				( _
					byref p1 as const VECTOR2, _
					byref p2 as const VECTOR2, _
					byref p3 as const VECTOR2, _
					byref p4 as const VECTOR2 _
				) as INTERSECTION2_TYPE
				
		end type

	end namespace

#endif
