''	vector - geometric vector library
''	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)

#include once "vector3.bi"

namespace vectors

	'':::::
	public sub vector3.set( byval _x as real, byval _y as real, byval _z as real ) EXPORT
		'' assign components
		'' {v}.set( x, y, z ) 
		x = _x
		y = _y
		z = _z
	end sub

	'':::::
	public operator vector3.let ( byref b as const vector3 ) EXPORT
		'' assignment operator '='
		'' {v} = {b}
		with b
			x = .x
			y = .y
			z = .z
		end with
	end operator

	'':::::
	public operator vector3.-= ( byref b as const vector3 ) EXPORT
		'' subtraction and assignment operator '-='
		'' {v} -= {b}
		with b
			x -= .x
			y -= .y
			z -= .z
		end with
	end operator

	'':::::
	public operator vector3.+= ( byref b as const vector3 ) EXPORT
		'' addition and assignment operator '+='
		'' {v} += {b}
		with b
			x += .x
			y += .y
			z += .z
		end with
	end operator

	'':::::
	public operator vector3.*= ( byval k as real ) EXPORT
		'' Multiply vector by scalar and assignment operator *=
		'' {v} *= k
		x *= k
		y *= k
		z *= k
	end operator

	'':::::
	public operator vector3./= ( byval k as real ) EXPORT
		'' Divide vector by scalar and assignment operator /=
		'' {v} /= k
		x /= k
		y /= k
		z /= k
	end operator

	'':::::
	public function vector3.magnitude() as real	EXPORT
		'' Magnitude (length) of vector
		'' d = |{v}|
		function = sqr( x * x + y * y + z * z ) 
	end function

	'':::::
	public function vector3.magnitude2() as real EXPORT
		'' Magnitude (length) of vector squared
		'' d = |{v}|^2
		function = x * x + y * y + z * z
	end function

	'':::::
	public function vector3.distance( byref b as const vector3 ) as real EXPORT
		'' Distance (length) between two points
		'' d = |{b}-{a}|
		function = sqr( (b.x-x)*(b.x-x) + (b.y-y)*(b.y-y) + (b.z-z)*(b.z-z) )
	end function

	'':::::
	public function vector3.distance2( byref b as const vector3 ) as real	EXPORT
		'' Distance (length) between two points squared
		'' d = |{b}-{a}|^2
		function = (b.x-x)*(b.x-x) + (b.y-y)*(b.y-y) + (b.z-z)*(b.z-z)
	end function

	'':::::
	public function vector3.unit() as vector3 EXPORT
		'' unit vector
		'' {r} = {v}/|{v}|
		dim ret as vector3 = this
		ret.normalize
		function = ret
	end function

	'':::::
	public sub vector3.normalize() EXPORT
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
	public sub vector3.selfop_neg() EXPORT
		'' self-op negative
		'' {v} = -{v}
		x = -x
		y = -y
		z = -z
	end sub

	'':::::
	public sub vector3.selfop_zero() EXPORT
		'' self-op assign zero vector
		'' {v} = (0, 0)
		x = 0
		y = 0
		z = 0
	end sub

	'':::::
	public const operator vector3.cast() as string EXPORT
		'' convert to STRING
		'' s = cstr( {v} )
		operator = "(" & x & ", " & y & ", " & z & ")"
	end operator

	'':::::
	public function vector3.dot( byref b as const vector3 ) as real EXPORT
		'' scalar dot product
		'' d = {v} . {b}
		function = x * b.x + y * b.y + z * b.z
	end function

	'':::::
	public function vector3.cross( byref b as const vector3 ) as vector3 EXPORT
		'' cross product
		'' {r} = {v} X {b}
		function = type( _
			y * b.z - z * b.y, _
			z * b.x - x * b.z, _
			x * b.y - y * b.x _
		)
	end function

	'':::::
	public function vector3.scale( byref b as const vector3 ) as vector3 EXPORT
		'' entry wise product
		'' {r} = {v} o {b}
		function = type( _
			x * b.x, _
			y * b.y, _
			z * b.z _
		)
	end function

	'':::::
	public function vector3.scale( byval k as real ) as vector3 EXPORT
		'' multiply vector by scalar
		'' {r} = {v} * k
		function = type( _
			x * k, _
			y * k, _
			z * k _
		)
	end function

	'':::::
	public operator - ( byref b as const vector3 ) as vector3 EXPORT
		'' negate unary operator '-'
		'' {r} = -{b}
		operator = type( _
			-b.x, _
			-b.y, _
			-b.z _
		)
	end operator

	'':::::
	public operator - ( byref a as const vector3, byref b as const vector3 ) as vector3 EXPORT
		'' subtraction binary operator '-'
		'' {r} = {a} - {b}
		operator = type( _
			a.x - b.x, _
			a.y - b.y, _
			a.z - b.z _
		)
	end operator

	'':::::
	public operator + ( byref a as const vector3, byref b as const vector3 ) as vector3 EXPORT
		'' addition binary operator '+'
		'' {r} = {a} + {b}
		operator = type( _
			a.x + b.x, _
			a.y + b.y, _
			a.z + b.z _
		)
	end operator

	'':::::
	public operator * ( byref a as const vector3, byval k as real ) as vector3 EXPORT
		'' multiply vector by scalar binary operator '*'
		'' {v} = {a} * k
		operator = type( _
			a.x * k, _
			a.y * k, _
			a.z * k _
		)
	end operator

	'':::::
	public operator * ( byval k as real, byref b as const vector3 ) as vector3 EXPORT
		'' multiply vector by scalar binary operator
		'' {v} = k * {b}
		operator = type( _
			k * b.x, _
			k * b.y, _
			k * b.z _
		)
	end operator

	'':::::
	public operator / ( byref a as const vector3, byval k as real ) as vector3 EXPORT
		'' divide vector by scalar binary operator
		'' {v} = {a} / k
		operator = type( _
			a.x / k, _
			a.y / k, _
			a.z / k _
		)
	end operator

	'':::::
	public operator * ( byref a as const vector3, byref b as const vector3 ) as real EXPORT
		'' scalar dot product binary operator '*'
		'' d = {a} . {b}
		operator = a.x * b.x + a.y * b.y + a.z * b.z
	end operator

end namespace
