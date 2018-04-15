#ifndef __VECTOR2_AABB_BI_INCLUDE__
#define __VECTOR2_AABB_BI_INCLUDE__ 1

	#include once "fbgfx.bi"
	#include once "vector2.bi"

	namespace vectors

		''
		type AABB

			m as vector2	'' size of image
			s as vector2	'' size of the bounding box
			a as vector2	'' offset from image origin to bounding box origin
			c as vector2	'' offset from bounding box origin to bounding box center (C = 0.5 * S)
			d as vector2	'' offset from image origin to bounding box center (D = A + C)

			declare constructor()
			declare destructor()
			declare sub SetPosition()
			declare sub SetSize()
			declare sub SetFromImage( byval img as fb.image ptr )

			declare const function PointCollision _
				( _
					byref this_pnt as const vector2, _
					byref other_pnt as const vector2 _
				) as boolean
			
			declare const function AABBCollision _
				( _
					byref this_pnt as const vector2, _
					byref other_box as const AABB, _
					byref other_pnt as const vector2 _
				) as boolean

		end type

	end namespace

#endif
