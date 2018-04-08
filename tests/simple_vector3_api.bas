#include once "fbcunit.bi"
#include once "simple_vector3.bi"

using simple_vector3

/'
	See:
		inc/simple_vector3.bi
		src/simple_vector3.bas
		doc/simple_vector3.txt

'/

SUITE( simple_vector3_api )

	#include once "fbcunit_local.bi"

	/'
		We generally test for exact values because we testing
		that the semantics of the functions are correct and
		not the precision of the processor and/or platform.
		In most cases our test values are exactly representable
		in floating point format and we should expect exact 
		results.
	'/

	TEST( header )
		#if defined( __SIMPLE_VECTOR3_BI_INCLUDE__ )
			CU_PASS()
		#else
			CU_FAIL()
		#endif
	END_TEST

	TEST( types )

		dim v as vector

		check_type( v, vector )
		check_type( v.x, real )
		check_type( v.y, real )
		check_type( v.z, real )

	END_TEST

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

	TEST( VZero_ )
		
		dim a as vector
		check_exact( a.x, a.y, a.z, 0, 0, 0 )

		a.x = 1
		a.y = 2
		a.z = 3
		check_exact( a.x, a.y, a.z, 1, 2, 3 )

		VZero( a )
		check_exact( a.x, a.y, a.z, 0, 0, 0 )

	END_TEST

	TEST( VSet_ )

		dim a as vector
		check_exact( a.x, a.y, a.z, 0, 0, 0 )

		a.x = 1
		a.y = 2
		a.z = 3
		check_exact( a.x, a.y, a.z, 1, 2, 3 )
		
		for x as real = -2 to 2	
			for y as real = -2 to 2
				for z as real = -2 to 2
					VSet( a, x, y, z )
					check_exact( a.x, a.y, a.z, x, y, z )
				next
			next
		next

	END_TEST

	TEST( VNeg_ )

		dim a as vector, b as vector
		check_exact( a.x, a.y, a.z, 0, 0, 0 )

		for x as real = -2 to 2
			for y as real = -2 to 2
				for z as real = -2 to 2
					VSet( a, x, y, z )
					VZero( b )
					VNeg( b, a )
					check_exact( b.x, b.y, b.z, -x, -y, -z )
				next
			next
		next
		
	END_TEST

	TEST( VAdd_ )

		dim a as vector, b as vector, c as vector

		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								VSet( a, x1, y1, z1 )
								VSet( b, x2, y2, z2 )
								VZero( c )
								VAdd( c, a, b )
								check_exact( c.x, c.y, c.z, x1+x2, y1+y2, z1+z2 )
							next
						next
					next
				next
			next
		next

	END_TEST

	TEST( VAddComp_ )

		dim a as vector, c as vector

		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								VSet( a, x1, y1, z1 )
								VZero( c )
								VAddComp( c, a, x2, y2, z2 )
								check_exact( c.x, c.y, c.z, x1+x2, y1+y2, z1+z2 )
							next
						next
					next
				next
			next
		next

	END_TEST

	TEST( VSub_ )

		dim a as vector, b as vector, c as vector

		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								VSet( a, x1, y1, z1 )
								VSet( b, x2, y2, z2 )
								VZero( c )
								VSub( c, a, b )
								check_exact( c.x, c.y, c.z, x1-x2, y1-y2, z1-z2 )
							next
						next
					next
				next
			next
		next

	END_TEST

	TEST( VSubComp_ )

		dim a as vector, c as vector

		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								VSet( a, x1, y1, z1 )
								VZero( c )
								VSubComp( c, a, x2, y2, z2 )
								check_exact( c.x, c.y, c.z, x1-x2, y1-y2, z1-z2 )
							next
						next
					next
				next
			next
		next

	END_TEST

	TEST( VMul_ )

		dim a as vector, c as vector

		for k as real = -2 to 2
			for x as real = -2 to 2
				for y as real = -2 to 2
					for z as real = -2 to 2
						VSet( a, x, y, z )
						VZero( c )
						VScale( c, a, k )
						check_exact( c.x, c.y, c.z, a.x * k, a.y * k, a.z * k )
					next
				next
			next
		next
		
	END_TEST

	TEST( VAddMul_ )

		dim a as vector, b as vector, c as vector
		dim a1 as vector, b1 as vector, c1 as vector

		VSet( a, 1, 2, 3 )
		VSet( b, 5, 7, 11 )

		for ka as real = -2 to 2
			for kb as real = -2 to 2

				VAddMul( c, ka, a, kb, b )

				VScale( a1, a, ka )
				VScale( b1, b, kb )
				VAdd( c1, a1, b1 )

				check_exact( c.x, c.y, c.z, c1.x, c1.y, c1.z )

			next
		next

	END_TEST

	TEST( VNeg2V_ )
		
		dim a as vector
		
		for x as real = -2 to 2
			for y as real = -2 to 2
				for z as real = -2 to 2
					VSet( a, x, y, z )
					VNeg2V( a )
					check_exact( a.x, a.y, a.z, -x, -y, -z )
				next
			next
		next
	
	END_TEST
	
	TEST( VAdd2V_ )

		dim a as vector, b as vector
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								VSet( a, x1, y1, z1 )
								VSet( b, x2, y2, z2 )
								VAdd2V( a, b )
								check_exact( a.x, a.y, a.z, x1+x2, y1+y2, z1+z2 )
								check_exact( b.x, b.y, b.z, x2, y2, z2 )
							next
						next
					next
				next
			next
		next
			
	END_TEST

	TEST( VAddComp2V_ )

		dim a as vector, b as vector
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								VSet( a, x1, y1, z1 )
								VSet( b, x2, y2, z2 )
								VAddComp2V( a, b.x, b.y, b.z )
								check_exact( a.x, a.y, a.z, x1+x2, y1+y2, z1+z2 )
								check_exact( b.x, b.y, b.z, x2, y2, z2 )
							next
						next
					next
				next
			next
		next
			
	END_TEST

	TEST( VSub2V_ )

		dim a as vector, b as vector
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								VSet( a, x1, y1, z1 )
								VSet( b, x2, y2, z2 )
								VSub2V( a, b )
								check_exact( a.x, a.y, a.z, x1-x2, y1-y2, z1-z2 )
								check_exact( b.x, b.y, b.z, x2, y2, z2 )
							next
						next
					next
				next
			next
		next
			
	END_TEST

	TEST( VSubComp2V_ )

		dim a as vector, b as vector
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								VSet( a, x1, y1, z1 )
								VSet( b, x2, y2, z2 )
								VSubComp2V( a, b.x, b.y, b.z )
								check_exact( a.x, a.y, a.z, x1-x2, y1-y2, z1-z2 )
								check_exact( b.x, b.y, b.z, x2, y2, z2 )
							next
						next
					next
				next
			next
		next
			
	END_TEST

	TEST( VMul2V_ )

		dim a as vector

		for k as real = -2 to 2
			for x as real = -2 to 2
				for y as real = -2 to 2
					for z as real = -2 to 2
						VSet( a, x, y, z )
						VScale2V( a, k )
						check_exact( a.x, a.y, a.z, x * k, y * k, z * k )
					next
				next
			next
		next
			
	END_TEST

	TEST( VUnit_ )
		
		const e = test_epsilon_real

		dim a as vector, r as vector

		check_exact( a.x, a.y, a.z, 0, 0, 0 )
		VUnit( r, a )
		check_exact( r.x, r.y, r.y, 0, 0, 0 )

		for x as real = -2 to 2
			for y as real = -2 to 2
				for z as real = -2 to 2

					VSet( a, x, y, z )
					VUnit( r, a )

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

	TEST( VUnit2V_ )

		const e = test_epsilon_real
		
		dim a as vector

		check_exact( a.x, a.y, a.z, 0, 0, 0 )
		VUnit2V( a )
		check_exact( a.x, a.y, a.z, 0, 0, 0 )

		for x as real = -2 to 2
			for y as real = -2 to 2
				for z as real = -2 to 2

					VSet( a, x, y, z )
					VUnit2V( a )

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

	TEST( VLimit2V_ )
		
		dim a as vector

		for d as real = -3 to 3
			for x as real = -3 to 3
				for y as real = -3 to 3
					for z as real = -3 to 3

						VSet( a, x, y, z )
						VLimit2V( a, d )

						CU_ASSERT( abs(a.x) <= abs(d) )
						CU_ASSERT( abs(a.y) <= abs(d) )
						CU_ASSERT( abs(a.z) <= abs(d) )

					next z
				next
			next
		next

	END_TEST

	TEST( VDot_ )

		dim a as vector, b as vector
		dim d as real
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
								
								VSet( a, x1, y1, z1 )
								VSet( b, x2, y2, y2 )

								d = VDot( a, b )

								CU_ASSERT_REAL_EXACT( d, a.x * b.x + a.y * b.y + a.z * b.z )

							next
						next
					next
				next
			next
		next
			
	END_TEST

	TEST( VDist_ )

		dim a as vector, b as vector
		dim d1 as real, d2 as real
		
		for x1 as real = -2 to 2
			for y1 as real = -2 to 2
				for z1 as real = -2 to 2
					for x2 as real = -2 to 2
						for y2 as real = -2 to 2
							for z2 as real = -2 to 2
						
								VSet( a, x1, y1, z1 )
								VSet( b, x2, y2, z2 )

								d1 = VDist( a, b )
								d2 = sqr((b.x-a.x)^2 + (b.y-a.y)^2 + (b.z-a.z)^2)

								CU_ASSERT_REAL_EXACT( d1, d2 )

							next
						next
					next
				next
			next
		next
			
	END_TEST

	TEST( VMag_ )
		
		dim a as vector
		dim d1 as real, d2 as real

		for x as real = -3 to 3
			for y as real = -3 to 3
				for z as real = -3 to 3

					VSet( a, x, y, z )

					d1 = VMag( a )
					d2 = sqr( x^2 + y^2 + z^2 )

					CU_ASSERT_REAL_EXACT( d1, d2 )

				next
			next
		next

	END_TEST

/'

		declare sub VRot2Vx( byref v as vector, byval r as real )
		declare sub VRot902Vx( byref v as vector )
		declare sub VRot2Vy( byref v as vector, byval r as real )
		declare sub VRot902Vy( byref v as vector )
		declare sub VRot2Vz( byref v as vector, byval r as real )
		declare sub VRot902Vz( byref v as vector )


	TEST( VRot2Vx_ )

		dim a as vector, b as vector
		dim ra1 as real, ra2 as real
		dim x as real, y as real

		for angle1 = -360 to 360 step 30
			ra1 = angle1 * PI / 180

			VSet( a, 1, 0 )
			VRot2V( a, ra1 )

			x = cos( ra1 )
			y = sin( ra1 )

			CU_ASSERT_REAL_EQUAL( a.x, x, epsilon_real )
			CU_ASSERT_REAL_EQUAL( a.y, y, epsilon_real )

			for angle2 = -360 to 360 step 30
				ra2 = angle2 * PI / 180

				b = a
				VRot2Vx( b, ra2 )

				x = cos( ra1 + ra2 )
				y = sin( ra1 + ra2 )
				
				CU_ASSERT_REAL_EQUAL( b.x, x, epsilon_real )
				CU_ASSERT_REAL_EQUAL( b.y, y, epsilon_real )
			next
		next

	END_TEST
'/

	TEST( VString_ )

		dim a as vector
		dim s1 as string
		dim s2 as string

		for x as real = -2 to 2
			for y as real = -2 to 2
				for z as real = -2 to 2

					VSet( a, x, y, z )
					s1 = "(" & x & ", " & y & ", " & z & ")"
					s2 = VString( a )
					CU_ASSERT_EQUAL( s1, s2 )

				next
			next
		next

	END_TEST

END_SUITE
