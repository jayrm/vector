''	vector - geometric vector library
''	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)

#include once "vector2.bi"
#include once "vector2_aabb.bi"

'' ------------------------------------
'' VECTOR2_AABB
'' ------------------------------------

	/'
      W---X
      |          Dx---------- 
	  |          Ax----
      Y               Cx-----
	   	Dy Ay    I-------------------------+
		 |  |    |                         |
		 |  |    |                         |
         |  | Cy |    B-----------+        |
         |     | |    |           |        |
         |     | |    |           |        |
         |     | |    |     P     |        |
                 |    |           |        |
                 |    |           |        |
                 |    +-----------+        |
	  		     |                         |
			     |                         |
			     |                         |
			     |                         |
			     |                         |
			     +-------------------------+

	M = size of image (computed from image data)
	S = size of bounding box (computed from image data)
	A = offset from image origin to bounding box origin (computed from image)
	C = offset from bounding box origin to bounding box center (C = 0.5 * S)
	D = offset from image origin to bounding box center (D = A + C)

	W = screen origin (0,0)
	P = position of object on the screen (from game state)
	B = position of bounding box on screen (B = Q - C) or (B = Q - D + A)
	I = position of image on screen (I = Q - D) or (I = Q - C - A)

	'/

namespace vectors

	''
	public constructor AABB()
		m.selfop_zero()
		s.selfop_zero()
		a.selfop_zero()
		c.selfop_zero()
		d.selfop_zero()
	end constructor

	''
	destructor AABB()
	end destructor

	''
	public sub AABB.SetFromImage( byval img as fb.image ptr )

		dim as integer w, h, x, y, x1, y1, x2, y2

		m.selfop_zero()
		s.selfop_zero()
		a.selfop_zero()
		c.selfop_zero()
		d.selfop_zero()

		ImageInfo img, w, h

		x1 = 0  : y1 = 0
		x2 = w-1: y2 = h-1

		'' trim right
		while( x2 >= x1 )
			for y = y1 to y2
				if( point( x2, y, img ) ) then exit while
			next
			x2 -= 1
		wend

		'' empty?
		if( x2 < x1 ) then
			exit sub
		end if

		'' trim bottom
		while( y2 >= y1 )
			for x = x1 to x2
				if( point( x, y2, img ) ) then exit while
			next
			y2 -= 1
		wend

		'' trim left
		while( x1 < x2 )
			for y as integer = y1 to y2
				if( point( x1, y, img ) ) then exit while
			next
			x1 += 1
		wend

		'' trim top
		while( y1 < y2 )
			for x as integer = x1 to x2
				if( point( x, y1, img ) ) then exit while
			next
			y1 += 1
		wend
			
		'' size of image
		m.x = w
		m.y = h

		'' size of bounding box
		s.x = x2 - x1 + 1
		s.y = y2 - y1 + 1

		'' offset from image origin to bounding box origin
		a.x = x1
		a.y = y1

		'' offset from bounding box origin to bounding box center
		c = s * 0.5

		'' offset from image origin to bounding box center
		d = a + c

	end sub


	/'
		S --------------- 
		 C-------
		 |+-------------+
		 ||             |
		 || testp       |
		 ||             |
		 ||     p       |
		  |             |
		  |             |
		  |             |
		  +-------------+



	'/

	''
	public function AABB.PointCollision _
		( _
			byref this_pnt as const vector2, _
			byref other_pnt as const vector2 _
		) as boolean

		function = false

		dim byref this_box as AABB = this

		if( other_pnt.x >= this_pnt.x - this_box.c.x ) then
			if( other_pnt.x <= this_pnt.x - this_box.c.x + this_box.s.x ) then
				if( other_pnt.y >= this_pnt.y - this_box.c.y ) then
					if( other_pnt.y <= this_pnt.y - this_box.c.y + this_box.s.y ) then
						function = true
					end if
				end if
			end if
		end if

	end function

	''
	public function AABB.AABBCollision _
		( _
			byref this_pnt as const vector2, _
			byref other_box as const AABB, _
			byref other_pnt as const vector2 _
		) as boolean

		function = false

		dim byref this_box as AABB = this

		dim a1 as vector2 = this_pnt - this_box.c
		dim a2 as vector2 = a1 + this_box.s
		dim b1 as vector2 = other_pnt - other_box.c
		dim b2 as vector2 = b1 + other_box.s

		if( b1.x <= a2.x ) then
			if( b2.x >= a1.x ) then
				if( b1.y <= a2.y ) then
					if( b2.y >= a1.y ) then
						function = true
					end if
				end if
			end if
		end if

	end function

end namespace
