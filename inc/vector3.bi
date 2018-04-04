#ifndef __VECTORS_VECTOR3_BI_INCLUDE__
#define __VECTORS_VECTOR3_BI_INCLUDE__ 1

	#include once "vectypes.bi"

	namespace vectors

		type vector3
			union
				type
					x as real
					y as real
					z as real
				end type
				e(0 to 2) as real
			end union

			declare sub set( byval _x as real, byval _y as real, byval _z as real )

			declare operator let ( byref a as const vector3 )
			
			declare operator -= ( byref a as const vector3 )
			declare operator += ( byref a as const vector3 )

			declare operator *= ( byval k as real )
			declare operator /= ( byval k as real )

			declare function magnitude() as real
			declare function magnitude2() as real
			declare function distance( byref b as const vector3 ) as real
			declare function distance2( byref b as const vector3 ) as real

			declare function unit() as vector3
			declare sub normalize()

			declare sub selfop_neg()
			declare sub selfop_zero()

			declare const operator cast() as string

			declare function dot( byref b as const vector3 ) as real
			declare function cross( byref b as const vector3 ) as vector3

			declare function scale( byref b as const vector3 ) as vector3
			declare function scale( byval k as real ) as vector3

			declare function isZero() as boolean

		end type

		'' Negative
		declare operator - ( byref a as const vector3 ) as vector3

		'' Subtract
		declare operator - ( byref a as const vector3, byref b as const vector3 ) as vector3

		'' Add
		declare operator + ( byref a as const vector3, byref b as const vector3 ) as vector3

		'' Multiply (Scale)
		declare operator * ( byref a as const vector3, byval b as real ) as vector3
		declare operator * ( byval a as real, byref b as const vector3 ) as vector3

		'' Divide (Scale)
		declare operator / ( byref a as const vector3, byval b as real ) as vector3

		'' Dot product
		declare operator * ( byref a as const vector3, byref b as const vector3 ) as real

		'' Comparison (exact)
		declare operator = ( byref a as const vector3, byref b as const vector3 ) as boolean
		declare operator <> ( byref a as const vector3, byref b as const vector3 ) as boolean

	end namespace

#endif
