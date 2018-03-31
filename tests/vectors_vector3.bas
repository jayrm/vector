#include once "fbcunit.bi"
#include once "vector3.bi"

using vectors

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
		dim d as real
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								
								a.set( x1, y1, z1 )
								b.set( x2, y2, z2 )

								d = a * b

								CU_ASSERT_REAL_EXACT( d, a.x * b.x + a.y * b.y + a.z * b.z )

							next
						next
					next
				next
			next
		next
			
	END_TEST

END_SUITE