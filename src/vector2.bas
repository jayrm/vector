''	vector - geometric vector library
''	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)

#include once "vector2.bi"

'' ------------------------------------
'' VECTOR2
'' ------------------------------------

namespace vectors

	'':::::
	public sub vector2.set( byval _x as const real, byval _y as const real ) EXPORT
		'' assign components
		'' {v}.set( x, y ) 
		x = _x
		y = _y
	end sub

	'':::::
	public operator vector2.let ( byref b as const vector2 ) EXPORT
		'' assignment operator '='
		'' {v} = {b}
		with b
			x = .x
			y = .y
		end with
	end operator

	'':::::
	public operator vector2.-= ( byref b as const vector2 ) EXPORT
		'' subtraction and assignment operator '-='
		'' {v} -= {b}
		with b
			x -= .x
			y -= .y
		end with
	end operator

	'':::::
	public operator vector2.+= ( byref b as const vector2 ) EXPORT
		'' addition and assignment operator '+='
		'' {v} += {b}
		with b
			x += .x
			y += .y
		end with
	end operator

	'':::::
	public operator vector2.*= ( byval k as const real ) EXPORT
		'' Multiply vector by scalar and assignment operator *=
		'' {v} *= k
		x *= k
		y *= k
	end operator

	'':::::
	public operator vector2./= ( byval k as const real ) EXPORT
		'' Multiply vector by scalar and assignment operator *=
		'' {v} *= k
		x /= k
		y /= k
	end operator

	'':::::
	public function vector2.magnitude() as real	EXPORT
		'' Magnitude (length) of vector
		'' d = |{v}|
		function = sqr( x * x + y * y )
	end function

	'':::::
	public function vector2.magnitude2() as real EXPORT
		'' Magnitude (length) of vector squared
		'' d = |{v}|^2
		function = x * x + y * y
	end function

	'':::::
	public function vector2.distance( byref b as const vector2 ) as real EXPORT	
		'' Distance (length) between two points
		'' d = |{b}-{a}|
		function = sqr( (b.x-x)*(b.x-x) + (b.y-y)*(b.y-y) )
	end function

	'':::::
	public function vector2.distance2( byref b as const vector2 ) as real	EXPORT
		'' Distance (length) between two points squared
		'' d = |{b}-{a}|^2
		function = (b.x-x)*(b.x-x) + (b.y-y)*(b.y-y)
	end function

	'':::::
	public function vector2.unit() as vector2 EXPORT
		'' unit vector
		'' {r} = {v}/|{v}|
		dim ret as vector2 = this
		ret.normalize
		function = ret
	end function

	'':::::
	public sub vector2.normalize() EXPORT
		'' normalize, self-op unit vector
		'' {v} = {v}/|{v}|
		dim k as real
		k = this.magnitude()
		if( k = 0 ) then
			this.selfop_zero()
		else
			this *= 1.0/k
		end if
	end sub

	'':::::
	public sub vector2.selfop_neg() EXPORT
		'' self-op negative
		'' {v} = -{v}
		x = -x
		y = -y
	end sub

	'':::::
	public sub vector2.selfop_zero() EXPORT
		'' self-op assign zero vector
		'' {v} = (0, 0)
		x = 0
		y = 0
	end sub

	'':::::
	public operator vector2.cast() as string EXPORT
		'' convert to STRING
		'' s = cstr( {v} )
		operator = "(" & x & ", " & y & ")"
	end operator

	'':::::
	public function vector2.dot( byref b as const vector2 ) as real EXPORT
		function = x * b.x + y * b.y
	end function

	'':::::
	public function vector2.cross( byref b as const vector2 ) as real EXPORT
		function = x * b.y - y * b.x
	end function

	'':::::
	public function vector2.perp() as vector2 EXPORT
		function = type( -y, x )
	end function

	'':::::
	public function vector2.scale( byref b as const vector2 ) as vector2 EXPORT
		'' entry wise product
		'' {r} = {v} o {b}
		function = type( _
			x * b.x, _
			y * b.y _
		)
	end function

	'':::::
	public const function vector2.scale( byval k as const real ) as vector2 EXPORT
		'' multiply vector by scalar
		'' {r} = {v} * k
		function = type( _
			x * k, _
			y * k _
		)
	end function

	'':::::
	public operator - ( byref b as const vector2 ) as vector2 EXPORT
		'' negate unary operator '-'
		'' {r} = -{b}
		operator = type( _
			-b.x, _
			-b.y _
		)
	end operator

	'':::::
	public operator - ( byref a as const vector2, byref b as const vector2 ) as vector2 EXPORT
		'' subtraction binary operator '-'
		'' {r} = {a} - {b}
		operator = type( _
			a.x - b.x, _
			a.y - b.y _
		)
	end operator

	'':::::
	public operator + ( byref a as const vector2, byref b as const vector2 ) as vector2 EXPORT
		operator = type( _
			a.x + b.x, _
			a.y + b.y _
		)
	end operator

	'':::::
	public operator + ( byref a as vector2, byref b as vector2 ) as vector2 EXPORT
		'' addition binary operator '+'
		'' {r} = {a} + {b}
		operator = type( _
			a.x + b.x, _
			a.y + b.y _
		)
	end operator

	''::::: 
	public operator * ( byref a as const vector2, byval k as real ) as vector2 EXPORT
		'' multiply vector by scalar binary operator '*'
		'' {v} = {a} * k
		operator = type( _
			a.x * k, _
			a.y * k _
		)
	end operator

	'':::::
	public operator * ( byval k as real, byref b as const vector2 ) as vector2 EXPORT
		'' multiply vector by scalar binary operator
		'' {v} = k * {b}
		operator = type( _
			k * b.x, _
			k * b.y _
		)
	end operator

	'':::::
	public operator / ( byref a as const vector2, byval k as real ) as vector2 EXPORT
		'' divide vector by scalar binary operator
		'' {v} = {a} / k
		operator = type( _
			a.x / k, _
			a.y / k _
		)
	end operator

	'':::::
	public operator * ( byref a as const vector2, byref b as const vector2 ) as real EXPORT
		'' scalar dot product binary operator '*'
		'' d = {a} . {b}
		operator = a.x * b.x + a.y * b.y
	end operator

	'':::::
	public function vector2.isZero( ) as boolean
		function = cbool( x = creal(0.0) andalso y = creal(0.0) )
	end function

	'':::::
	public operator = ( byref ls as const vector2, byref rs as const vector2 ) as boolean
		operator = ( ls.x = rs.x ) andalso ( ls.y = rs.y )
	end operator

	'':::::
	public operator <> ( byref ls as const vector2, byref rs as const vector2 ) as boolean
		operator = ( ls.x <> rs.x ) orelse (ls.y <> rs.y )
	end operator


end namespace
