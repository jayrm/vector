#ifndef __SIMPLE_VECTOR3_BI__
#define __SIMPLE_VECTOR3_BI__

type Vector
	as single x
	as single y
	as single z
end type

Type Camera_t
	as vector p
	as vector v
	as vector f
	as vector l
	as vector u
	as single heading
	as single pitch
end type

declare sub VAdd (byref v AS Vector, byref a AS Vector, byref b AS Vector)
declare sub VAdd2V (byref v AS Vector, byref a AS Vector)
declare sub VAddComp (byref v AS Vector, byref a AS Vector, byval x as single, byval y as single, byval z as single)
declare sub VAddComp2V (byref v AS Vector, byval x as single, byval y as single, byval z as single)
declare sub VAddMul (byref v AS Vector, byval k1 as single, byref a AS Vector, byval k2 as single, byref b AS Vector)
declare function VDist (byref a AS Vector, byref b AS Vector) as single
declare sub VLimit2V (byref v AS Vector, byval d as single)
declare function VMag (byref v AS Vector) as single
declare sub VNeg (byref v AS Vector, byref a AS Vector)
declare sub VNeg2V (byref v AS Vector)
declare sub VScale (byref v AS Vector, byref a AS Vector, byval  k as single)
declare sub VScale2V (byref v AS Vector, byval k as single)
declare sub VSet (byref v AS Vector, byval x as single, byval y as single, byval z as single)
declare sub VSub (byref v AS Vector, byref a AS Vector, byref b AS Vector)
declare sub VSub2V (byref v AS Vector, byref a AS Vector)
declare sub VSubComp (byref v AS Vector, byref a AS Vector, byval x as single, byval y as single, byval z as single)

declare sub VRot2Vx (byref v AS Vector, byval r as single)
declare sub VRot902Vx (byref v AS Vector)
declare sub VRot2Vy (byref v AS Vector, byval r as single)
declare sub VRot902Vy (byref v AS Vector)
declare sub VRot2Vz (byref v AS Vector, byval r as single)
declare sub VRot902Vz (byref v AS Vector)

declare function VDot(byref v1 as vector, byref v2 as vector) as single

#endif
