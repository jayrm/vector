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

''
sub VZero (r as Vector)
	r.x = 0
	r.y = 0
end sub

''
sub VSet (r AS Vector, x as single, y as single)
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
sub VAddComp (r AS Vector, a AS Vector, x as single, y as single)
	r.x = a.x + x
	r.y = a.y + y
end sub

''
sub VSub (r AS Vector, a AS Vector, b AS Vector)
	r.x = a.x - b.x
	r.y = a.y - b.y
end sub

''
sub VSubComp (r AS Vector, a AS Vector, x as single, y as single)
	r.x = a.x - x
	r.y = a.y - y
end sub

''
sub VMul (r AS Vector, k as single, a AS Vector)
	r.x = k * a.x
	r.y = k * a.y
end sub

''
sub VAddMul (r AS Vector, k1 as single, a AS Vector, k2 as single, b AS Vector)
	r.x = k1 * a.x + k2 * b.x
	r.y = k1 * a.y + k2 * b.y
end sub

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
sub VAddCompIm (r AS Vector, x as single, y as single)
	r.x += x
	r.y += y
end sub

''
sub VSubIm (r AS Vector, a AS Vector)
	r.x -= a.x
	r.y -= a.y
end sub

''
sub VSubCompIm (r AS Vector, x as single, y as single)
	r.x -= x
	r.y -= y
end sub

''
sub VMulIm (r AS Vector, k as single)
	r.x *= k
	r.y *= k
end sub

''
sub VUnitIm(r as vector)
	dim d as single = VMag(r)
	if d > 0 then
		VMulIm r, 1/d
	else
		VSet r, 0, 0
	end if
end sub

''
sub VLimitIm (v AS Vector, d as single)
	if v.x > d then v.x = d
	if v.x < -d then v.x = -d
	if v.y > d then v.y = d
	if v.y < -d then v.y = -d
end sub

''
function VDot(a as vector, b as vector) as single
	function = a.x * b.x + a.y * b.y
end function

''
function VMag (v AS Vector) as single
	VMag = SQR(v.x * v.x + v.y * v.y)
end function

''
function VDist (a AS Vector, b AS Vector) as single
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
sub VRotIm (v AS Vector, r as single)
	dim a AS Vector
	a.x = v.x * COS(r) - v.y * SIN(r)
	a.y = v.x * SIN(r) + v.y * COS(r)
	v = a
end sub
