#include once "vector2.bi"

namespace vectors

	'':::::
	public sub vector2.set( byval _x as real, byval _y as real ) EXPORT
		x = _x
		y = _y
	end sub

	'':::::
	public operator vector2.let ( byref b as vector2 ) EXPORT
		with b
			x = .x
			y = .y
		end with
	end operator

	'':::::
	public operator vector2.-= ( byref b as vector2 ) EXPORT
		with b
			x -= .x
			y -= .y
		end with
	end operator

	'':::::
	public operator vector2.+= ( byref b as vector2 ) EXPORT
		with b
			x += .x
			y += .y
		end with
	end operator

	'':::::
	public operator vector2.*= ( byval k as real ) EXPORT
		x *= k
		y *= k
	end operator

	'':::::
	public operator vector2./= ( byval k as real ) EXPORT
		x /= k
		y /= k
	end operator

	'':::::
	public function vector2.magnitude() as real	EXPORT
		function = sqr( x * x + y * y )
	end function

	'':::::
	public function vector2.magnitude2() as real EXPORT
		function = x * x + y * y
	end function

	'':::::
	public function vector2.distance( byref b as vector2 ) as real EXPORT	
		function = sqr( (b.x-x)*(b.x-x) + (b.y-y)*(b.y-y) )
	end function

	'':::::
	public function vector2.distance2( byref b as vector2 ) as real	EXPORT
		function = (b.x-x)*(b.x-x) + (b.y-y)*(b.y-y)
	end function

	'':::::
	public function vector2.unit() as vector2 EXPORT
		dim ret as vector2 = this
		ret.normalize
		function = ret
	end function

	'':::::
	public sub vector2.normalize() EXPORT
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
		x = -x
		y = -y
	end sub

	'':::::
	public sub vector2.selfop_zero() EXPORT
		x = 0
		y = 0
	end sub

	'':::::
	public operator vector2.cast() as string EXPORT
		operator = "(" & x & ", " & y & ")"
	end operator

	'':::::
	public function vector2.dot( byref b as vector2 ) as real EXPORT
		function = x * b.x + y * b.y
	end function

	'':::::
	public operator - ( byref b as vector2 ) as vector2 EXPORT
		operator = type( _
			-b.x, _
			-b.y _
		)
	end operator

	'':::::
	public operator - ( byref a as vector2, byref b as vector2 ) as vector2 EXPORT
		operator = type( _
			a.x - b.x, _
			a.y - b.y _
		)
	end operator

	'':::::
	public operator + ( byref a as vector2, byref b as vector2 ) as vector2 EXPORT
		operator = type( _
			a.x + b.x, _
			a.y + b.y _
		)
	end operator

	''::::: 
	public operator * ( byref a as vector2, byval k as real ) as vector2 EXPORT
		operator = type( _
			a.x * k, _
			a.y * k _
		)
	end operator

	'':::::
	public operator * ( byval k as real, byref b as vector2 ) as vector2 EXPORT
		operator = type( _
			k * b.x, _
			k * b.y _
		)
	end operator

	'':::::
	public operator / ( byref a as vector2, byval k as real ) as vector2 EXPORT
		operator = type( _
			a.x / k, _
			a.y / k _
		)
	end operator

	'':::::
	public operator * ( byref a as vector2, byref b as vector2 ) as real EXPORT
		operator = a.x * b.x + a.y * b.y
	end operator

end namespace
