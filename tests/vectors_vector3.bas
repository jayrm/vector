#include once "fbcunit.bi"
#include once "vector3.bi"

using vectors

/'
	See:
		inc/vectypes.bi
		src/vectypes.bas
		inc/vector3.bi
		src/vector3.bas
		doc/vectors_vector3.txt

'/

SUITE( vectors_vector3 )

	#include once "fbcunit_local.bi"

	#macro check_exact( x1, y1, z1, x2, y2, z2 )
		CU_ASSERT_REAL_EXACT( x1, x2 )
		CU_ASSERT_REAL_EXACT( y1, y2 )
		CU_ASSERT_REAL_EXACT( z1, z2 )
	#endmacro

	#macro check_approx( x1, y1, z1, x2, y2, z2 )
		CU_ASSERT_REAL_APPROX( x1, x2, 1 )
		CU_ASSERT_REAL_APPROX( y1, y2, 1 )
		CU_ASSERT_REAL_APPROX( z1, z2, 1 )
	#endmacro

	TEST( header )
		#if defined( __VECTORS_VECTOR3_BI_INCLUDE__ )
			CU_PASS()
		#else
			CU_FAIL()
		#endif
	END_TEST

	TEST( types )

		dim v as vector3

		check_type( v, vector3 )
		check_type( v.x, real )
		check_type( v.y, real )
		check_type( v.z, real )
		check_type( v.e(0), real )
		check_type( v.e(1), real )
		check_type( v.e(2), real )

	END_TEST

	TEST( ctor )
		dim a as vector3 = (1, 2, 3)

		CU_ASSERT_REAL_EXACT( a.x, 1 )
		CU_ASSERT_REAL_EXACT( a.y, 2 )
		CU_ASSERT_REAL_EXACT( a.z, 3 )

		dim b as vector3

		CU_ASSERT_REAL_EXACT( b.x, 0 )
		CU_ASSERT_REAL_EXACT( b.y, 0 )
		CU_ASSERT_REAL_EXACT( b.z, 0 )

		dim c as const vector3 = (1, 2, 3)
		CU_ASSERT_REAL_EXACT( c.x, 1 )
		CU_ASSERT_REAL_EXACT( c.y, 2 )
		CU_ASSERT_REAL_EXACT( c.z, 3 )

	END_TEST

	TEST( add_bop )

		dim a as vector3, b as vector3, c as vector3

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for z1 as real = -2 to 2
					for y2 as real = -2 to 2
						for x2 as real = -2 to 2
							for z2 as real = -2 to 2
								a.set( x1, y1, z1 )
								b.set( x2, y2, z2 )
								c.set( 0, 0, 0 )

								c = a + b
								check_exact( c.x, c.y, c.z, x1+x2, y1+y2, z1+z2 )

								dim c1 as const vector3 = ( x1, y1, z1 )
								dim c2 as const vector3 = ( x2, y2, z2 )

								c = a + c2
								check_exact( c.x, c.y, c.z, x1+x2, y1+y2, z1+z2 )

								c = c1 + b
								check_exact( c.x, c.y, c.z, x1+x2, y1+y2, z1+z2 )

								c = c1 + c2
								check_exact( c.x, c.y, c.z, x1+x2, y1+y2, z1+z2 )

							next
						next
					next
				next
			next
		next

	END_TEST

	TEST( add_self )
		dim a as vector3, b as vector3
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for z1 as real = -2 to 2
					for y2 as real = -2 to 2
						for x2 as real = -2 to 2
							for z2 as real = -2 to 2
								
								a.set( x1, y1, z1 )
								b.set( x2, y2, z2 )
					
								a += b

								check_exact( a.x, a.y, a.z, x1+x2, y1+y2, z1+z2 )
								check_exact( b.x, b.y, b.z, x2, y2, z2 )

								a.set( x1, y1, z1 )
								dim c2 as const vector3 = ( x2, y2, z2 )
								a += c2
								check_exact( a.x, a.y, a.z, x1+x2, y1+y2, z1+z2 )

							next
						next
					next
				next
			next
		next
	END_TEST

	TEST( sub_bop )

		dim a as vector3, b as vector3, c as vector3

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for z1 as real = -2 to 2
					for y2 as real = -2 to 2
						for x2 as real = -2 to 2
							for z2 as real = -2 to 2
								a.set( x1, y1, z1 )
								b.set( x2, y2, z2 )
								c.set( 0, 0, 0 )

								c = a - b
								check_exact( c.x, c.y, c.z, x1-x2, y1-y2, z1-z2 )

								dim c1 as const vector3 = ( x1, y1, z1 )
								dim c2 as const vector3 = ( x2, y2, z2 )

								c = a - c2
								check_exact( c.x, c.y, c.z, x1-x2, y1-y2, z1-z2 )

								c = c1 - b
								check_exact( c.x, c.y, c.z, x1-x2, y1-y2, z1-z2 )

								c = c1 - c2
								check_exact( c.x, c.y, c.z, x1-x2, y1-y2, z1-z2 )

							next
						next
					next
				next
			next
		next

	END_TEST

	TEST( sub_self )
		dim a as vector3, b as vector3
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for z1 as real = -2 to 2
					for y2 as real = -2 to 2
						for x2 as real = -2 to 2
							for z2 as real = -2 to 2
						
								a.set( x1, y1, z1 )
								b.set( x2, y2, z2 )
					
								a -= b

								check_exact( a.x, a.y, a.z, x1-x2, y1-y2, z1-z2 )
								check_exact( b.x, b.y, b.z, x2, y2, z2 )

								a.set( x1, y1, z1 )
								dim c2 as const vector3 = ( x2, y2, z2 )
								a -= c2
								check_exact( a.x, a.y, a.z, x1-x2, y1-y2, z1-z2 )
							
							next
						next
					next
				next
			next
		next
	END_TEST

	TEST( mul_scalar )

		dim a as vector3, c as vector3

		for k as real = -2 to 2
			for x as real = -2 to 2
				for y as real = -2 to 2
					for z as real = -2 to 2

						a.set( x, y, z )

						c.set( 0, 0, 0 )
						c = k * a
						check_exact( c.x, c.y, c.z, a.x * k, a.y * k, a.z * k )

						c.set( 0, 0, 0 )
						c = a * k
						check_exact( c.x, c.y, c.z, a.x * k, a.y * k, a.z * k )

						dim c1 as const vector3 = ( x, y, z )

						c.set( 0, 0, 0 )
						c = c1 * k
						check_exact( c.x, c.y, c.z, a.x * k, a.y * k, a.z * k )

						c.set( 0, 0, 0 )
						c = k * c1
						check_exact( c.x, c.y, c.z, a.x * k, a.y * k, a.z * k )

					next
				next
			next
		next
		
	END_TEST

	TEST( mul_self )

		dim a as vector3

		for k as real = -2 to 2
			for x as real = -2 to 2
				for y as real = -2 to 2
					for z as real = -2 to 2

						a.set( x, y, z )
						a *= k
						check_exact( a.x, a.y, a.z, x * k, y * k, z * k )

					next
				next
			next
		next
		
	END_TEST

	TEST( div_scalar )

		dim a as vector3, c as vector3

		for k as real = -2 to 2
			for x as real = -2 to 2
				for y as real = -2 to 2
					for z as real = -2 to 2
					
						a.set( x, y, z )

						c.set( 0, 0, 0 )
						c = a / k
						check_exact( c.x, c.y, c.z, a.x / k, a.y / k, a.z / k )

						dim c1 as const vector3 = (x, y , z)

						c.set( 0, 0, 0 )
						c = c1 / k
						check_exact( c.x, c.y, c.z, a.x / k, a.y / k, a.z / k )

					next
				next
			next
		next
		
	END_TEST

	TEST( div_self )

		dim a as vector3

		for k as real = -2 to 2
			for x as real = -2 to 2
				for y as real = -2 to 2
					for z as real = -2 to 2

						a.set( x, y, z )
						a /= k
						check_exact( a.x, a.y, a.z, x / k, y / k, z / k )

					next
				next
			next
		next
		
	END_TEST

	TEST( magnitude )
		
		dim a as vector3
		dim d1 as real, d2 as real

		for x as real = -3 to 3
			for y as real = -3 to 3
				for z as real = -3 to 3

					a.set( x, y, z )

					d1 = a.magnitude
					d2 = sqr( x^2 + y^2 + z^2 )

					CU_ASSERT_REAL_EXACT( d1, d2 )

				next
			next
		next

	END_TEST

	TEST( magnitude2 )
		
		dim a as vector3
		dim d1 as real, d2 as real

		for x as real = -3 to 3
			for y as real = -3 to 3
				for z as real = -3 to 3

					a.set( x, y, z )

					d1 = a.magnitude2
					d2 = x^2 + y^2 + z^2

					CU_ASSERT_REAL_EXACT( d1, d2 )

				next
			next
		next

	END_TEST

	TEST( distance )

		dim a as vector3, b as vector3
		dim d1 as real, d2 as real
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
						
								a.set( x1, y1, z1 )
								b.set( x2, y2, z2 )

								d1 = a.distance( b )
								d2 = sqr((b.x-a.x)^2 + (b.y-a.y)^2 + (b.z-a.z)^2)

								CU_ASSERT_REAL_EXACT( d1, d2 )

							next
						next
					next
				next
			next
		next
			
	END_TEST

	TEST( distance2 )

		dim a as vector3, b as vector3
		dim d1 as real, d2 as real
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
						
								a.set( x1, y1, z1 )
								b.set( x2, y2, z2 )

								d1 = a.distance2( b )
								d2 = (b.x-a.x)^2 + (b.y-a.y)^2 + (b.z-a.z)^2

								CU_ASSERT_REAL_EXACT( d1, d2 )

							next
						next
					next
				next
			next
		next
			
	END_TEST

	TEST( unit )
		
		const e = test_epsilon_real

		dim a as vector3, r as vector3

		check_exact( a.x, a.y, a.z, 0, 0, 0 )
		r = a.unit
		check_exact( r.x, r.y, r.z, 0, 0, 0 )

		for x as real = -2 to 2
			for y as real = -2 to 2
				for z as real = -2 to 2

					a.set( x, y, z )
					r = a.unit

					CU_ASSERT_REAL_EXACT( sgn( x ), sgn( r.x ) )
					CU_ASSERT_REAL_EXACT( sgn( y ), sgn( r.y ) )
					CU_ASSERT_REAL_EXACT( sgn( z ), sgn( r.z ) )

					if( x = 0 and y = 0 and z = 0 ) then
						CU_ASSERT_REAL_EXACT( r.x, 0 )
						CU_ASSERT_REAL_EXACT( r.y, 0 )
						CU_ASSERT_REAL_EXACT( r.z, 0 )
					else
						CU_ASSERT_REAL_EQUAL( sqr( r.x * r.x + r.y * r.y + r.z * r.z ), 1, e )
					end if

				next
			next
		next

	END_TEST

	TEST( normalize )
		
		const e = test_epsilon_real

		dim a as vector3

		check_exact( a.x, a.y, a.z, 0, 0, 0 )
		a.normalize
		check_exact( a.x, a.y, a.z, 0, 0, 0 )

		for x as real = -2 to 2
			for y as real = -2 to 2
				for z as real = -2 to 2

					a.set( x, y, z )
					a.normalize

					CU_ASSERT_REAL_EXACT( sgn( x ), sgn( a.x ) )
					CU_ASSERT_REAL_EXACT( sgn( y ), sgn( a.y ) )
					CU_ASSERT_REAL_EXACT( sgn( z ), sgn( a.z ) )

					if( x = 0 and y = 0 and z = 0 ) then
						CU_ASSERT_REAL_EXACT( a.x, 0 )
						CU_ASSERT_REAL_EXACT( a.y, 0 )
						CU_ASSERT_REAL_EXACT( a.z, 0 )
					else
						CU_ASSERT_REAL_EQUAL( sqr( a.x * a.x + a.y * a.y + a.z * a.z ), 1, e )
					end if

				next
			next
		next

	END_TEST

	TEST( neg_self )
		
		dim a as vector3
		
		for x as real = -2 to 2
			for y as real = -2 to 2
				for z as real = -2 to 2
					a.set( x, y, z )
					a.selfop_neg
					check_exact( a.x, a.y, a.z, -x, -y, -z )
				next
			next
		next
	
	END_TEST

	TEST( neg_uop )

		dim a as vector3, b as vector3
		check_exact( a.x, a.y, a.z, 0, 0, 0 )

		for x as real = -2 to 2
			for y as real = -2 to 2
				for z as real = -2 to 2
					a.set( x, y, z )
					b.selfop_zero
					b = -a
					check_exact( b.x, b.y, b.z, -x, -y, -z )

					dim c as const vector3 = -a
					check_exact( c.x, c.y, c.z, -x, -y, -z )
				next
			next
		next
		
	END_TEST

	TEST( zero_self )
		
		dim a as vector3
		check_exact( a.x, a.y, a.z, 0, 0, 0 )

		a.x = 1
		a.y = 2
		a.z = 3
		check_exact( a.x, a.y, a.z, 1, 2, 3 )

		a.selfop_zero
		check_exact( a.x, a.y, a.z, 0, 0, 0 )

	END_TEST

	TEST( dot_product )

		dim a as vector3, b as vector3
		dim d1 as real, d2 as real
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								
								a.set( x1, y1, z1 )
								b.set( x2, y2, z2 )

								d1 = a * b
								CU_ASSERT_REAL_EXACT( d1, a.x * b.x + a.y * b.y + a.z * b.z )

								d2 = a.dot( b )
								CU_ASSERT_REAL_EXACT( d2, a.x * b.x + a.y * b.y + a.z * b.z )

								CU_ASSERT_REAL_EXACT( d1, d2 )

								dim c1 as const vector3 = ( x1, y1, z1 )
								dim c2 as const vector3 = ( x2, y2, z2 )

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
			next
		next
			
	END_TEST

	TEST( cross_product )

		dim a as vector3, b as vector3
		dim c1 as vector3, c2 as vector3
		dim d as real

		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								
								a.set( x1, y1, z1 )
								b.set( x2, y2, z2 )

								c1 = a.cross( b )
								c2 = -b.cross( a )

								'' assert {a} X {b} = -( {b} X {a} )
								check_approx( c1.x, c1.y, c1.z, c2.x, c2.y, c2.z )

								'' use dot products to determine if vectors are parallel
								d = a.dot(a) * b.dot(b) - a.dot(b) * a.dot(b)
								
								'' a is parallel to b if d1 = 0
								if( abs(d) <= test_epsilon_real ) then

									'' a and b are parallel, assert that the magnitude of the
									'' cross product is zero
									CU_ASSERT_REAL_EQUAL( 0, c1.magnitude, test_epsilon_real )

								else

									'' assert that the cross product is orthogonal to both
									'' a and b; the dot product with each a and b will be
									'' near zero

									d = c1.dot( a )
									CU_ASSERT_REAL_EQUAL( 0, d, test_epsilon_real )

									d = c1.dot( b )
									CU_ASSERT_REAL_EQUAL( 0, d, test_epsilon_real )


								end if

							next
						next
					next
				next
			next
		next

	END_TEST

	TEST( operator_args )
		
		dim a as vector3 = (1, 2, 3)
		dim b as vector3 = (5, 7, 11)
		dim c as vector3

		dim F as const vector3 = a
		dim G as const vector3 = b

		dim s as single = 2
		dim d as single = 2
		dim i as integer = 2

		'' operator + (vector3, vector3) as vector3
		c = a + b: check_exact( c.x, c.y, c.z, 6, 9, 14 )
		c = a + G: check_exact( c.x, c.y, c.z, 6, 9, 14 )
		c = F + b: check_exact( c.x, c.y, c.z, 6, 9, 14 )
		c = F + G: check_exact( c.x, c.y, c.z, 6, 9, 14 )

		'' operator - (vector3, vector3) as vector3
		c = a - b: check_exact( c.x, c.y, c.z, -4, -5, -8 )
		c = a - G: check_exact( c.x, c.y, c.z, -4, -5, -8 )
		c = F - b: check_exact( c.x, c.y, c.z, -4, -5, -8 )
		c = F - G: check_exact( c.x, c.y, c.z, -4, -5, -8 )

		'' operator * (vector3, dtype) as vector3
		'' operator * (dtype, vector3) as vector3
		c = a * s: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = a * d: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = a * i: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = F * s: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = F * d: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = F * i: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = s * a: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = d * a: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = i * a: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = s * F: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = d * F: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = i * F: check_exact( c.x, c.y, c.z, 2, 4, 6 )

		'' operator / (vector3, dtype) as vector3
		c = a / s: check_exact( c.x, c.y, c.z, 0.5, 1, 1.5 )
		c = a / d: check_exact( c.x, c.y, c.z, 0.5, 1, 1.5 )
		c = a / i: check_exact( c.x, c.y, c.z, 0.5, 1, 1.5 )
		c = F / s: check_exact( c.x, c.y, c.z, 0.5, 1, 1.5 )
		c = F / d: check_exact( c.x, c.y, c.z, 0.5, 1, 1.5 )
		c = F / i: check_exact( c.x, c.y, c.z, 0.5, 1, 1.5 )

		'' operator * (dtype) as vector3
		c = a: c *= s: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = a: c *= d: check_exact( c.x, c.y, c.z, 2, 4, 6 )
		c = a: c *= i: check_exact( c.x, c.y, c.z, 2, 4, 6 )

		'' operator / (dtype) as vector3
		c = a: c /= s: check_exact( c.x, c.y, c.z, 0.5, 1, 1.5 )
		c = a: c /= d: check_exact( c.x, c.y, c.z, 0.5, 1, 1.5 )
		c = a: c /= i: check_exact( c.x, c.y, c.z, 0.5, 1, 1.5 )

		'' operator - (vector3) as vector3
		c = -a: check_exact( c.x, c.y, c.z, -1, -2, -3 )
		c = -F: check_exact( c.x, c.y, c.z, -1, -2, -3 )

	END_TEST

END_SUITE