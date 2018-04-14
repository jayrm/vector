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
				byval _left as real, _
				byval _right as real, _
				byval _bottom as real, _
				byval _top as real _
			)

		declare sub LoadDisplayOrtho()

		declare function GetDisplayWidth() as real
		declare function GetDisplayHeight() as real

		declare sub SetWorldOrtho _
			( _
				byval _left as real, _
				byval _right as real, _
				byval _bottom as real, _
				byval _top as real _
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
				byval fov as real, _
				byval aspect as real, _
				byval znear as real, _
				byval zfar as real _
			)

		declare sub LoadPerspective()

		declare sub SaveView()

		declare sub SetCamera _
			( _
				byref p as vector3, _
				byref v as vector3, _
				byref u as vector3 _
			)

		declare function SetMode _
			( _
				byval w as integer, _
				byval h as integer, _
				byval b as integer _
			) as integer

		declare sub Flip()

		declare sub BeginFrame()
		declare sub EndFrame()

		declare sub DisplayOrtho()
		declare sub WorldOrtho()
		declare sub Perspective()

		declare function MapDisplayWtoWorldW( byval w as real ) as real
		declare function MapDisplayHtoWorldH( byval h as real ) as real
		declare function MapWorldWtoDisplayW( byval w as real ) as real
		declare function MapWorldHtoDisplayH( byval h as real ) as real

		declare function MapDisplayXtoWorldX( byval x as real ) as real
		declare function MapDisplayYtoWorldY( byval y as real ) as real
		declare function MapWorldXtoDisplayX( byval x as real ) as real
		declare function MapWorldYtoDisplayY( byval y as real ) as real

		declare function MapDisplayXYtoWorldXY( a as VECTOR2 ) as VECTOR2
		declare function MapWorldXYtoDisplayXY( a as VECTOR2 ) as VECTOR2

		declare function GetPickVector _
			( _
				byval x as single, _
				byval y as single _
			) as vector3

end type

#endif
