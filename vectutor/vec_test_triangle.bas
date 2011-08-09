'' ========================================================
'' vec_test_triangle.bas
'' ========================================================

#include once "ogl_stuff.bi"
#include once "ogl_draw.bi"
#include once "ogl_font.bi"
#include once "vector2.bi"
#include once "vector2_array.bi"
#include once "vec_test.bi"
#include once "vec_test_color.bi"

'' --------------------------------------------------------
dim shared points as VECTOR2_ARRAY

private sub draw_incircle( ctx as TEST_CTX )

	if points.count < 3 then
		exit sub
	end if

	SetColor( COLOR_GREEN, 0.75 )

	'' p1, p2, p3 are the verticies of the triangle
	dim p1 as VECTOR2 = points.v(1)
	dim p2 as VECTOR2 = points.v(2)
	dim p3 as VECTOR2 = points.v(3)

	'' s1, s2, s3 are the lengths of the sides
	dim s1 as REAL = (p3 - p2).magnitude
	dim s2 as REAL = (p1 - p3).magnitude
	dim s3 as REAL = (p2 - p1).magnitude
	
	'' compute the center of the incircle
	dim center as VECTOR2 = type( s1 * p1 + s2 * p2 + s3 * p3 ) / (s1 + s2 + s3 ) 

	'' compute the radius of the incircle based on area of the triangle 
	dim s as REAL = ( s1 + s2 + s3 ) / 2
	dim A as REAL = sqr( s * (s - s1) * (s - s2) * (s - s3) )
	dim r as REAL = A / s 

	SetColor( COLOR_GREEN, 0.5 )
	draw_point( center )
	draw_circle( center, r )

end sub

private sub draw_circumcircle( ctx as TEST_CTX )

	if points.count < 3 then
		exit sub
	end if

	SetColor( COLOR_RED, 0.5 )

	'' p1, p2, p3 are the verticies of the triangle
	dim p1 as VECTOR2 = points.v(1)
	dim p2 as VECTOR2 = points.v(2)
	dim p3 as VECTOR2 = points.v(3)

	''D = 2(Ax(By-Cy)+Bx(Cy-Ay)+Cx(Ay-By))
	''CenterX = ((Ay*Ay + Ax*Ax)(By - Cy) + (By*By+Bx*Bx)(Cy-Ay)+(Cy*Cy+Cx*Cx)(Ay-By))/D
	''CenterY = ((Ay*Ay + Ax*Ax)(Cx - Bx) + (By*By+Bx*Bx)(Ax-Cx)+(Cy*Cy+Cx*Cx)(Bx-Ax))/D
	
	dim d as REAL = 2 * (p1.x*(p2.y-p3.y) + p2.x*(p3.y-p1.y) + p3.x*(p1.y-p2.y))
	
	dim center as VECTOR2 = type( _
			( (p1.y*p1.y+p1.x*p1.x)*(p2.y-p3.y) _
			+ (p2.y*p2.y+p2.x*p2.x)*(p3.y-p1.y) _
			+ (p3.y*p3.y+p3.x*p3.x)*(p1.y-p2.y)) / d, _
			( (p1.y*p1.y+p1.x*p1.x)*(p3.x-p2.x) _
			+ (p2.y*p2.y+p2.x*p2.x)*(p1.x-p3.x) _
			+ (p3.y*p3.y+p3.x*p3.x)*(p2.x-p1.x)) / d _
		)


	'' s1, s2, s3 are the lengths of the sides
	dim s1 as REAL = type(p3 - p2).magnitude
	dim s2 as REAL = type(p1 - p3).magnitude
	dim s3 as REAL = type(p2 - p1).magnitude

	'' compute the radius of the circumcircle based on area of the triangle
	dim s as REAL = ( s1 + s2 + s3 ) / 2
	dim A as REAL = sqr( s * (s - s1) * (s - s2) * (s - s3) )
	dim r as REAL = s1 * s2 * s3 / A / 4

	SetColor( COLOR_RED, 0.5 )
	draw_point( center )
	
	draw_circle( center, r )

end sub

private sub draw_scene( ctx as TEST_CTX )

	SetColor( COLOR_POINTS, 0.5 )
	if points.count >= 2 then draw_line( points.v(1), points.v(2) )	
	if points.count >= 3 then draw_line( points.v(2), points.v(3) )	
	if points.count >= 3 then draw_line( points.v(3), points.v(1) )	

	if( points.count >= 3 ) then
		draw_incircle( ctx )
		draw_circumcircle( ctx )
	end if

	'' Draw all the points
	SetColor( COLOR_POINTS )
	for i as integer = 1 to points.count
		draw_point( points.v(i) )
	next

end sub

function vec_test_triangle( m as integer = 0 ) as TEST_CTX

	dim ctx as TEST_CTX

	ctx.Title = "TRIANGLE"
	ctx.DrawScene = procptr( draw_scene )
	ctx.points = @points
	ctx.MaxPoints = 3
	
	function = ctx
	
end function
