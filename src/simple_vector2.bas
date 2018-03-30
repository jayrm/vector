'' ============================================================
'' 2D Vector Functions
''
'' Copyright (C) 2006 - Jeff Marshall (coder@execulink.com)
''
'' License: 1) Program is provided as-is.  
''          2) There is no warranty or guarantee.
''          3) There are no other conditions.
''
'' Feel free to use, re-use, or abuse :)
''
'' ============================================================

#lang "fblite"

Option Explicit

#include once "simple_vector2.bi"

#define SNG_MIN_PRECISION 1E-7
#define DBL_MIN_PRECISION 1E-15

#if( typeof(real) = typeof(single) )
	#define MIN_PRECISION 1E-7
#elseif( typeof(real) = typeof(double) )
	#define MIN_PRECISION 1D-15
#else
	#error type "real" not defined
#endif

namespace simple_vector2

	''
	public sub VZero( byref r as vector )
		r.x = 0
		r.y = 0
	end sub

	''
	public sub VSet( byref r as vector, byval x as const real, byval y as const real )
		r.x = x
		r.y = y
	end sub

	''
	public sub VNeg( byref r as vector, byref a as const vector )
		r.x = -a.x
		r.y = -a.y
	end sub

	''
	public sub VAdd( byref r as vector, byref a as const vector, byref b as const vector )
		r.x = a.x + b.x
		r.y = a.y + b.y
	end sub

	''
	public sub VAddComp( byref r as vector, byref a as const vector, byval x as const real, byval y as const real )
		r.x = a.x + x
		r.y = a.y + y
	end sub

	''
	public sub VSub( byref r as vector, byref a as const vector, byref b as const vector )
		r.x = a.x - b.x
		r.y = a.y - b.y
	end sub

	''
	public sub VSubComp( byref r as vector, byref a as const vector, byval x as const real, byval y as const real )
		r.x = a.x - x
		r.y = a.y - y
	end sub

	''
	public sub VMul( byref r as vector, byval k as const real, byref a as const vector )
		r.x = k * a.x
		r.y = k * a.y
	end sub

	''
	public sub VAddMul( byref r as vector, byval k1 as const real, byref a as const vector, byval k2 as const real, byref b as const vector )
		r.x = k1 * a.x + k2 * b.x
		r.y = k1 * a.y + k2 * b.y
	end sub

	''
	public function AddMinimal( byval x as const real, byval d as const real ) as real
		dim nx as real
		if d <> 0 then
			nx = x + d
			if nx = x then
				nx = x + sgn(d) * (abs(x) * MIN_PRECISION)
			end if
		else
			nx = x
		end if
		function = nx
	end function

	''
	public function AddMinimalDbl( byval x as const double, byval d as const double ) as real
		dim nx as real
		if d <> 0 then
			nx = x + d
			if nx = x then
				nx = x + sgn(d) * (abs(x) * DBL_MIN_PRECISION)
			end if
		else
			nx = x
		end if
		function = nx
	end function

	''
	public function SubMinimal( byval x as const real, byval d as const real ) as real
		dim nx as real
		if d <> 0 then
			nx = x - d
			if nx = x then
				nx = x - sgn(d) * (abs(x) * MIN_PRECISION)
			end if
		else
			nx = x
		end if
		function = nx
	end function

	''
	public sub VNegIm( byref r as vector )
		r.x = -r.x
		r.y = -r.y
	end sub

	''
	public sub VAddIm( byref r as vector, byref a as const vector )
		r.x += a.x
		r.y += a.y
	end sub

	''
	public sub VAddImMinimal( byref r as vector, byref a as const vector )
		r.x = AddMinimal(r.x, a.x)
		r.y = AddMinimal(r.y, a.y)
	end sub

	''
	public sub VAddCompIm( byref r as vector, byval x as const real, byval y as const real )
		r.x += x
		r.y += y
	end sub

	''
	public sub VSubIm( byref r as vector, byref a as const vector )
		r.x -= a.x
		r.y -= a.y
	end sub

	''
	public sub VSubImMinimal( byref r as vector, byref a as const vector )
		r.x = SubMinimal(r.x, a.x)
		r.y = SubMinimal(r.y, a.y)
	end sub

	''
	public sub VSubCompIm( byref r as vector, byval x as const real, byval y as const real )
		r.x -= x
		r.y -= y
	end sub

	''
	public sub VMulIm( byref r as vector, byval k as const real )
		r.x *= k
		r.y *= k
	end sub

	''
	public sub VUnit( byref r as vector, byref a as const vector )
		dim d as real = VMag(a)
		if d > 0 then
			VMul r, 1/d, a
		else
			VSet r, 0, 0
		end if
	end sub

	''
	public sub VUnitIm( byref r as vector )
		dim d as real = VMag(r)
		if d > 0 then
			VMulIm r, 1/d
		else
			VSet r, 0, 0
		end if
	end sub

	''
	public sub VLimitIm( byref v as vector, byval d as const real )
		if v.x > d then v.x = d
		if v.x < -d then v.x = -d
		if v.y > d then v.y = d
		if v.y < -d then v.y = -d
	end sub

	''
	public function VDot( byref a as const vector, byref b as const vector ) as real
		function = a.x * b.x + a.y * b.y
	end function

	''
	public function VMag( byref v as const vector ) as real
		VMag = SQR(v.x * v.x + v.y * v.y)
	end function

	''
	public function VDist( byref a as const vector, byref b as const vector ) as real
		dim v as vector
		VSub v, a, b
		VDist = VMag(v)
	end function

	''
	public sub VPerp( byref v as vector, byref r as const vector )
		v.x = -r.y
		v.y = r.x
	end sub

	''
	public sub VPerpIm( byref r as vector )
		dim a as vector
		a.x = -r.y
		a.y = r.x
		r = a
	end sub

	''
	public sub VRotIm( byref v as vector, byval r as const real )
		dim a as vector
		a.x = v.x * COS(r) - v.y * SIN(r)
		a.y = v.x * SIN(r) + v.y * COS(r)
		v = a
	end sub

	public sub VLineEqFrom2Point( byref r as line_t, byref a as const vector, byref b as const vector )
		dim as vector ab
		VSub ab, a, b
		VUnitIm ab
		VPerp r.n, ab
		r.d = -VDot(a, r.n)
	end sub

	public sub VLineEqFromPointNormal( byref r as line_t, byref a as const vector, byref n as const vector )
		VUnit r.n, n
		r.d = -VDot(a, r.n)
	end sub

	public function VString( byref v as const vector) as string
		dim x as string
		x = "(" & str(int(v.x*1000)/1000) & "," & str(int(v.y*1000)/1000) & ")"
		function = x
	end function

end namespace
