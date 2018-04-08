'' ============================================================
'' 3D vector Functions
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

#include once "simple_vector3.bi"
#include once "vbcompat.bi"

namespace simple_vector3

	''
	public sub VZero( byref v as vector )
		v.x = 0
		v.y = 0
		v.z = 0
	end sub

	''
	public sub VAdd( byref v as vector, byref a as const vector, byref b as const vector )
		v.x = a.x + b.x
		v.y = a.y + b.y
		v.z = a.z + b.z
	end sub

	''
	public sub VAdd2V( byref v as vector, byref a as const vector )
		v.x = v.x + a.x
		v.y = v.y + a.y
		v.z = v.z + a.z
	end sub

	''
	public sub VAddComp( byref v as vector, byref a as const vector, byval x as const real, byval y as const real, byval z as const real )
		v.x = a.x + x
		v.y = a.y + y
		v.z = a.z + z
	end sub

	''
	public sub VAddComp2V( byref v as vector, byval x as const real, byval y as const real, byval z as const real )
		v.x = v.x + x
		v.y = v.y + y
		v.z = v.z + z
	end sub

	''
	public sub VAddMul( byref v as vector, byval k1 as const real, byref a as const vector, byval  k2 as const real, byref b as const vector )
		v.x = k1 * a.x + k2 * b.x
		v.y = k1 * a.y + k2 * b.y
		v.z = k1 * a.z + k2 * b.z
	end sub

	''
	public function VDist( byref a as const vector, byref b as const vector ) as real
		dim v as vector
		VSub v, a, b
		VDist = VMag(v)
	end function

	''
	public sub VLimit2V( byref v as vector, byval d as const real )
		if v.x > d then v.x = d
		if v.x < -d then v.x = -d
		if v.y > d then v.y = d
		if v.y < -d then v.y = -d
		if v.z > d then v.z = d
		if v.z < -d then v.z = -d
	end sub

	''
	public function VMag( byref v as const vector ) as real
		VMag = SQR(v.x * v.x + v.y * v.y + v.z * v.z)
	end function

	''
	public sub VNeg( byref v as vector, byref a as const vector )
		VScale v, a, -1
	end sub

	''
	public sub VNeg2V( byref v as vector )
		VScale2V v, -1
	end sub

	''
	public sub VScale( byref v as vector, byref a as const vector, byval k as const real )
		v.x = k * a.x
		v.y = k * a.y
		v.z = k * a.z
	end sub

	''
	public sub VScale2V( byref v as vector, byval k as const real )
		v.x = k * v.x
		v.y = k * v.y
		v.z = k * v.z
	end sub

	''
	public sub VSet( byref v as vector, byval x as const real, byval y as const real, byval z as const real )
	  v.x = x
	  v.y = y
	  v.z = z
	end sub

	''
	public sub VSub( byref v as vector, byref a as const vector, byref b as const vector )
		v.x = a.x - b.x
		v.y = a.y - b.y
		v.z = a.z - b.z
	end sub

	''
	public sub VSub2V( byref v as vector, byref a as const vector )
		v.x = v.x - a.x
		v.y = v.y - a.y
		v.z = v.z - a.z
	end sub

	''
	public sub VSubComp( byref v as vector, byref a as const vector, byval x as const real, byval y as const real, byval z as const real )
		v.x = a.x - x
		v.y = a.y - y
		v.z = a.z - z
	end sub

	''
	public sub VSubComp2V( byref v as vector, byval x as const real, byval y as const real, byval z as const real )
		v.x = v.x - x
		v.y = v.y - y
		v.z = v.z - z
	end sub

	''
	public sub VRot2Vx( byref v as vector, byval r as const real )
		dim a as vector
		a.x = v.x
		a.y = -v.z * SIN(r) + v.y * COS(r)
		a.z = v.z * COS(r) + v.y * SIN(r)
		v = a
	end sub

	''
	public sub VRot902Vx( byref v as vector )
		dim a as vector
		a = v
		v.x = a.x
		v.y = a.z
		v.z = -a.y
	end sub

	''
	public sub VRot2Vy( byref v as vector, byval r as const real )
		dim a as vector
		a.x = v.x * COS(r) + v.z * SIN(r)
		a.y = v.y
		a.z = -v.x * SIN(r) + v.z * COS(r)
		v = a
	end sub

	''
	public sub VRot902Vy( byref v as vector )
		dim a as vector
		a = v
		v.x = -a.z
		v.y = a.y
		v.z = a.x
	end sub

	''
	public sub VRot2Vz( byref v as vector, byval r as const real )
		dim a as vector
		a.x = v.x * COS(r) + v.y * SIN(r)
		a.y = -v.x * SIN(r) + v.y * COS(r)
		a.z = v.z
		v = a
	end sub

	''
	public sub VRot902Vz( byref v as vector )
		dim a as vector
		a = v
		v.x = -a.y
		v.y = a.x
		v.z = a.z
	end sub

	''
	public function VDot( byref v1 as const vector, byref v2 as const vector ) as real
		function = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
	end function

	''
	public sub VUnit( byref v as vector, byref a as const vector )
		dim d as real = VMag(a)
		if d > 0 then
			VScale v, a, 1/d
		else
			VSet v, 0, 0, 0
		end if
	end sub

	''
	public sub VUnit2V( byref v as vector )
		dim d as real = VMag(v)
		if d > 0 then
			VScale2V v, 1/d
		else
			VSet v, 0, 0, 0
		end if
	end sub

	''
	public function VString( byref v as const vector ) as string
		function = "(" & v.x & ", " & v.y & ", " & v.z & ")"
	end function

	public function VFormat( byref v as const vector, byref fmt as const string = "" ) as string
		function = "(" & format( v.x, fmt ) & ", " & format( v.y, fmt ) & ", " & format( v.z, fmt ) & ")"
	end function

end namespace
