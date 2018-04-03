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
			declare constructor( a_ as REAL, b_ as REAL, c_ as REAL )
			declare constructor( p1 as VECTOR2, p2 as VECTOR2 )
			declare constructor( n as VECTOR2, c_ as REAL )
			declare destructor()
			
			declare sub SetByCoeff( a_ as REAL, b_ as REAL, c_ as REAL )
			declare sub SetByNormalDistance( n as VECTOR2, c_ as REAL )
			declare sub SetByPointDirection( p as VECTOR2, r as VECTOR2 )
			declare sub SetByTwoPoints( p1 as VECTOR2, p2 as VECTOR2 )

			declare property normal() as VECTOR2
			declare property normal( n as VECTOR2 )
			
			declare property distance() as REAL
			declare property distance( d as REAL )
			
			declare function DistanceToPoint( p as VECTOR2 ) as REAL
			declare function IsPlane() as boolean
			declare function IsEmpty() as boolean

			declare function Intersection( p1 as VECTOR2, p2 as VECTOR2, byref result as VECTOR2 ) as REAL
			declare function Intersection( l as LINE2, byref result as VECTOR2 ) as REAL

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
					l as LINE2, _
					p1 as VECTOR2, _
					p2 as VECTOR2 _
				) as INTERSECTION2_TYPE
				
			declare function Calculate _
				( _
					l1 as LINE2, _
					l2 as LINE2 _
				) as INTERSECTION2_TYPE
				
			declare function Calculate _
				( _
					p1 as VECTOR2, _
					p2 as VECTOR2, _
					p3 as VECTOR2, _
					p4 as VECTOR2 _
				) as INTERSECTION2_TYPE
				
		end type

	end namespace

#endif
