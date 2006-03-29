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

#include once "vector.bi"

#if( typeof(real) = typeof(single) )
	#define MIN_PRECISION 1E-7
#endif

#if( typeof(real) = typeof(double) )
	#define MIN_PRECISION 1D-15
#endif

''
sub VZero (r as Vector)
	r.x = 0
	r.y = 0
end sub

''
sub VSet (r AS Vector, x as real, y as real)
	r.x = x
	r.y = y
end sub

''
sub VNeg (r AS Vector, a AS Vector)
	r.x = -a.x
	r.y = -a.y
end sub

''
sub VAdd (r AS Vector, a AS Vector, b AS Vector)
	r.x = a.x + b.x
	r.y = a.y + b.y
end sub

''
sub VAddComp (r AS Vector, a AS Vector, x as real, y as real)
	r.x = a.x + x
	r.y = a.y + y
end sub

''
sub VSub (r AS Vector, a AS Vector, b AS Vector)
	r.x = a.x - b.x
	r.y = a.y - b.y
end sub

''
sub VSubComp (r AS Vector, a AS Vector, x as real, y as real)
	r.x = a.x - x
	r.y = a.y - y
end sub

''
sub VMul (r AS Vector, k as real, a AS Vector)
	r.x = k * a.x
	r.y = k * a.y
end sub

''
sub VAddMul (r AS Vector, k1 as real, a AS Vector, k2 as real, b AS Vector)
	r.x = k1 * a.x + k2 * b.x
	r.y = k1 * a.y + k2 * b.y
end sub

''
function AddMinimal(x as real, d as real) as real
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
function SubMinimal(x as real, d as real) as real
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
sub VNegIm (r AS Vector)
	r.x = -r.x
	r.y = -r.y
end sub

''
sub VAddIm (r AS Vector, a AS Vector)
	r.x += a.x
	r.y += a.y
end sub

''
sub VAddImMinimal (r AS Vector, a AS Vector)
	r.x = AddMinimal(r.x, a.x)
	r.y = AddMinimal(r.y, a.y)
end sub

''
sub VAddCompIm (r AS Vector, x as real, y as real)
	r.x += x
	r.y += y
end sub

''
sub VSubIm (r AS Vector, a AS Vector)
	r.x -= a.x
	r.y -= a.y
end sub

''
sub VSubImMinimal (r AS Vector, a AS Vector)
	r.x = SubMinimal(r.x, a.x)
	r.y = SubMinimal(r.y, a.y)
end sub

''
sub VSubCompIm (r AS Vector, x as real, y as real)
	r.x -= x
	r.y -= y
end sub

''
sub VMulIm (r AS Vector, k as real)
	r.x *= k
	r.y *= k
end sub

''
sub VUnit(r as vector, a as vector)
	dim d as real = VMag(a)
	if d > 0 then
		VMul r, 1/d, a
	else
		VSet r, 0, 0
	end if
end sub

''
sub VUnitIm(r as vector)
	dim d as real = VMag(r)
	if d > 0 then
		VMulIm r, 1/d
	else
		VSet r, 0, 0
	end if
end sub

''
sub VLimitIm (v AS Vector, d as real)
	if v.x > d then v.x = d
	if v.x < -d then v.x = -d
	if v.y > d then v.y = d
	if v.y < -d then v.y = -d
end sub

''
function VDot(a as vector, b as vector) as real
	function = a.x * b.x + a.y * b.y
end function

''
function VMag (v AS Vector) as real
	VMag = SQR(v.x * v.x + v.y * v.y)
end function

''
function VDist (a AS Vector, b AS Vector) as real
	dim v AS Vector
	VSub v, a, b
	VDist = VMag(v)
end function

''
sub VPerp (v AS Vector, r as vector)
	v.x = -r.y
	v.y = r.x
end sub

''
sub VPerpIm (r as vector)
	dim a as vector
	a.x = -r.y
	a.y = r.x
	r = a
end sub

''
sub VRotIm (v AS Vector, r as real)
	dim a AS Vector
	a.x = v.x * COS(r) - v.y * SIN(r)
	a.y = v.x * SIN(r) + v.y * COS(r)
	v = a
end sub

sub VLineEqFrom2Point(r as line_t, a as vector, b as vector)
	dim as vector ab
	VSub ab, a, b
	VUnitIm ab
	VPerp r.n, ab
	r.d = -VDot(a, r.n)
end sub

sub VLineEqFromPointNormal(r as line_t, a as vector, n as vector)
	VUnit r.n, n
	r.d = -VDot(a, r.n)
end sub

function VString(v as vector) as string
	dim x as string
	x = "(" & str(int(v.x*1000)/1000) & "," & str(int(v.y*1000)/1000) & ")"
	function = x
end function

