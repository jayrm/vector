#ifndef __VECTORS_CAMERA_BI_INCLUDE__
#define __VECTORS_CAMERA_BI_INCLUDE__ 1

	#include once "vector3.bi"

	namespace vectors

		type camera3
			p as vector3			'' position
			v as vector3			'' look direction unit vector
			r as vector3			'' right unit vector ( in XY plane )
			f as vector3			'' forward unit vector ( in XY plane )
			u as vector3			'' up unit vector ( relative and perp. to v )
			union
				a as vector3        '' angles
									'' x = pitch ( relative to XY plane )
									'' y = roll
									'' z = heading ( in XY plane )
				type
					pitch as real
					roll as real
					heading as real
				end type
			end union

			declare sub MoveDelta( byref d as const vector3 )

			declare sub MoveForward( byval d as const real )
			declare sub MoveBackward( byval d as const real )
			declare sub MoveRight( byval d as const real )
			declare sub MoveLeft( byval d as const real )
			declare sub MoveUp( byval d as const real )
			declare sub MoveDown( byval d as const real ) 

			declare sub TurnLeft( byval d as const real )
			declare sub TurnRight( byval d as const real )
			declare sub PitchUp( byval d as const real )
			declare sub PitchDown( byval d as const real )

			declare sub refresh ()

		end type

	end namespace

#endif
