#ifndef __VECTOR_BI__
#define __VECTOR_BI__

	#lang "fblite"

	#inclib "vector"

	type Vector
	  x AS single
	  y AS single
	end type

	type line_t
		n as vector
		d as single
	end type

	declare sub VZero (r as Vector)
	declare sub VSet (r AS Vector, x as single, y as single)
	declare sub VNeg (r AS Vector, a AS Vector)
	declare sub VAdd (r AS Vector, a AS Vector, b AS Vector)
	declare sub VAddComp (r AS Vector, a AS Vector, x as single, y as single)
	declare sub VSub (v AS Vector, a AS Vector, b AS Vector)
	declare sub VSubComp (r AS Vector, a AS Vector, x as single, y as single)
	declare sub VMul (r AS Vector, k as single, a AS Vector)
	declare sub VAddMul (r AS Vector, k1 as single, a AS Vector, k2 as single, b AS Vector)

	declare sub VNegIm (r AS Vector)
	declare sub VAddIm (r AS Vector, a AS Vector)
	declare sub VAddCompIm (r AS Vector, x as single, y as single)
	declare sub VSubIm (r AS Vector, a AS Vector)
	declare sub VSubCompIm (r AS Vector, x as single, y as single)
	declare sub VMulIm (r AS Vector, k as single)

	declare sub VUnit(r as vector, a as vector)
	declare sub VUnitIm(v as vector)
	declare sub VLimitIm (v AS Vector, d as single)
	declare function VDot(a as vector, b as vector) as single
	declare function VDist (a AS Vector, b AS Vector) as single
	declare function VMag (v AS Vector) as single
	declare sub VRotIm (v AS Vector, r as single)

	declare sub VPerp (v AS Vector, r as vector)
	declare sub VPerpIm (v AS Vector)
	declare Sub VLineEqFrom2Point(r as line_t, a as vector, b as vector)
	declare sub VLineEqFromPointNormal(r as line_t, a as vector, n as vector)

	declare function VString(v as vector) as string

#endif
