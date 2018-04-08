''	vector - geometric vector library
''	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)

#include once "pointer_vec2.bi"
#include once "vbcompat.bi"

namespace pointer_vec2

	'' --------------------------------------------------------------------------
	'' Basic Vector Functions
	'' --------------------------------------------------------------------------

	Function V2Make( ByVal a As Vec2_T Ptr, ByVal x As REAL, ByVal y As REAL ) As Vec2_T Ptr
		a->x = x
		a->y = y
		return a
	End Function

	Function V2Zero( ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		a->x = 0
		a->y = 0
		return a
	End Function

	Sub V2Split( ByVal a As Vec2_T Ptr, ByRef x As REAL, ByRef y As REAL )
		x = a->x
		y = a->y
	End Sub

	'' --------------------------------------------------------------------------
	'' Vector functions that modify passed vector(s)
	'' --------------------------------------------------------------------------

	Function V2Unit( ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		Dim k As REAL = V2Mag(a)
		If k = 0 Then
			V2Zero a
		Else
			V2Mul a, 1.0/k
		End If
		return a
	End Function

	Function V2Neg( ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		a->x = -a->x
		a->y = -a->y
		return a
	End Function

	Function V2Add( ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As Vec2_T Ptr
		a->x += b->x
		a->y += b->y
		return a
	End Function

	Function V2Sub( ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As Vec2_T Ptr
		a->x -= b->x
		a->y -= b->y
		return a
	End Function

	Function V2Mul( ByVal a As Vec2_T Ptr, byval k As Real) As Vec2_T Ptr
		a->x *= k
		a->y *= k
		return a
	End Function

	Function V2MulAdd( ByVal a As Vec2_T Ptr, byval k1 As REAL, ByVal b As Vec2_T Ptr, byval k2 As REAL ) As Vec2_T Ptr
		a->x = k1 * a->x + k2 * b->x
		a->y = k1 * a->y + k2 * b->y 
		return a
	End Function

	'' --------------------------------------------------------------------------
	'' Vector functions that return results in a seperate Vector
	'' --------------------------------------------------------------------------

	Function V2UnitR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		Dim k As REAL = V2Mag(a)
		If k = 0 Then
			V2Zero r
		Else
			V2MulR r, a, 1.0/k
		End If
		return r
	End Function

	Function V2NegR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr ) As Vec2_T Ptr
		r->x = -a->x
		r->y = -a->y
		return r
	End Function

	Function V2AddR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As Vec2_T Ptr
		r->x = a->x + b->x
		r->y = a->y + b->y
		return r
	End Function

	Function V2SubR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As Vec2_T Ptr
		r->x = a->x - b->x
		r->y = a->y - b->y
		return r
	End Function

	Function V2MulR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr, byval k As Real) As Vec2_T Ptr
		r->x = k * a->x
		r->y = k * a->y
		return r
	End Function

	Function V2MulAddR( ByVal r As Vec2_T Ptr, ByVal a As Vec2_T Ptr, byval k1 As REAL, ByVal b As Vec2_T Ptr, byval k2 As REAL ) As Vec2_T Ptr
		r->x = k1 * a->x + k2 * b->x
		r->y = k1 * a->y + k2 * b->y 
		return r
	End Function

	'' --------------------------------------------------------------------------
	'' Vector functions that return a scalr result
	'' --------------------------------------------------------------------------

	Function V2Dist( ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As REAL
		return sqr((b->x - a->x) * (b->x - a->x) + (b->y - a->y) * (b->y - a->y))
	End Function

	Function V2Mag( ByVal a As Vec2_T Ptr ) As REAL
		return sqr(a->x * a->x + a->y * a->y)
	End Function

	Function V2Dot( ByVal a As Vec2_T Ptr, ByVal b As Vec2_T Ptr ) As REAL
		return ((a->x * b->x) + (a->y * b->y))
	End Function

	Function Deg2Rad( ByVal a As REAL ) As REAL
		return a / 180.0 * PI
	End Function

	Function Rad2Deg( ByVal a As REAL ) As REAL
		return a / PI * 180.0
	End Function

	Function FixAngle360( ByVal a As REAL ) As REAL
		Dim t As REAL = a
		Do While (t < 0)
			t += 360
		Loop
		Do While (t >= 360)
			t -= 360
		Loop
		Return t
	End Function

	Function FixAngle180( ByVal a As REAL ) As REAL
		Dim t As REAL = a
		Do While (t < -180)
			t += 360
		Loop
		Do While (t >= 180)
			t -= 360
		Loop
		Return t
	End Function

	Function V2Angle( ByVal a As Vec2_T Ptr ) As REAL
		Dim xx As REAL = Abs(a->x)
		Dim yy As REAL = Abs(a->y)
		If (xx >= yy) Then
			If (a->x < 0) Then
				return PI + ATN(a->y / a->x)
			Else
				If (a->y < 0) Then
					return 2 * PI + ATN(a->y / a->x)
				Else
					return ATN(a->y / a->x)
				End If
			End If
		Else
			If (a->y < 0) Then
				return 3 * PI / 2 - ATN(a->x / a->y)
			Else
				return PI / 2 - ATN(a->x / a->y)
			End If
		End If
	End Function

	Function LimitValue( ByVal a As REAL, ByVal lo As REAL, ByVal Hi As REAL ) As REAL
		If a < lo Then
			return lo
		ElseIf a > hi Then
			return hi
		End If
		return a
	End Function

	Function GetAngleDelta( ByVal a1 As REAL, ByVal a2 As REAL ) As REAL
		Dim a As REAL = FixAngle180( a2 - a1 )
		return a
	End Function

	Function V2String( ByVal a As Vec2_T Ptr ) as String
		function = "(" & a->x & ", " & a->y & ")"
	end function

	Function V2Format( ByVal a As Vec2_T Ptr, byref fmt as const string = "" ) as String
		function = "(" & format( a->x, fmt) & ", " & format( a->y, fmt ) & ")"
	end function

end namespace
