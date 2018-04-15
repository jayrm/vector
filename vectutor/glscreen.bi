#ifndef __GLSCREEN_BI_INCLUDE__
#define __GLSCREEN_BI_INCLUDE__

#include once "refcount.bi"
#include once "vector2.bi"
#include once "vector3.bi"

using vectors

type GLSCREENCTX_ as GLSCREENCTX

type GLSCREEN

	private:
		_ctx as GLSCREENCTX_ ptr

	public:
		DECL_REFCOUNTER( GLSCREEN )

		declare sub SetDisplayOrtho _
			( _
				byval _left as const real, _
				byval _right as const real, _
				byval _bottom as const real, _
				byval _top as const real _
			)

		declare sub LoadDisplayOrtho()

		declare function GetDisplayWidth() as real
		declare function GetDisplayHeight() as real

		declare sub SetWorldOrtho _
			( _
				byval _left as const real, _
				byval _right as const real, _
				byval _bottom as const real, _
				byval _top as const real _
			)

		declare sub LoadWorldOrtho()

		declare function GetWidth() as integer
		declare function GetHeight() as integer
		declare function GetLeft() as real
		declare function GetRight() as real
		declare function GetBottom() as real
		declare function GetTop() as real

		declare sub SetPerspective _
			( _
				byval fov as const real, _
				byval aspect as const real, _
				byval znear as const real, _
				byval zfar as const real _
			)

		declare sub LoadPerspective()

		declare sub SaveView()

		declare sub SetCamera _
			( _
				byref p as const vector3, _
				byref v as const vector3, _
				byref u as const vector3 _
			)

		declare function SetMode _
			( _
				byval w as const integer, _
				byval h as const integer, _
				byval b as const integer _
			) as integer

		declare sub Flip()

		declare sub BeginFrame()
		declare sub EndFrame()

		declare sub DisplayOrtho()
		declare sub WorldOrtho()
		declare sub Perspective()

		declare function MapDisplayWtoWorldW( byval w as const real ) as real
		declare function MapDisplayHtoWorldH( byval h as const real ) as real
		declare function MapWorldWtoDisplayW( byval w as const real ) as real
		declare function MapWorldHtoDisplayH( byval h as const real ) as real

		declare function MapDisplayXtoWorldX( byval x as const real ) as real
		declare function MapDisplayYtoWorldY( byval y as const real ) as real
		declare function MapWorldXtoDisplayX( byval x as const real ) as real
		declare function MapWorldYtoDisplayY( byval y as const real ) as real

		declare function MapDisplayXYtoWorldXY( byref a as const VECTOR2 ) as VECTOR2
		declare function MapWorldXYtoDisplayXY( byref a as const VECTOR2 ) as VECTOR2

		declare function GetPickVector _
			( _
				byval x as const single, _
				byval y as const single _
			) as vector3

end type

#endif
