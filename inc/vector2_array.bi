#ifndef __VECTOR2_ARRAY_BI_INCLUDE__
#define __VECTOR2_ARRAY_BI_INCLUDE__

	#include once "vector2.bi"

	namespace vectors

		type VECTOR2_ARRAY

		private:
			list as VECTOR2 ptr
			n as integer
			
			declare const function compareXY( byref v1 as const VECTOR2, byref v2 as const VECTOR2 ) as integer
			declare sub quicksortXY( byval lidx as const integer, byval ridx as const integer )
			
		public:

			declare constructor()
			declare constructor( byref varray as const VECTOR2_ARRAY )
			declare destructor()

			declare const property Count() as integer
			
			declare const property v( byval index as const integer ) as VECTOR2
			declare property v( byval index as const integer, byref p as const VECTOR2 )
			 
			declare sub Clear() 

			declare sub Assign( byref varray as const VECTOR2_ARRAY )
			declare operator let( byref varray as const VECTOR2_ARRAY )

			declare function Add( byref p as const VECTOR2 ) as integer
			declare function AddUnique( byref p as const VECTOR2, byval e as const REAL = EPSILON ) as integer

			declare function Insert( byref p as const VECTOR2, byval index as const integer = 0 ) as integer

			declare sub Remove( byval index as const integer )
			
			declare const function Near( byref p as const VECTOR2, byval e as const REAL = EPSILON ) as integer
			
			declare const function ConvexHull( ) as VECTOR2_ARRAY
			
			declare sub SortXY()
			
		end type

	end namespace

#endif
