#ifndef __VECTOR2_ARRAY_BI_INCLUDE__
#define __VECTOR2_ARRAY_BI_INCLUDE__

#include once "vector2.bi"

#define EPSILON 1e-15

type VECTOR2_ARRAY

private:
	list as VECTOR2 ptr
	n as integer
	
	declare function compareXY( v1 as VECTOR2, v2 as VECTOR2 ) as integer
	declare sub quicksortXY( lidx as integer, ridx as integer )
	
public:

	declare constructor()
	declare constructor( varray as VECTOR2_ARRAY )
	declare destructor()

	declare property Count() as integer
	
	declare property v( index as integer ) as VECTOR2
	declare property v( index as integer, p as VECTOR2 )
	 
	declare sub Clear() 

	declare sub Assign( varray as VECTOR2_ARRAY )
	declare operator let( varray as VECTOR2_ARRAY )

	declare function Add( p as VECTOR2 ) as integer
	declare function AddUnique( p as VECTOR2, e as REAL = EPSILON ) as integer

	declare function Insert( p as VECTOR2, index as integer = 0 ) as integer

	declare sub Remove( index as integer )
	
	declare function Near( p as VECTOR2, e as REAL = EPSILON ) as integer
	
	declare function ConvexHull( ) as VECTOR2_ARRAY
	
	declare sub SortXY()
	
end type

#endif
