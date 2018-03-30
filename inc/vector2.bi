#ifndef __VECTORS_VECTOR2_BI_INCLUDE__
#define __VECTORS_VECTOR2_BI_INCLUDE__ 1

	#include once "vectypes.bi"

	namespace vectors

		type vector2
			union
				type
					x as real
					y as real
				end type
				e(0 to 1) as real
			end union

			declare sub set( byval _x as real, byval _y as real )

			declare operator let ( byref a as vector2 )
			
			declare operator -= ( byref a as vector2 )
			declare operator += ( byref a as vector2 )

			declare operator *= ( byval k as real )
			declare operator /= ( byval k as real )

			declare function magnitude() as real
			declare function magnitude2() as real
			declare function distance( byref b as vector2 ) as real
			declare function distance2( byref b as vector2 ) as real

			declare function unit() as vector2
			declare sub normalize()

			declare sub selfop_neg()
			declare sub selfop_zero()

			declare operator cast() as string

			declare function dot( byref b as vector2 ) as real

		end type

		'' Negative
		declare operator - ( byref a as vector2 ) as vector2

		'' Subtract
		declare operator - ( byref a as vector2, byref b as vector2 ) as vector2

		'' Add
		declare operator + ( byref a as vector2, byref b as vector2 ) as vector2

		'' Multiply (Scale)
		declare operator * ( byref a as vector2, byval b as real ) as vector2
		declare operator * ( byval a as real, byref b as vector2 ) as vector2

		'' Divide (Scale)
		declare operator / ( byref a as vector2, byval b as real ) as vector2

		'' Dot product
		declare operator * ( byref a as vector2, byref b as vector2 ) as real

	end namespace

#endif
