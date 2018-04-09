#ifndef __SIMPLE_VECTOR3_BI_INCLUDE__
#define __SIMPLE_VECTOR3_BI_INCLUDE__ 1

	#inclib "simple_vector3"

	#ifndef real
		type real as single
	#endif

	namespace simple_vector3

		type vector
			as real x
			as real y
			as real z
		end type

		declare sub VZero( byref v as vector )
		declare sub VAdd( byref v as vector, byref a as const vector, byref b as const vector )
		declare sub VAdd2V( byref v as vector, byref a as const vector )
		declare sub VAddComp( byref v as vector, byref a as const vector, byval x as const real, byval y as const real, byval z as const real )
		declare sub VAddComp2V( byref v as vector, byval x as const real, byval y as const real, byval z as const real )
		declare sub VAddMul( byref v as vector, byval k1 as const real, byref a as const vector, byval k2 as const real, byref b as const vector )
		declare function VDist( byref a as const vector, byref b as const vector ) as real
		declare sub VLimit2V( byref v as vector, byval d as const real )
		declare function VMag( byref v as const vector ) as real
		declare sub VNeg( byref v as vector, byref a as const vector )
		declare sub VNeg2V( byref v as vector )
		declare sub VScale( byref v as vector, byref a as const vector, byval k as const real )
		declare sub VScale2V( byref v as vector, byval k as const real )
		declare sub VSet( byref v as vector, byval x as const real, byval y as const real, byval z as const real )
		declare sub VSub( byref v as vector, byref a as const vector, byref b as const vector )
		declare sub VSub2V( byref v as vector, byref a as const vector )
		declare sub VSubComp( byref v as vector, byref a as const vector, byval x as const real, byval y as const real, byval z as const real )
		declare sub VSubComp2V( byref v as vector, byval x as const real, byval y as const real, byval z as const real )

		declare sub VRot2Vx( byref v as vector, byval r as const real )
		declare sub VRot902Vx( byref v as vector )
		declare sub VRot2Vy( byref v as vector, byval r as const real )
		declare sub VRot902Vy( byref v as vector )
		declare sub VRot2Vz( byref v as vector, byval r as const real )
		declare sub VRot902Vz( byref v as vector )

		declare function VString( byref v as const vector ) as string
		declare function VFormat( byref v as const vector, byref fmt as const string = "" ) as string

		declare sub VUnit( byref v as vector, byref a as const vector )
		declare sub VUnit2V( byref v as vector )

		declare function VDot( byref v1 as const vector, byref v2 as const vector ) as real
		declare sub VCross2V( byref v as vector, byref a as const vector, byref b as const vector )

	end namespace

#endif
