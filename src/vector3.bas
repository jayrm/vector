#include once "vector3.bi"

namespace vectors

	'':::::
	public sub vector3.set( byval _x as real, byval _y as real, byval _z as real ) EXPORT
		x = _x
		y = _y
		z = _z
	end sub

	'':::::
	public operator vector3.let ( byref b as const vector3 ) EXPORT
		with b
			x = .x
			y = .y
			z = .z
		end with
	end operator

	'':::::
	public operator vector3.-= ( byref b as const vector3 ) EXPORT
		with b
			x -= .x
			y -= .y
			z -= .z
		end with
	end operator

	'':::::
	public operator vector3.+= ( byref b as const vector3 ) EXPORT
		with b
			x += .x
			y += .y
			z += .z
		end with
	end operator

	'':::::
	public operator vector3.*= ( byval k as real ) EXPORT
		x *= k
		y *= k
		z *= k
	end operator

	'':::::
	public operator vector3./= ( byval k as real ) EXPORT
		x /= k
		y /= k
		z /= k
	end operator

	'':::::
	public function vector3.magnitude() as real	EXPORT
		function = sqr( x * x + y * y + z * z ) 
	end function

	'':::::
	public function vector3.magnitude2() as real EXPORT
		function = x * x + y * y + z * z
	end function

	'':::::
	public function vector3.distance( byref b as const vector3 ) as real EXPORT
		function = sqr( (b.x-x)*(b.x-x) + (b.y-y)*(b.y-y) + (b.z-z)*(b.z-z) )
	end function

	'':::::
	public function vector3.distance2( byref b as const vector3 ) as real	EXPORT
		function = (b.x-x)*(b.x-x) + (b.y-y)*(b.y-y) + (b.z-z)*(b.z-z)
	end function

	'':::::
	public function vector3.unit() as vector3 EXPORT
		dim ret as vector3 = this
		ret.normalize
		function = ret
	end function

	'':::::
	public sub vector3.normalize() EXPORT
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
		x = -x
		y = -y
		z = -z
	end sub

	'':::::
	public sub vector3.selfop_zero() EXPORT
		x = 0
		y = 0
		z = 0
	end sub

	'':::::
	public const operator vector3.cast() as string EXPORT
		operator = "(" & x & ", " & y & ", " & z & ")"
	end operator

	'':::::
	public function vector3.dot( byref b as const vector3 ) as real EXPORT
		function = x * b.x + y * b.y + z * b.z
	end function

	'':::::
	public function vector3.cross( byref b as const vector3 ) as vector3 EXPORT
		function = type( _
			y * b.z - z * b.y, _
			z * b.x - x * b.z, _
			x * b.y - y * b.x _
		)
	end function

	'':::::
	public operator - ( byref b as const vector3 ) as vector3 EXPORT
		operator = type( _
			-b.x, _
			-b.y, _
			-b.z _
		)
	end operator

	'':::::
	public operator - ( byref a as const vector3, byref b as const vector3 ) as vector3 EXPORT
		operator = type( _
			a.x - b.x, _
			a.y - b.y, _
			a.z - b.z _
		)
	end operator

	'':::::
	public operator - ( byref a as vector3, byref b as vector3 ) as vector3 EXPORT
		operator = type( _
			a.x - b.x, _
			a.y - b.y, _
			a.z - b.z _
		)
	end operator

	'':::::
	public operator + ( byref a as const vector3, byref b as const vector3 ) as vector3 EXPORT
		operator = type( _
			a.x + b.x, _
			a.y + b.y, _
			a.z + b.z _
		)
	end operator

	'':::::
	public operator + ( byref a as vector3, byref b as vector3 ) as vector3 EXPORT
		operator = type( _
			a.x + b.x, _
			a.y + b.y, _
			a.z + b.z _
		)
	end operator

	'':::::
	public operator * ( byref a as const vector3, byval k as real ) as vector3 EXPORT
		operator = type( _
			a.x * k, _
			a.y * k, _
			a.z * k _
		)
	end operator

	'':::::
	public operator * ( byval k as real, byref b as const vector3 ) as vector3 EXPORT
		operator = type( _
			k * b.x, _
			k * b.y, _
			k * b.z _
		)
	end operator

	'':::::
	public operator / ( byref a as const vector3, byval k as real ) as vector3 EXPORT
		operator = type( _
			a.x / k, _
			a.y / k, _
			a.z / k _
		)
	end operator

	'':::::
	public operator / ( byref a as vector3, byval k as real ) as vector3 EXPORT
		operator = type( _
			a.x / k, _
			a.y / k, _
			a.z / k _
		)
	end operator

	'':::::
	public operator * ( byref a as const vector3, byref b as const vector3 ) as real EXPORT
		operator = a.x * b.x + a.y * b.y + a.z * b.z
	end operator

	'':::::
	public operator * ( byref a as vector3, byref b as vector3 ) as real EXPORT
		operator = a.x * b.x + a.y * b.y + a.z * b.z
	end operator

	'':::::
	public function vector3.scale( byref b as const vector3 ) as vector3 EXPORT
		function = type( _
			x * b.x, _
			y * b.y, _
			z * b.z _
		)
	end function

	'':::::
	public function vector3.scale( byval k as real ) as vector3 EXPORT
		function = type( _
			x * k, _
			y * k, _
			z * k _
		)
	end function

end namespace
