'' ============================================================
'' 3D Vector Functions
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

#include "simple_vector3.bi"

public sub VAdd (byref v AS Vector, byref a AS Vector, byref b AS Vector)
  v.x = a.x + b.x
  v.y = a.y + b.y
  v.z = a.z + b.z
end sub
public sub VAdd2V (byref v AS Vector, byref a AS Vector)
  v.x = v.x + a.x
  v.y = v.y + a.y
  v.z = v.z + a.z
end sub
public sub VAddComp (byref v AS Vector, byref a AS Vector, byval x as single, byval y as single, byval z as single)
  v.x = a.x + x
  v.y = a.y + y
  v.z = a.z + z
end sub
public sub VAddComp2V (byref v AS Vector, byval x as single, byval y as single, byval z as single)
  v.x = v.x + x
  v.y = v.y + y
  v.z = v.z + z
end sub
public sub VAddMul (byref v AS Vector, byval k1 as single, byref a AS Vector, byval  k2 as single, byref b AS Vector)
  v.x = k1 * a.x + k2 * b.x
  v.y = k1 * a.y + k2 * b.y
  v.z = k1 * a.z + k2 * b.z
end sub
public function VDist (byref a AS Vector, byref b AS Vector) as single
  dim v AS Vector
  VSub v, a, b
  VDist = VMag(v)
end function
public sub VLimit2V (byref v AS Vector, byval d as single)
  if v.x > d then v.x = d
  if v.x < -d then v.x = -d
  if v.y > d then v.y = d
  if v.y < -d then v.y = -d
  if v.z > d then v.z = d
  if v.z < -d then v.z = -d
end sub
public function VMag (byref v AS Vector) as single
  VMag = SQR(v.x * v.x + v.y * v.y + v.z * v.z)
end function
public sub VNeg (byref v AS Vector, byref a AS Vector)
  VScale v, a, -1
end sub
public sub VNeg2V (byref v AS Vector)
  VScale2V v, -1
end sub
public sub VScale (byref v AS Vector, byref a AS Vector, byval k as single)
  v.x = k * a.x
  v.y = k * a.y
  v.z = k * a.z
end sub
public sub VScale2V (byref v AS Vector, byval k as single)
  v.x = k * v.x
  v.y = k * v.y
  v.z = k * v.z
end sub
public sub VSet (byref v AS Vector, byval x as single, byval y as single, byval z as single)
  v.x = x
  v.y = y
  v.z = z
end sub
public sub VSub (byref v AS Vector, byref a AS Vector, byref b AS Vector)
  v.x = a.x - b.x
  v.y = a.y - b.y
  v.z = a.z - b.z
end sub
public sub VSub2V (byref v AS Vector, byref a AS Vector)
  v.x = v.x - a.x
  v.y = v.y - a.y
  v.z = v.z - a.z
end sub
public sub VSubComp (byref v AS Vector, byref a AS Vector, byval x as single, byval y as single, byval z as single)
  v.x = a.x - x
  v.y = a.y - y
  v.z = a.z - z
end sub

public sub VRot2Vx (byref v AS Vector, byval r as single)
  dim a AS Vector
	a.x = v.x
  a.y = -v.z * SIN(r) + v.y * COS(r)
  a.z = v.z * COS(r) + v.y * SIN(r)
  v = a
end sub
public sub VRot902Vx (byref v AS Vector)
  dim a AS Vector
  a = v
	v.x = a.x
  v.y = a.z
  v.z = -a.y
end sub

public sub VRot2Vy (byref v AS Vector, byval r as single)
  dim a AS Vector
  a.x = v.x * COS(r) + v.z * SIN(r)
	a.y = v.y
  a.z = -v.x * SIN(r) + v.z * COS(r)
  v = a
end sub
public sub VRot902Vy (byref v AS Vector)
  dim a AS Vector
  a = v
  v.x = -a.z
	v.y = a.y
  v.z = a.x
end sub

public sub VRot2Vz (byref v AS Vector, byval r as single)
  dim a AS Vector
  a.x = v.x * COS(r) + v.y * SIN(r)
  a.y = -v.x * SIN(r) + v.y * COS(r)
	a.z = v.z
  v = a
end sub
public sub VRot902Vz (byref v AS Vector)
  dim a AS Vector
  a = v
  v.x = -a.y
  v.y = a.x
	v.z = a.z
end sub

public function VDot(byref v1 as vector, byref v2 as vector) as single
	function = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
end function
