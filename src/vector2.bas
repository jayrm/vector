#include "vector2.bi"

namespace vectors2

	'':::::
	/'
	public operator let ( byref lhs as vector, byval rhs as real )

		lhs.x = rhs
		lhs.y = rhs
				
	end operator
	'/

	'':::::
	public operator cast ( byval lhs as vector ) as string

		return( "[" & lhs.x & "," & lhs.y & "]" )

	end operator

	'':::::
	public operator += ( byref lhs as vector, byval rhs as vector )

		lhs.x += rhs.x
		lhs.y += rhs.y

	end operator

	'':::::
	public operator + ( byval lhs as vector, byval rhs as vector ) as vector

		return type<vectors2.vector>( _
			lhs.x + rhs.x, lhs.y + rhs.y )

	end operator

	'':::::
	public operator - ( byval lhs as vector, byval rhs as vector ) as vector

		return type<vector>( _
			lhs.x - rhs.x, lhs.y - rhs.y _
		)

	end operator

	'':::::
	public operator * ( byval lhs as vector, byval rhs as real ) as vector

		return type<vector>( _
			lhs.x * rhs, lhs.y * rhs _
		)

	end operator

	'':::::
	public operator - ( byval lhs as real, byval rhs as vector ) as vector

		return type<vector>( _
			lhs * rhs.x, lhs * rhs.y _
		)

	end operator


end namespace