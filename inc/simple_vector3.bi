#ifndef __SIMPLE_VECTOR3_BI_INCLUDE__
#define __SIMPLE_VECTOR3_BI_INCLUDE__ 1

	#inclib "simple_vector3"

	namespace simple_vector3

		type vector
			as single x
			as single y
			as single z
		end type

		declare sub VZero( byref v as vector )
		declare sub VAdd( byref v as vector, byref a as const vector, byref b as const vector )
		declare sub VAdd2V( byref v as vector, byref a as const vector )
		declare sub VAddComp( byref v as vector, byref a as const vector, byval x as const single, byval y as const single, byval z as const single )
		declare sub VAddComp2V( byref v as vector, byval x as const single, byval y as const single, byval z as const single )
		declare sub VAddMul( byref v as vector, byval k1 as const single, byref a as const vector, byval k2 as const single, byref b as const vector )
		declare function VDist( byref a as const vector, byref b as const vector ) as single
		declare sub VLimit2V( byref v as vector, byval d as const single )
		declare function VMag( byref v as const vector ) as single
		declare sub VNeg( byref v as vector, byref a as const vector )
		declare sub VNeg2V( byref v as vector )
		declare sub VScale( byref v as vector, byref a as const vector, byval k as const single )
		declare sub VScale2V( byref v as vector, byval k as const single )
		declare sub VSet( byref v as vector, byval x as const single, byval y as const single, byval z as const single )
		declare sub VSub( byref v as vector, byref a as const vector, byref b as const vector )
		declare sub VSub2V( byref v as vector, byref a as const vector )
		declare sub VSubComp( byref v as vector, byref a as const vector, byval x as const single, byval y as const single, byval z as const single )
		declare sub VSubComp2V( byref v as vector, byval x as const single, byval y as const single, byval z as const single )

		declare sub VRot2Vx( byref v as vector, byval r as const single )
		declare sub VRot902Vx( byref v as vector )
		declare sub VRot2Vy( byref v as vector, byval r as const single )
		declare sub VRot902Vy( byref v as vector )
		declare sub VRot2Vz( byref v as vector, byval r as const single )
		declare sub VRot902Vz( byref v as vector )

		declare function VString( byref v as const vector ) as string

		declare sub VUnit( byref v as vector, byref a as const vector )
		declare sub VUnit2V( byref v as vector )

		declare function VDot( byref v1 as const vector, byref v2 as const vector ) as single

	end namespace

#endif
