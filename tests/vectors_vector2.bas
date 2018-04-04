#include once "fbcunit.bi"
#include once "vector2.bi"

using vectors

/'
	See:
		inc/vector2.bi
		src/vector2.bas
		doc/vectors_vector2.txt

'/

SUITE( vectors_vector2 )

	#include once "fbcunit_local.bi"

	#macro check_exact( x1, y1, x2, y2 )
		CU_ASSERT_REAL_EXACT( x1, x2 )
		CU_ASSERT_REAL_EXACT( y1, y2 )
	#endmacro

	#macro check_approx( x1, y1, x2, y2 )
		CU_ASSERT_REAL_APPROX( x1, x2, 1 )
		CU_ASSERT_REAL_APPROX( y1, y2, 1 )
	#endmacro

	TEST( header )
		#if defined( __VECTORS_VECTOR2_BI_INCLUDE__ )
			CU_PASS()
		#else
			CU_FAIL()
		#endif
	END_TEST

	TEST( types )

		dim v as vector2

		check_type( v, vector2 )
		check_type( v.x, real )
		check_type( v.y, real )
		check_type( v.e(0), real )
		check_type( v.e(1), real )

	END_TEST

	TEST( ctor )
		dim a as vector2 = (1, 2)

		CU_ASSERT_REAL_EXACT( a.x, 1 )
		CU_ASSERT_REAL_EXACT( a.y, 2 )

		dim b as vector2

		CU_ASSERT_REAL_EXACT( b.x, 0 )
		CU_ASSERT_REAL_EXACT( b.y, 0 )

		dim c as const vector2 = (1, 2)
		CU_ASSERT_REAL_EXACT( c.x, 1 )
		CU_ASSERT_REAL_EXACT( c.y, 2 )

	END_TEST

	TEST( add_bop )

		dim a as vector2, b as vector2, c as vector2

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2

						a.set( x1, y1 )
						b.set( x2, y2 )
						c.set( 0, 0 )

						c = a + b
						check_exact( c.x, c.y, x1+x2, y1+y2 )

						dim c1 as const vector2 = ( x1, y1 )
						dim c2 as const vector2 = ( x2, y2 )
						
						c = c1 + b
						check_exact( c.x, c.y, x1+x2, y1+y2 )

						c = a + c2
						check_exact( c.x, c.y, x1+x2, y1+y2 )

						c = c1 + c2
						check_exact( c.x, c.y, x1+x2, y1+y2 )

					next
				next
			next
		next

	END_TEST

	TEST( add_self )
		dim a as vector2, b as vector2
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						a.set( x1, y1 )
						b.set( x2, y2 )
			
						a += b

						check_exact( a.x, a.y, x1+x2, y1+y2 )
						check_exact( b.x, b.y, x2, y2 )

						a.set( x1, y1 )
						dim c2 as const vector2 = ( x2, y2 )
						a += c2
						check_exact( a.x, a.y, x1+x2, y1+y2 )

					next
				next
			next
		next
	END_TEST

	TEST( sub_bop )

		dim a as vector2, b as vector2, c as vector2

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2

						a.set( x1, y1 )
						b.set( x2, y2 )
						c.set( 0, 0 )

						c = a - b
						check_exact( c.x, c.y, x1-x2, y1-y2 )

						dim c1 as const vector2 = ( x1, y1 )
						dim c2 as const vector2 = ( x2, y2 )
						
						c = c1 - b
						check_exact( c.x, c.y, x1-x2, y1-y2 )

						c = a - c2
						check_exact( c.x, c.y, x1-x2, y1-y2 )

						c = c1 - c2
						check_exact( c.x, c.y, x1-x2, y1-y2 )

					next
				next
			next
		next

	END_TEST

	TEST( sub_self )
		dim a as vector2, b as vector2
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						a.set( x1, y1 )
						b.set( x2, y2 )
			
						a -= b

						check_exact( a.x, a.y, x1-x2, y1-y2 )
						check_exact( b.x, b.y, x2, y2 )

						a.set( x1, y1 )
						dim c2 as const vector2 = ( x2, y2 )
						a -= c2
						check_exact( a.x, a.y, x1-x2, y1-y2 )

					next
				next
			next
		next
	END_TEST

	TEST( mul_scalar )

		dim a as vector2, c as vector2

		for k as real = -2 to 2
			for y as real = -2 to 2
				for x as real = -2 to 2
					
					a.set( x, y )

					c.set( 0,0 )
					c = k * a
					check_exact( c.x, c.y, a.x * k, a.y * k )

					c.set( 0,0 )
					c = a * k
					check_exact( c.x, c.y, a.x * k, a.y * k )

					dim c1 as const vector2 = ( x, y )

					c.set( 0, 0 )
					c = c1 * k
					check_exact( c.x, c.y, a.x * k, a.y * k )

					c.set( 0, 0 )
					c = k * c1
					check_exact( c.x, c.y, a.x * k, a.y * k )

				next
			next
		next
		
	END_TEST

	TEST( mul_self )

		dim a as vector2

		for k as real = -2 to 2
			for y as real = -2 to 2
				for x as real = -2 to 2

					a.set( x, y )
					a *= k
					check_exact( a.x, a.y, x * k, y * k )

				next
			next
		next
		
	END_TEST

	TEST( div_scalar )

		dim a as vector2, c as vector2

		for k as real = -2 to 2
			for y as real = -2 to 2
				for x as real = -2 to 2
					
					a.set( x, y )

					c.set( 0,0 )
					c = a / k
					check_exact( c.x, c.y, a.x / k, a.y / k )

					dim c1 as const vector2 = ( x, y )

					c.set( 0, 0 )
					c = c1 / k
					check_exact( c.x, c.y, a.x / k, a.y / k )

				next
			next
		next
		
	END_TEST

	TEST( div_self )

		dim a as vector2

		for k as real = -2 to 2
			for y as real = -2 to 2
				for x as real = -2 to 2

					a.set( x, y )
					a /= k
					check_exact( a.x, a.y, x / k, y / k )

				next
			next
		next
		
	END_TEST

	TEST( magnitude )
		
		dim a as vector2
		dim d1 as real, d2 as real

		for y as real = -3 to 3
			for x as real = -3 to 3

				a.set( x, y )

				d1 = a.magnitude
				d2 = sqr( x^2 + y^2 )

				CU_ASSERT_REAL_EXACT( d1, d2 )

			next
		next

	END_TEST

	TEST( magnitude2 )
		
		dim a as vector2
		dim d1 as real, d2 as real

		for y as real = -3 to 3
			for x as real = -3 to 3

				a.set( x, y )

				d1 = a.magnitude2
				d2 = x^2 + y^2

				CU_ASSERT_REAL_EXACT( d1, d2 )

			next
		next

	END_TEST

	TEST( distance )

		dim a as vector2, b as vector2
		dim d1 as real, d2 as real
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						a.set( x1, y1 )
						b.set( x2, y2 )

						d1 = a.distance( b )
						d2 = sqr((b.x-a.x)^2 + (b.y-a.y)^2)

						CU_ASSERT_REAL_EXACT( d1, d2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( distance2 )

		dim a as vector2, b as vector2
		dim d1 as real, d2 as real
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						a.set( x1, y1 )
						b.set( x2, y2 )

						d1 = a.distance2( b )
						d2 = (b.x-a.x)^2 + (b.y-a.y)^2

						CU_ASSERT_REAL_EXACT( d1, d2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( unit )
		
		const e = test_epsilon_real

		dim a as vector2, r as vector2

		check_exact( a.x, a.y, 0, 0 )
		r = a.unit
		check_exact( r.x, r.y, 0, 0 )

		for y as real = -2 to 2
			for x as real = -2 to 2

				a.set( x, y )
				r = a.unit

				CU_ASSERT_REAL_EXACT( sgn( x ), sgn( r.x ) )
				CU_ASSERT_REAL_EXACT( sgn( y ), sgn( r.y ) )

				if( x = 0 and y = 0 ) then
					CU_ASSERT_REAL_EXACT( r.x, 0 )
					CU_ASSERT_REAL_EXACT( r.y, 0 )
				else
					CU_ASSERT_REAL_EQUAL( sqr( r.x * r.x + r.y * r.y ), 1, e )
				end if

			next
		next

	END_TEST

	TEST( normalize )
		
		const e = test_epsilon_real

		dim a as vector2

		check_exact( a.x, a.y, 0, 0 )
		a.normalize
		check_exact( a.x, a.y, 0, 0 )

		for y as real = -2 to 2
			for x as real = -2 to 2

				a.set( x, y )
				a.normalize

				CU_ASSERT_REAL_EXACT( sgn( x ), sgn( a.x ) )
				CU_ASSERT_REAL_EXACT( sgn( y ), sgn( a.y ) )

				if( x = 0 and y = 0 ) then
					CU_ASSERT_REAL_EXACT( a.x, 0 )
					CU_ASSERT_REAL_EXACT( a.y, 0 )
				else
					CU_ASSERT_REAL_EQUAL( sqr( a.x * a.x + a.y * a.y ), 1, e )
				end if

			next
		next

	END_TEST

	TEST( neg_self )
		
		dim a as vector2
		
		for y as real = -2 to 2
			for x as real = -2 to 2
				a.set( x, y )
				a.selfop_neg
				check_exact( a.x, a.y, -x, -y )
			next
		next
	
	END_TEST

	TEST( neg_uop )

		dim a as vector2, b as vector2
		check_exact( a.x, a.y, 0, 0 )

		for x as real = -2 to 2
			for y as real = -2 to 2
				a.set( x, y )
				b.selfop_zero
				b = -a
				check_exact( b.x, b.y, -x, -y )

				dim c as const vector2 = -a
				check_exact( c.x, c.y, -x, -y )
			next
		next
		
	END_TEST

	TEST( zero_self )
		
		dim a as vector2
		check_exact( a.x, a.y, 0, 0 )

		a.x = 1
		a.y = 2
		check_exact( a.x, a.y, 1, 2 )

		a.selfop_zero
		check_exact( a.x, a.y, 0, 0 )

	END_TEST

	TEST( dot_product )

		dim a as vector2, b as vector2
		dim d1 as real, d2 as real
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for x2 as real = -2 to 2
					for y2 as real = -2 to 2
								
						a.set( x1, y1 )
						b.set( x2, y2 )

						d1 = a * b
						CU_ASSERT_REAL_EXACT( d1, a.x * b.x + a.y * b.y )

						d2 = a.dot( b )
						CU_ASSERT_REAL_EXACT( d2, a.x * b.x + a.y * b.y )

						CU_ASSERT_REAL_EXACT( d1, d2 )

						dim c1 as const vector2 = ( x1, y1 )
						dim c2 as const vector2 = ( x2, y2 )

						d2 = a * c2
						CU_ASSERT_REAL_EXACT( d1, d2 )

						d2 = c1 * b
						CU_ASSERT_REAL_EXACT( d1, d2 )

						d2 = c1 * c2
						CU_ASSERT_REAL_EXACT( d1, d2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( cross_product )
		
		for angle1 as real = -180 to 179 step 30
			for angle2 as real = -180 to 179 step 30
				dim a as vector2 = ( cos(DEGTORAD(angle1)), sin(DEGTORAD(angle1)) )
				dim b as vector2 = ( cos(DEGTORAD(angle2)), sin(DEGTORAD(angle2)) )

				dim r as real = a.cross(b)

				'' in 2D space, a.cross(b) should have the properties
				'' 1) if sign of cross product is negative, then smallest
				''    angle to get from a to b is counter-clockwise
				'' 2) if sign of cross product is positive, then smallest
				''    angle to get from a to b is clockwise
				'' 3) equal to the the area of the parallelogram formed by
				''    vectors a & b

				'' find the smaller angle
				dim angle as real = angle2 - angle1
				if( angle > 180 ) then
					angle -= 360
				elseif( angle < -180 ) then
					angle += 360
				end if

				'' if a.cross(b)=0 then vectors are parallel
				if( abs(r) < test_epsilon_real ) then
					if( angle > test_epsilon_real ) then
						angle -= 180
					elseif( angle < test_epsilon_real ) then
						angle += 180
					end if
					CU_ASSERT_REAL_EQUAL( r, 0, test_epsilon_real )
				else
					'' sign of angle should equal sign of a.cross(b)
					CU_ASSERT_EQUAL( sgn(angle), sgn(r) )
				end if
				
				'' using Heron's formula, find the area of the triangle
				dim s1 as real = a.magnitude
				dim s2 as real = b.magnitude
				dim cc as vector2 = b - a
				dim s3 as real = cc.magnitude
				dim s as real = ( s1 + s2 + s3 ) / 2
				dim area as real = sqr( s * ( s - s1 ) * ( s - s2 ) * ( s - s3  ) )

				'' compare the magnitude of the cross product with area of parallelogram
				CU_ASSERT_REAL_EQUAL( area, abs( r ) / 2, test_epsilon_real )

			next
		next

	END_TEST

	TEST( perp_ )
		
		for m as real = -2 to 2 step 0.5
			for angle as real = 0 to 359 step 30

				' a is a vector @ angle degrees
				' b is a vector @ angle+90 degress
				' c is the perpendicular vector of a
				
				dim a as vector2 = ( cos(DEGTORAD(angle)), sin(DEGTORAD(angle)) )
				dim b as vector2 = ( cos(DEGTORAD(angle+90)), sin(DEGTORAD(angle+90)) )
				dim c as vector2 = a.perp

				'' test b & c are nearly same
				CU_ASSERT_REAL_EQUAL( b.x, c.x, test_epsilon_real )
				CU_ASSERT_REAL_EQUAL( b.y, c.y, test_epsilon_real )
			next
		next

	END_TEST

	TEST( equal )

		dim e(0 to 3) as real => { 0, -5, 7 }
		dim a as vector2 = ( e(1), e(2) )

		check_exact( a.x, a.y, -5, 7 )

		'' iterate through every possible vector,
		'' only one should match

		for i as integer = 0 to 3 ^ 2 - 1
			
			'' decode integer i as base 3 to select components

			dim i1 as integer = i mod 3
			dim i2 as integer = (i \ 3) mod 3

			dim b as vector2 = ( e(i1), e(i2) )
			dim t as boolean = a = b

			'' test if i = 21 (in base 3)
			if( i = 1 + 3 * 2 ) then
				CU_ASSERT( t )
				CU_ASSERT_EQUAL( a, b )
			else
				dim t as boolean = a = b
				CU_ASSERT( not t )
				CU_ASSERT_NOT_EQUAL( a, b )
			end if

		next

	END_TEST

	TEST( not_equal )

		dim e(0 to 3) as real => { 0, -5, 7 }
		dim a as vector2 = ( e(1), e(2) )

		check_exact( a.x, a.y, -5, 7 )

		'' iterate through every possible vector,
		'' all but one is not equal

		for i as integer = 0 to 3 ^ 2 - 1
			
			'' decode integer i as base 4 to select components

			dim i1 as integer = i mod 3
			dim i2 as integer = (i \ 3) mod 3

			dim b as vector2 = ( e(i1), e(i2) )
			dim t as boolean = a <> b

			'' test if i = 21 (in base 3)
			if( i = 1 + 3 * 2 ) then
				CU_ASSERT( not t )
				CU_ASSERT_EQUAL( a, b )
			else
				CU_ASSERT( t )
				CU_ASSERT_NOT_EQUAL( a, b )
			end if

		next

	END_TEST

	TEST( isZero_ )

		dim a as vector2
		CU_ASSERT( a.IsZero )

		dim b as vector2 = (0, 0)
		CU_ASSERT( b.IsZero )

		dim c as vector2 = (1, 2)
		c.set( 0, 0 )
		CU_ASSERT( c.IsZero )

		'' only first iteration isZero
		dim bFirst as boolean = true
		for x as real = 0 to 1
			for y as real = 0 to 1
				dim d as vector2 = (x, y)
				CU_ASSERT_EQUAL( d.isZero, bFirst )
				bFirst = false
			next
		next

	END_TEST

	TEST( operator_args )
		
		dim a as vector2 = (1, 2)
		dim b as vector2 = (5, 7)
		dim c as vector2

		dim t as boolean

		dim F as const vector2 = a
		dim G as const vector2 = b

		dim s as single = 2
		dim d as single = 2
		dim i as integer = 2

		'' operator + (vector2, vector2) as vector2
		c = a + b: check_exact( c.x, c.y, 6, 9 )
		c = a + G: check_exact( c.x, c.y, 6, 9 )
		c = F + b: check_exact( c.x, c.y, 6, 9 )
		c = F + G: check_exact( c.x, c.y, 6, 9 )

		'' operator - (vector2, vector2) as vector2
		c = a - b: check_exact( c.x, c.y, -4, -5 )
		c = a - G: check_exact( c.x, c.y, -4, -5 )
		c = F - b: check_exact( c.x, c.y, -4, -5 )
		c = F - G: check_exact( c.x, c.y, -4, -5 )

		'' operator * (vector2, dtype) as vector2
		'' operator * (dtype, vector2) as vector2
		c = a * s: check_exact( c.x, c.y, 2, 4 )
		c = a * d: check_exact( c.x, c.y, 2, 4 )
		c = a * i: check_exact( c.x, c.y, 2, 4 )
		c = s * a: check_exact( c.x, c.y, 2, 4 )
		c = d * a: check_exact( c.x, c.y, 2, 4 )
		c = i * a: check_exact( c.x, c.y, 2, 4 )
		c = F * s: check_exact( c.x, c.y, 2, 4 )
		c = F * d: check_exact( c.x, c.y, 2, 4 )
		c = F * i: check_exact( c.x, c.y, 2, 4 )
		c = s * F: check_exact( c.x, c.y, 2, 4 )
		c = d * F: check_exact( c.x, c.y, 2, 4 )
		c = i * F: check_exact( c.x, c.y, 2, 4 )

		'' operator / (vector2, dtype) as vector2
		c = a / s: check_exact( c.x, c.y, 0.5, 1 )
		c = a / d: check_exact( c.x, c.y, 0.5, 1 )
		c = a / i: check_exact( c.x, c.y, 0.5, 1 )
		c = F / s: check_exact( c.x, c.y, 0.5, 1 )
		c = F / d: check_exact( c.x, c.y, 0.5, 1 )
		c = F / i: check_exact( c.x, c.y, 0.5, 1 )

		'' operator * (dtype) as vector2
		c = a: c *= s: check_exact( c.x, c.y, 2, 4 )
		c = a: c *= d: check_exact( c.x, c.y, 2, 4 )
		c = a: c *= i: check_exact( c.x, c.y, 2, 4 )

		'' operator / (dtype) as vector2
		c = a: c /= s: check_exact( c.x, c.y, 0.5, 1 )
		c = a: c /= d: check_exact( c.x, c.y, 0.5, 1 )
		c = a: c /= i: check_exact( c.x, c.y, 0.5, 1 )

		'' operator - (vector2) as vector2
		c = -a: check_exact( c.x, c.y, -1, -2 )
		c = -F: check_exact( c.x, c.y, -1, -2 )

		'' operator = (vector2, vector2) as boolean
		t = a = a : CU_ASSERT( t )
		t = a = F : CU_ASSERT( t )
		t = G = b : CU_ASSERT( t )
		t = a = b : CU_ASSERT( not t )
		t = F = b : CU_ASSERT( not t )
		t = a = G : CU_ASSERT( not t )

		'' operator <> (vector2, vector2) as boolean
		t = a <> a : CU_ASSERT( not t )
		t = a <> F : CU_ASSERT( not t )
		t = G <> b : CU_ASSERT( not t )
		t = a <> b : CU_ASSERT( t )
		t = F <> b : CU_ASSERT( t )
		t = a <> G : CU_ASSERT( t )

	END_TEST


END_SUITE
