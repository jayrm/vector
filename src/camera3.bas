''	vector - geometric vector library
''	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)

#include once "camera3.bi"
#include once "angle.bi"

using angles

namespace vectors

	'':::::
	public sub camera3.MoveDelta( byref delta as vector3 ) EXPORT
		p += delta
	end sub

	'':::::
	public sub camera3.MoveForward( byval d as real ) EXPORT
		p += v * d
	end sub

	'':::::
	public sub camera3.MoveBackward( byval d as real ) EXPORT
		p -= v * d
	end sub

	'':::::
	public sub camera3.MoveRight( byval d as real ) EXPORT
		p += r * d
	end sub

	'':::::
	public sub camera3.MoveLeft( byval d as real ) EXPORT
		p -= r * d
	end sub

	'':::::
	public sub camera3.MoveUp( byval d as real ) EXPORT
		p += u * d
	end sub

	'':::::
	public sub camera3.MoveDown( byval d as real ) EXPORT
		p -= u * d
	end sub

	'':::::
	public sub camera3.TurnLeft( byval d as real ) EXPORT
		heading = FixAngle360( heading + d )
	end sub

	'':::::
	public sub camera3.TurnRight( byval d as real ) EXPORT
		heading = FixAngle360( heading - d )
	end sub

	'':::::
	public sub camera3.PitchUp( byval d as real ) EXPORT
		pitch = FixAngle180( pitch + d )
	end sub

	'':::::
	public sub camera3.PitchDown( byval d as real ) EXPORT
		pitch = FixAngle180( pitch - d )
	end sub

	'':::::
	public sub camera3.refresh () EXPORT
		'' compute new values from v,f,l,u
		'' from heading and pitch

		dim as real cos_heading = any, sin_heading = any
		dim as real cos_pitch = any, sin_pitch = any
		dim as real rad_heading = any, rad_pitch = any

		heading = FixAngle360( heading )
		pitch = FixAngle360( pitch )

		rad_heading = DEGTORAD( heading )
		rad_pitch = DEGTORAD( pitch )
		
		cos_heading = cos(rad_heading)
		sin_heading = sin(rad_heading)
		cos_pitch = cos(rad_pitch)
		sin_pitch = sin(rad_pitch)

	/'	
		'' 0 degrees = NORTH, or Y-world axis
		r.set( cos_heading, -sin_heading, 0 )
		f.set( sin_heading, cos_heading, 0 )
		v.set( cos_pitch * sin_heading, cos_pitch * cos_heading, sin_pitch )
		u.set( -sin_pitch * sin_heading, -sin_pitch * cos_heading, cos_pitch )
	'/
		
		'' 0 degrees = EAST, or X-world axis
		f.set( cos_heading, sin_heading, 0 )
		r.set( -sin_heading, cos_heading, 0 )
		v.set( -cos_pitch * cos_heading, -cos_pitch * sin_heading, sin_pitch )
		u.set( sin_pitch * cos_heading, sin_pitch * sin_heading, cos_pitch )

	end sub

end namespace
