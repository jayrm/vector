#include once "fbcunit.bi"
#include once "simple_vector2.bi"

using simple_vector2

/'
	See:
		inc/simple_vector2.bi
		src/simple_vector2.bas
		doc/simple_vector2.txt

'/

SUITE( simple_vector2_api )

	#include once "fbcunit_local.bi"

	const epsilon = test_epsilon_real
	const PI = test_PI_real

	/'
		We generally test for exact values because we testing
		that the semantics of the functions are correct and
		not the precision of the processor and/or platform.
		In most cases our test values are exactly representable
		in single precision float format and we should expect
		exact results.
	'/

	TEST( header )
		#if defined( __SIMPLE_VECTOR2_BI_INCLUDE__ )
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

		dim l as line_t

		check_type( l, line_t )
		check_type( l.n, vector )
		check_type( l.d, real )

	END_TEST

	#macro check_exact( x1, y1, x2, y2 )
		CU_ASSERT_REAL_EXACT( x1, x2 )
		CU_ASSERT_REAL_EXACT( y1, y2 )
	#endmacro

	#macro check_approx( x1, y1, x2, y2 )
		CU_ASSERT_REAL_APPROX( x1, x2, 1 )
		CU_ASSERT_REAL_APPROX( y1, y2, 1 )
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

		for y as real = -2 to 2
			for x as real = -2 to 2	
				VSet( a, x, y )
				check_exact( a.x, a.y, x, y )
			next
		next

	END_TEST

	TEST( VNeg_ )

		dim a as vector, b as vector
		check_exact( a.x, a.y, 0, 0 )

		for y as real = -2 to 2
			for x as real = -2 to 2
				VSet( a, x, y )
				VZero( b )
				VNeg( b, a )
				check_exact( b.x, b.y, -x, -y )
			next
		next
		
	END_TEST

	TEST( VAdd_ )

		dim a as vector, b as vector, c as vector

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
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

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
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

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
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

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
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

		for k as real = -2 to 2
			for y as real = -2 to 2
				for x as real = -2 to 2
					
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

		for ka as real = -2 to 2
			for kb as real = -2 to 2

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
		
		for y as real = -2 to 2
			for x as real = -2 to 2
				VSet( a, x, y )
				VNegIm( a )
				check_exact( a.x, a.y, -x, -y )
			next
		next
	
	END_TEST
	
	TEST( VAddIm_ )

		dim a as vector, b as vector
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
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
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
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
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
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
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
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

		for k as real = -2 to 2
			for y as real = -2 to 2
				for x as real = -2 to 2

					VSet( a, x, y )
					VMulIm( a, k )
					check_exact( a.x, a.y, x * k, y * k )

				next
			next
		next
			
	END_TEST

	TEST( VUnit_ )
		
		dim a as vector, r as vector

		check_exact( a.x, a.y, 0, 0 )
		VUnit( r, a )
		check_exact( r.x, r.y, 0, 0 )

		for y as real = -2 to 2
			for x as real = -2 to 2

				VSet( a, x, y )
				VUnit( r, a )

				CU_ASSERT_REAL_EXACT( sgn( x ), sgn( r.x ) )
				CU_ASSERT_REAL_EXACT( sgn( y ), sgn( r.y ) )

				if( x = 0 and y = 0 ) then
					CU_ASSERT_REAL_EXACT( r.x, 0 )
					CU_ASSERT_REAL_EXACT( r.y, 0 )
				else
					CU_ASSERT_REAL_EQUAL( sqr( r.x * r.x + r.y * r.y ), 1, epsilon )
				end if

			next
		next

	END_TEST

	TEST( VUnitIm_ )
		
		dim a as vector

		check_exact( a.x, a.y, 0, 0 )
		VUnitIm( a )
		check_exact( a.x, a.y, 0, 0 )

		for y as real = -2 to 2
			for x as real = -2 to 2

				VSet( a, x, y )
				VUnitIm( a )

				CU_ASSERT_REAL_EXACT( sgn( x ), sgn( a.x ) )
				CU_ASSERT_REAL_EXACT( sgn( y ), sgn( a.y ) )

				if( x = 0 and y = 0 ) then
					CU_ASSERT_REAL_EXACT( a.x, 0 )
					CU_ASSERT_REAL_EXACT( a.y, 0 )
				else
					CU_ASSERT_REAL_EQUAL( sqr( a.x * a.x + a.y * a.y ), 1, epsilon )
				end if

			next
		next

	END_TEST

	TEST( VLimitIm_ )
		
		dim a as vector

		for d as real = -3 to 3
			for y as real = -3 to 3
				for x as real = -3 to 3

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
		dim d as real
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )

						d = VDot( a, b )

						CU_ASSERT_REAL_EXACT( d, a.x * b.x + a.y * b.y )

					next
				next
			next
		next
			
	END_TEST

	TEST( VDist_ )

		dim a as vector, b as vector
		dim d1 as real, d2 as real
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						VSet( a, x1, y1 )
						VSet( b, x2, y2 )

						d1 = VDist( a, b )
						d2 = sqr((b.x-a.x)^2 + (b.y-a.y)^2)

						CU_ASSERT_REAL_EXACT( d1, d2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( VMag_ )
		
		dim a as vector
		dim d1 as real, d2 as real

		for y as real = -3 to 3
			for x as real = -3 to 3

				VSet( a, x, y )

				d1 = VMag( a )
				d2 = sqr( x^2 + y^2 )

				CU_ASSERT_REAL_EXACT( d1, d2 )

			next
		next

	END_TEST

	TEST( VRotIm_ )

		dim a as vector, b as vector
		dim ra1 as real, ra2 as real
		dim x as real, y as real
		dim angle1 as real, angle2 as real

		for angle1 = -360 to 360 step 30
			ra1 = angle1 * PI / 180

			VSet( a, 1, 0 )
			VRotIm( a, ra1 )

			x = cos( ra1 )
			y = sin( ra1 )

			CU_ASSERT_REAL_EQUAL( a.x, x, epsilon )
			CU_ASSERT_REAL_EQUAL( a.y, y, epsilon )

			for angle2 = -360 to 360 step 30
				ra2 = angle2 * PI / 180

				b = a
				VRotIm( b, ra2 )

				x = cos( ra1 + ra2 )
				y = sin( ra1 + ra2 )
				
				CU_ASSERT_REAL_EQUAL( b.x, x, epsilon )
				CU_ASSERT_REAL_EQUAL( b.y, y, epsilon )
			next
		next

	END_TEST

	TEST( VPerp_ )

		dim a as vector, b as vector
		dim angle as real, ra as real
		dim x as real, y as real

		for angle = -360 to 360 step 30

			ra = angle * PI / 180

			VSet( a, 1, 0 )
			VRotIm( a, ra )

			x = cos( ra )
			y = sin( ra )
			
			CU_ASSERT_REAL_EQUAL( a.x, x, epsilon )
			CU_ASSERT_REAL_EQUAL( a.y, y, epsilon )

			VPerp( b, a )
			VRotIm( a, 90 * PI / 180 )

			CU_ASSERT_REAL_EQUAL( a.x, b.x, epsilon )
			CU_ASSERT_REAL_EQUAL( a.y, b.y, epsilon )

		next		

	END_TEST

	TEST( VPerpIm_ )

		dim a as vector, b as vector
		dim angle as real, ra as real
		dim x as real, y as real
		
		for angle = -360 to 360 step 30

			ra = angle * PI / 180

			VSet( a, 1, 0 )
			VRotIm( a, ra )

			x = cos( ra )
			y = sin( ra )
			
			CU_ASSERT_REAL_EQUAL( a.x, x, epsilon )
			CU_ASSERT_REAL_EQUAL( a.y, y, epsilon )

			b = a
			VPerpIm( b )
			VRotIm( a, 90 * PI / 180 )

			CU_ASSERT_REAL_EQUAL( a.x, b.x, epsilon )
			CU_ASSERT_REAL_EQUAL( a.y, b.y, epsilon )


		next		

	END_TEST

	TEST( VLineEq_ )

		dim p0 as vector, p1 as vector, p2 as vector, n as vector
		dim r1 as line_t
		dim r2 as line_t

		'' use y = m * x + b to generate points on a line

		for m as real = -2 to 2
			for b as real = -2 to 2

				'' p0 = ( -5, ? )
				VSet( p0, -5, m * -5 + b )

				'' p1 = ( 0, ? )
				VSet( p1, 0, b )

				'' p2 = ( 10, ? )
				VSet( p2, 10, m * 10 + b )

				'' normal to line
				VSet( n, -m, 1 )

				VLineEqFrom2Point( r1, p1, p2 )
				VLineEqFromPointNormal( r2, p0, n )

				'' normalize signs
				if( sgn(r1.n.x)<>sgn(r2.n.x) or sgn(r1.n.y)<>sgn(r2.n.y) or sgn(r1.d)<>sgn(r2.d) ) then
					r1.n.x = -r1.n.x
					r1.n.y = -r1.n.y
					r1.d = -r1.d
				end if

				'' test that r1 and r2 are coincident (same line)
				CU_ASSERT_REAL_EQUAL( r1.n.x, r2.n.x, epsilon )
				CU_ASSERT_REAL_EQUAL( r1.n.y, r2.n.y, epsilon )
				CU_ASSERT_REAL_EQUAL( r1.d, r2.d, epsilon * 2 )
				
			next
		next

	END_TEST

	TEST( VString_ )

		dim a as vector
		dim s1 as string
		dim s2 as string

		for y as real = -2 to 2
			for x as real = -2 to 2

				VSet( a, x, y )
				s1 = "(" & x & "," & y & ")"
				s2 = VString( a )
				CU_ASSERT_EQUAL( s1, s2 )

			next
		next

	END_TEST

	TEST( AddMinimal_ )

		dim d as real, d2 as real

		d = epsilon ^ 2
		CU_ASSERT( d < epsilon )

		d2 = d ^ 2
		CU_ASSERT( d2 < d )

		for x as real = -3 to 3 step 0.1
			CU_ASSERT_REAL_EQUAL( x + d2, x, d2 )
			CU_ASSERT( AddMinimal( x, d ) > x )
		next x

	END_TEST

	TEST( SubMinimal_ )

		dim d as real, d2 as real
		d = epsilon ^ 2
		CU_ASSERT( d < epsilon )

		d2 = d ^ 2
		CU_ASSERT( d2 < d )

		for x as real = -3 to 3 step 0.1
			CU_ASSERT_REAL_EQUAL( x + d2, x, d2 )
			CU_ASSERT( SubMinimal( x, d ) < x )
		next x

	END_TEST

END_SUITE
