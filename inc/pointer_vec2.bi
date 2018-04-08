#ifndef __POINTER_VEC2_BI_INCLUDE__
#define __POINTER_VEC2_BI_INCLUDE__ 1

	#inclib "pointer_vec2"

	namespace pointer_vec2

		#define REAL Single

		Type Vec2_T
		  x As REAL
		  y As REAL
		End Type

		const PI as single = 3.14159265

		Declare Function V2Make( ByVal a As Vec2_T Ptr, ByVal x As REAL, ByVal y As REAL ) As Vec2_T Ptr
		Declare Function V2Zero( ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		Declare Sub V2Split( ByVal a As Vec2_T Ptr, ByRef x As REAL, ByRef y As REAL )

		Declare Function V2Unit( ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		Declare Function V2Neg( ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		Declare Function V2Add( ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As Vec2_T Ptr
		Declare Function V2Sub( ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As Vec2_T Ptr
		Declare Function V2Mul( ByVal a As Vec2_T Ptr, byval k As REAL ) As Vec2_T Ptr
		Declare Function V2MulAdd( ByVal a As Vec2_T Ptr, byval k1 As REAL, ByVal b As Vec2_T Ptr, byval k2 As REAL ) As Vec2_T Ptr

		Declare Function V2UnitR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		Declare Function V2NegR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		Declare Function V2AddR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As Vec2_T Ptr
		Declare Function V2SubR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As Vec2_T Ptr
		Declare Function V2MulR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr, byval k As Real) As Vec2_T Ptr
		Declare Function V2MulAddR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr, byval k1 As REAL, ByVal b As Vec2_T Ptr, byval k2 As REAL ) As Vec2_T Ptr

		Declare Function V2Dist( ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As REAL
		Declare Function V2Mag( ByVal a As Vec2_T Ptr ) As REAL
		Declare Function V2Dot( ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) AS REAL

		Declare Function Deg2Rad( ByVal a As REAL ) As REAL
		Declare Function Rad2Deg( ByVal a As REAL ) As REAL

		Declare Function FixAngle360( ByVal a As REAL ) As REAL
		Declare Function FixAngle180( ByVal a As REAL ) As REAL

		Declare Function V2Angle( ByVal a As Vec2_T Ptr ) As REAL

		Declare Function LimitValue( ByVal a As REAL, ByVal lo As REAL, ByVal Hi As REAL ) As REAL
		Declare Function GetAngleDelta( ByVal a1 As REAL, ByVal a2 As REAL ) As REAL

		Declare Function V2String( ByVal a As Vec2_T Ptr ) as String
		Declare Function V2Format( ByVal a As Vec2_T Ptr, byref fmt as const string = "" ) as String

	end namespace

#endif
