#ifndef __SIMPLE_VECTOR_BI__
#define __SIMPLE_VECTOR_BI__

	#lang "fblite"

	#inclib "simple_vector"

	#ifndef real
		type real as single
	#endif

namespace simple

	type vector
	  x as real
	  y as real
	end type

	type line_t
		n as vector
		d as real
	end type

	declare sub VZero ( byref r as vector )
	declare sub VSet ( byref r as vector, byval x as const real, byval y as const real )
	declare sub VNeg ( byref r as vector, byref a as const vector )
	declare sub VAdd ( byref r as vector, byref a as const vector, byref b as const vector )
	declare sub VAddComp ( byref r as vector, byref a as const vector, byval x as const real, byval y as const real )
	declare sub VSub ( byref r as vector, byref a as const vector, byref b as const vector)
	declare sub VSubComp ( byref r as vector, byref a as const vector, byval x as const real, byval y as const real )
	declare sub VMul ( byref r as vector, byval k as const real, byref a as const vector )
	declare sub VAddMul ( byref r as vector, byval k1 as const real, byref a as const vector, byval k2 as const real, byref b as const vector )

	declare sub VNegIm ( byref r as vector )
	declare sub VAddIm ( byref r as vector, byref a as const vector )
	declare sub VAddCompIm ( byref r as vector, byval x as const real, byval y as const real )
	declare sub VSubIm ( byref r as vector, byref a as const vector )
	declare sub VSubCompIm ( byref r as vector, byval x as const real, byval y as const real )
	declare sub VMulIm ( byref r as vector, byval k as const real )

	declare sub VUnit( byref r as vector, byref a as const vector )
	declare sub VUnitIm( byref v as vector )
	declare sub VLimitIm ( byref v as vector, byval d as const real )
	declare function VDot( byref a as const vector, byref b as const vector ) as real
	declare function VDist ( byref a as const vector, byref b as const vector ) as real
	declare function VMag ( byref v as const vector ) as real
	declare sub VRotIm ( byref v as vector, byval r as const real )

	declare sub VPerp ( byref v as vector, byref r as const vector )
	declare sub VPerpIm ( byref v as vector )
	declare Sub VLineEqFrom2Point ( byref r as line_t, byref a as const vector, byref b as const vector )
	declare sub VLineEqFromPointNormal ( byref r as line_t, byref a as const vector, byref n as const vector )

	declare function VString ( byref v as const vector ) as string

	declare function AddMinimal ( byval x as const real, byval d as const real ) as real
	declare sub VAddImMinimal ( byref r as vector, byref a as const vector )
	declare function SubMinimal ( byval x as const real, byval d as const real ) as real
	declare sub VSubImMinimal ( byref r as vector, byref a as const vector )
	declare function AddMinimalDbl ( byval x as const double, byval d as const double ) as real

end namespace

#endif
