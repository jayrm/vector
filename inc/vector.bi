#ifndef __VECTOR_BI__
#define __VECTOR_BI__

	#lang "fblite"

	#inclib "vector"

	#ifndef real
		type real as single
	#endif

	type Vector
	  x AS real
	  y AS real
	end type

	type line_t
		n as vector
		d as real
	end type

	declare sub VZero (r as Vector)
	declare sub VSet (r AS Vector, x as real, y as real)
	declare sub VNeg (r AS Vector, a AS Vector)
	declare sub VAdd (r AS Vector, a AS Vector, b AS Vector)
	declare sub VAddComp (r AS Vector, a AS Vector, x as real, y as real)
	declare sub VSub (v AS Vector, a AS Vector, b AS Vector)
	declare sub VSubComp (r AS Vector, a AS Vector, x as real, y as real)
	declare sub VMul (r AS Vector, k as real, a AS Vector)
	declare sub VAddMul (r AS Vector, k1 as real, a AS Vector, k2 as real, b AS Vector)

	declare sub VNegIm (r AS Vector)
	declare sub VAddIm (r AS Vector, a AS Vector)
	declare sub VAddCompIm (r AS Vector, x as real, y as real)
	declare sub VSubIm (r AS Vector, a AS Vector)
	declare sub VSubCompIm (r AS Vector, x as real, y as real)
	declare sub VMulIm (r AS Vector, k as real)

	declare sub VUnit(r as vector, a as vector)
	declare sub VUnitIm(v as vector)
	declare sub VLimitIm (v AS Vector, d as real)
	declare function VDot(a as vector, b as vector) as real
	declare function VDist (a AS Vector, b AS Vector) as real
	declare function VMag (v AS Vector) as real
	declare sub VRotIm (v AS Vector, r as real)

	declare sub VPerp (v AS Vector, r as vector)
	declare sub VPerpIm (v AS Vector)
	declare Sub VLineEqFrom2Point(r as line_t, a as vector, b as vector)
	declare sub VLineEqFromPointNormal(r as line_t, a as vector, n as vector)

	declare function VString(v as vector) as string

	declare function AddMinimal(x as real, d as real) as real
	declare sub VAddImMinimal(r AS Vector, a AS Vector)
	declare function SubMinimal(x as real, d as real) as real
	declare sub VSubImMinimal (r AS Vector, a AS Vector)

#endif
