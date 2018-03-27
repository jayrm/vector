#include once "fbcunit.bi"
#include once "vector.bi"

/'
	See:
		inc/vector.bi
		src/vector.bas

'/

SUITE( vector_api )

	const PI = 3.141592741
	const epsilon = 0.0000001

	TEST( header )
		#if defined( __VECTOR_BI__ )
			CU_PASS()
		#else
			CU_FAIL()
		#endif
	END_TEST

	TEST( types )

		#macro check_type( a, b )
			#if typeof( a ) = typeof( b )
				CU_PASS()
			#else
				CU_FAIL()
			#endif
		#endmacro
			
		dim v as vector

		check_type( v, vector )
		check_type( v.x, single )
		check_type( v.y, single )

	END_TEST

	/'
		We generally test for exact values because we testing
		that the semantics of the functions are correct and
		not the precision of the processor and/or platform.
		In most cases our test values are exactly representable
		in single precision float format and we should expect
		exact results.
	'/

	#macro check_exact( x1, y1, x2, y2 )
		CU_ASSERT_SINGLE_EXACT( x1, x2 )
		CU_ASSERT_SINGLE_EXACT( y1, y2 )
	#endmacro

	#macro check_approx( x1, y1, x2, y2 )
		CU_ASSERT_SINGLE_APPROX( x1, x2, 1 )
		CU_ASSERT_SINGLE_APPROX( y1, y2, 1 )
	#endmacro

	TEST( VZero_ )
		
		dim a as vector
		check_exact( a.x, a.y, 0, 0 )

		a.x = 1
		a.y = 2
		check_exact( a.x, a.y, 1, 2 )

		VZero( a )
		check_exact( a.x, a.y, 0, 0 )

	END_TEST

	TEST( VSet_ )

		dim a as vector
		check_exact( a.x, a.y, 0, 0 )

		a.x = 1
		a.y = 2
		check_exact( a.x, a.y, 1, 2 )

		for y as single = -2 to 2
			for x as single = -2 to 2	
				VSet( a, x, y )
				check_exact( a.x, a.y, x, y )
			next
		next

	END_TEST

	TEST( VNeg_ )

		dim a as vector, b as vector
		check_exact( a.x, a.y, 0, 0 )

		for y as single = -2 to 2
			for x as single = -2 to 2
				VSet( a, x, y )
				VZero( b )
				VNeg( b, a )
				check_exact( b.x, b.y, -x, -y )
			next
		next
		
	END_TEST

	TEST( VAdd_ )

		dim a as vector, b as vector, c as vector

		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )
						VZero( c )
			
						VAdd( c, a, b )
						check_exact( c.x, c.y, x1+x2, y1+y2 )
					next
				next
			next
		next

	END_TEST

	TEST( VAddComp_ )

		dim a as vector, c as vector

		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VZero( c )
			
						VAddComp( c, a, x2, y2 )
						check_exact( c.x, c.y, x1+x2, y1+y2 )

					next
				next
			next
		next

	END_TEST

	TEST( VSub_ )

		dim a as vector, b as vector, c as vector

		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )
						VZero( c )
			
						VSub( c, a, b )
						check_exact( c.x, c.y, x1-x2, y1-y2 )
					next
				next
			next
		next

	END_TEST

	TEST( VSubComp_ )

		dim a as vector, c as vector

		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VZero( c )
			
						VSubComp( c, a, x2, y2 )
						check_exact( c.x, c.y, x1-x2, y1-y2 )
					next
				next
			next
		next

	END_TEST

	TEST( VMul_ )

		dim a as vector, c as vector

		for k as single = -2 to 2
			for y as single = -2 to 2
				for x as single = -2 to 2
					
					VSet( a, x, y )
					VZero( c )
		
					VMul( c, k, a )
					check_exact( c.x, c.y, a.x * k, a.y * k )
				next
			next
		next
		
	END_TEST

	TEST( VAddMul_ )

		dim a as vector, b as vector, c as vector
		dim a1 as vector, b1 as vector, c1 as vector

		VSet( a, 1, 2 )
		VSet( b, 3, 5 )

		for ka as single = -2 to 2
			for kb as single = -2 to 2

				VAddMul( c, ka, a, kb, b )

				VMul( a1, ka, a )
				VMul( b1, kb, b )
				VAdd( c1, a1, b1 )

				check_exact( c.x, c.y, c1.x, c1.y )

			next
		next

	END_TEST

	TEST( VNegIm_ )
		
		dim a as vector
		
		for y as single = -2 to 2
			for x as single = -2 to 2
				VSet( a, x, y )
				VNegIm( a )
				check_exact( a.x, a.y, -x, -y )
			next
		next
	
	END_TEST
	
	TEST( VAddIm_ )

		dim a as vector, b as vector
		
		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )
			
						VAddIm( a, b )

						check_exact( a.x, a.y, x1+x2, y1+y2 )
						check_exact( b.x, b.y, x2, y2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( VAddCompIm_ )

		dim a as vector, b as vector
		
		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )
			
						VAddCompIm( a, b.x, b.y )

						check_exact( a.x, a.y, x1+x2, y1+y2 )
						check_exact( b.x, b.y, x2, y2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( VSubIm_ )

		dim a as vector, b as vector
		
		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )
			
						VSubIm( a, b )

						check_exact( a.x, a.y, x1-x2, y1-y2 )
						check_exact( b.x, b.y, x2, y2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( VSubCompIm_ )

		dim a as vector, b as vector
		
		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )
			
						VSubCompIm( a, b.x, b.y )

						check_exact( a.x, a.y, x1-x2, y1-y2 )
						check_exact( b.x, b.y, x2, y2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( VMulIm_ )

		dim a as vector

		for k as single = -2 to 2
			for y as single = -2 to 2
				for x as single = -2 to 2

					VSet( a, x, y )
					VMulIm( a, k )
					check_exact( a.x, a.y, x * k, y * k )

				next
			next
		next
			
	END_TEST

	TEST( VUnitIm_ )
		
		dim a as vector

		check_exact( a.x, a.y, 0, 0 )
		VUnitIm( a )
		check_exact( a.x, a.y, 0, 0 )

		for y as single = -2 to 2
			for x as single = -2 to 2

				VSet( a, x, y )
				VUnitIm( a )

				CU_ASSERT_SINGLE_EXACT( sgn( x ), sgn( a.x ) )
				CU_ASSERT_SINGLE_EXACT( sgn( y ), sgn( a.y ) )

				if( x = 0 and y = 0 ) then
					CU_ASSERT_SINGLE_EXACT( a.x, 0 )
					CU_ASSERT_SINGLE_EXACT( a.y, 0 )
				else
					CU_ASSERT_SINGLE_EQUAL( sqr( a.x * a.x + a.y * a.y ), 1, 0.0000001 )
				end if

			next
		next

	END_TEST

	TEST( VLimitIm_ )
		
		dim a as vector

		for d as single = -3 to 3
			for y as single = -3 to 3
				for x as single = -3 to 3

					VSet( a, x, y )
					VLimitIm( a, d )

					CU_ASSERT( abs(a.x) <= abs(d) )
					CU_ASSERT( abs(a.y) <= abs(d) )

				next
			next
		next

	END_TEST

	TEST( VDot_ )

		dim a as vector, b as vector
		dim d as single
		
		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )

						d = VDot( a, b )

						CU_ASSERT_SINGLE_EXACT( d, a.x * b.x + a.y * b.y )

					next
				next
			next
		next
			
	END_TEST

	TEST( VDist_ )

		dim a as vector, b as vector
		dim d1 as single, d2 as single
		
		for y1 as single = -2 to 2
			for x1 as single = -2 to 2
				for y2 as single = -2 to 2
					for x2 as single = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )

						d1 = VDist( a, b )
						d2 = sqr((b.x-a.x)^2 + (b.y-a.y)^2)

						CU_ASSERT_SINGLE_EXACT( d1, d2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( VMag_ )
		
		dim a as vector
		dim d1 as single, d2 as single

		for y as single = -3 to 3
			for x as single = -3 to 3

				VSet( a, x, y )

				d1 = VMag( a )
				d2 = sqr( x^2 + y^2 )

				CU_ASSERT_SINGLE_EXACT( d1, d2 )

			next
		next

	END_TEST

	TEST( VRotIm_ )

		dim a as vector, b as vector
		dim ra1 as single, ra2 as single
		dim x as single, y as single

		for angle1 = -360 to 360 step 30
			ra1 = angle1 * PI / 180

			VSet( a, 1, 0 )
			VRotIm( a, ra1 )

			x = cos( ra1 )
			y = sin( ra1 )

			CU_ASSERT_SINGLE_EQUAL( a.x, x, epsilon )
			CU_ASSERT_SINGLE_EQUAL( a.y, y, epsilon )

			for angle2 = -360 to 360 step 30
				ra2 = angle2 * PI / 180

				b = a
				VRotIm( b, ra2 )

				x = cos( ra1 + ra2 )
				y = sin( ra1 + ra2 )
				
				CU_ASSERT_SINGLE_EQUAL( b.x, x, epsilon )
				CU_ASSERT_SINGLE_EQUAL( b.y, y, epsilon )
			next
		next

	END_TEST

	TEST( VRot90_ )

		dim a as vector, b as vector
		dim angle as single, ra as single

		for angle = -360 to 360 step 30

			ra = angle1 * PI / 180

			VSet( a, 1, 0 )
			VRotIm( a, ra )

			x = cos( ra )
			y = sin( ra )
			
			CU_ASSERT_SINGLE_EQUAL( a.x, x, epsilon )
			CU_ASSERT_SINGLE_EQUAL( a.y, y, epsilon )

			VRot90( b, a )
			VRotIm( a, 90 * PI / 180 )

			CU_ASSERT_SINGLE_EQUAL( a.x, b.x, epsilon )
			CU_ASSERT_SINGLE_EQUAL( a.y, b.y, epsilon )

		next		

	END_TEST

	TEST( VRot90Im_ )

		dim a as vector, b as vector
		dim angle as single, ra as single

		for angle = -360 to 360 step 30

			ra = angle1 * PI / 180

			VSet( a, 1, 0 )
			VRotIm( a, ra )

			x = cos( ra )
			y = sin( ra )
			
			CU_ASSERT_SINGLE_EQUAL( a.x, x, epsilon )
			CU_ASSERT_SINGLE_EQUAL( a.y, y, epsilon )

			b = a
			VRot90Im( b )
			VRotIm( a, 90 * PI / 180 )

			CU_ASSERT_SINGLE_EQUAL( a.x, b.x, epsilon )
			CU_ASSERT_SINGLE_EQUAL( a.y, b.y, epsilon )

		next		

	END_TEST

END_SUITE
