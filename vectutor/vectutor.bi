#ifndef __VECTUTOR_BI_INCLUDE__
#define __VECTUTOR_BI_INCLUDE__

#include once "vector2_array.bi"

#ifndef NULL
#define NULL 0
#endif

type TEST_CTX
	Title as string
	
	HandleInput as sub( ctx as TEST_CTX )
	DrawScene as sub( ctx as TEST_CTX )

	AddPoint as function( ctx as TEST_CTX, p as VECTOR2 ) as BOOLEAN
	DeletePoint as function( ctx as TEST_CTX, index as integer ) as BOOLEAN
	MovePoint as function( ctx as TEST_CTX, index as integer, p as VECTOR2 ) as BOOLEAN

	MaxPoints as integer
	Points as VECTOR2_ARRAY ptr

	MaxModes as integer
	Mode as integer

	declare constructor()
	declare destructor()

end type	

#endif
