#ifndef __VECTOR2_BI__
#define __VECTOR2_BI__

namespace vectors2

	type real as single

	type vector
		x as real
		y as real
	end type

	''declare operator let ( byref lhs as vector, byval rhs as real )
	declare operator cast ( byval lhs as vector ) as string
	declare operator + ( byval lhs as vector, byval rhs as vector ) as vector
	declare operator += ( byref lhs as vector, byval rhs as vector )

end namespace

#endif