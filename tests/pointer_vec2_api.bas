#include once "fbcunit.bi"
#include once "pointer_vec2.bi"

using pointer_vec2

/'
	See:
		inc/pointer_vec2.bi
		src/pointer_vec2.bas
		doc/pointer_vec2.txt

'/

SUITE( pointer_vec2_api )

	/'
		We generally test for exact values because we testing
		that the semantics of the functions are correct and
		not the precision of the processor and/or platform.
		In most cases our test values are exactly representable
		in single precision float format and we should expect
		exact results.
	'/

	#if( typeof(real) = typeof(single) )

		#define CU_ASSERT_REAL_EXACT  CU_ASSERT_SINGLE_EXACT
		#define CU_ASSERT_REAL_APPROX CU_ASSERT_SINGLE_APPROX
		#define CU_ASSERT_REAL_EQUAL  CU_ASSERT_SINGLE_EQUAL
		const epsilon = 1E-7

	#elseif( typeof(real) = typeof(double) )

		#define CU_ASSERT_REAL_EXACT  CU_ASSERT_DOUBLE_EXACT
		#define CU_ASSERT_REAL_APPROX CU_ASSERT_DOUBLE_APPROX
		#define CU_ASSERT_REAL_EQUAL  CU_ASSERT_DOUBLE_EQUAL
		const epsilon = 1D-15

	#else
		#error unrecognized float type
	#endif


	TEST( header )
		#if defined( __POINTER_VEC2_BI_INCLUDE__ )
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
			
		dim v as vec2_t

		check_type( v, vec2_t )
		check_type( v.x, single )
		check_type( v.y, single )

	END_TEST

	#macro check_exact( x1, y1, x2, y2 )
		CU_ASSERT_REAL_EXACT( x1, x2 )
		CU_ASSERT_REAL_EXACT( y1, y2 )
	#endmacro

	#macro check_approx( x1, y1, x2, y2 )
		CU_ASSERT_REAL_APPROX( x1, x2, 1 )
		CU_ASSERT_REAL_APPROX( y1, y2, 1 )
	#endmacro

	TEST( V2Zero_ )
		
		dim a as vec2_t
		dim ret as vec2_t ptr
		check_exact( a.x, a.y, 0, 0 )

		a.x = 1
		a.y = 2
		check_exact( a.x, a.y, 1, 2 )

		ret = V2Zero( @a )
		CU_ASSERT_EQUAL( ret, @a )

		check_exact( a.x, a.y, 0, 0 )

	END_TEST

	TEST( V2Make_ )

		dim a as vec2_t
		dim ret as vec2_t ptr
		check_exact( a.x, a.y, 0, 0 )

		a.x = 1
		a.y = 2
		check_exact( a.x, a.y, 1, 2 )

		for y as real = -2 to 2
			for x as real = -2 to 2	

				ret = V2Make( @a, x, y )
				CU_ASSERT_EQUAL( ret, @a )

				check_exact( a.x, a.y, x, y )

			next
		next

	END_TEST

	TEST( V2NegR_ )

		dim a as vec2_t, b as vec2_t
		dim ret as vec2_t ptr
		check_exact( a.x, a.y, 0, 0 )

		for y as real = -2 to 2
			for x as real = -2 to 2

				V2Make( @a, x, y )
				V2Zero( @b )

				ret = V2NegR( @b, @a )
				CU_ASSERT_EQUAL( ret, @b )

				check_exact( b.x, b.y, -x, -y )

			next
		next
		
	END_TEST

	TEST( V2AddR_ )

		dim a as vec2_t, b as vec2_t, c as vec2_t
		dim ret as vec2_t ptr

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2

						V2Make( @a, x1, y1 )
						V2Make( @b, x2, y2 )
						V2Zero( @c )

						ret = V2AddR( @c, @a, @b )
						CU_ASSERT_EQUAL( ret, @c )

						check_exact( c.x, c.y, x1+x2, y1+y2 )

					next
				next
			next
		next

	END_TEST

	TEST( V2SubR_ )

		dim a as vec2_t, b as vec2_t, c as vec2_t
		dim ret as vec2_t ptr

		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2

						V2Make( @a, x1, y1 )
						V2Make( @b, x2, y2 )
						V2Zero( @c )

						ret = V2SubR( @c, @a, @b )
						CU_ASSERT_EQUAL( ret, @c )

						check_exact( c.x, c.y, x1-x2, y1-y2 )

					next
				next
			next
		next

	END_TEST

	TEST( V2MulR_ )

		dim a as vec2_t, c as vec2_t
		dim ret as vec2_t ptr

		for k as real = -2 to 2
			for y as real = -2 to 2
				for x as real = -2 to 2

					V2Make( @a, x, y )
					V2Zero( @c )
					ret = V2MulR( @c, @a, k )
					CU_ASSERT_EQUAL( ret, @c )

					check_exact( c.x, c.y, a.x * k, a.y * k )

				next
			next
		next
		
	END_TEST

	TEST( V2MulAddR_ )

		dim a as vec2_t, b as vec2_t, c as vec2_t
		dim a1 as vec2_t, b1 as vec2_t, c1 as vec2_t
		dim ret as vec2_t ptr

		V2Make( @a, 1, 2 )
		V2Make( @b, 3, 5 )

		for ka as real = -2 to 2
			for kb as real = -2 to 2

				ret = V2MulAddR( @c, @a, ka, @b, kb )
				CU_ASSERT_EQUAL( ret, @c )

				V2MulR( @a1, @a, ka )
				V2MulR( @b1, @b, kb )
				V2AddR( @c1, @a1, @b1 )

				check_exact( c.x, c.y, c1.x, c1.y )

			next
		next

	END_TEST

	TEST( V2Neg_ )
		
		dim a as vec2_t
		dim ret as vec2_t ptr
		
		for y as real = -2 to 2
			for x as real = -2 to 2

				V2Make( @a, x, y )
				ret = V2Neg( @a )
				CU_ASSERT_EQUAL( ret, @a )

				check_exact( a.x, a.y, -x, -y )

			next
		next
	
	END_TEST
	
	TEST( V2Add_ )

		dim a as vec2_t, b as vec2_t
		dim ret as vec2_t ptr
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						V2Make( @a, x1, y1 )
						V2Make( @b, x2, y2 )
			
						ret = V2Add( @a, @b )
						CU_ASSERT_EQUAL( ret, @a )

						check_exact( a.x, a.y, x1+x2, y1+y2 )
						check_exact( b.x, b.y, x2, y2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( V2Sub_ )

		dim a as vec2_t, b as vec2_t
		dim ret as vec2_t ptr
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						V2Make( @a, x1, y1 )
						V2Make( @b, x2, y2 )
			
						ret = V2Sub( @a, @b )
						CU_ASSERT_EQUAL( ret, @a )

						check_exact( a.x, a.y, x1-x2, y1-y2 )
						check_exact( b.x, b.y, x2, y2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( V2Mul_ )

		dim a as vec2_t
		dim ret as vec2_t ptr

		for k as real = -2 to 2
			for y as real = -2 to 2
				for x as real = -2 to 2

					V2Make( @a, x, y )
					ret = V2Mul( @a, k )
					CU_ASSERT_EQUAL( ret, @a )

					check_exact( a.x, a.y, x * k, y * k )

				next
			next
		next
			
	END_TEST

	TEST( V2UnitR_ )
		
		dim a as vec2_t, r as vec2_t
		dim ret as vec2_t ptr

		check_exact( a.x, a.y, 0, 0 )
		V2UnitR( @r, @a )
		check_exact( r.x, r.y, 0, 0 )

		for y as real = -2 to 2
			for x as real = -2 to 2

				V2Make( @a, x, y )
				ret = V2UnitR( @r, @a )

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

	TEST( V2Unit_ )
		
		dim a as vec2_t
		dim ret as vec2_t ptr

		check_exact( a.x, a.y, 0, 0 )
		V2Unit( @a )
		check_exact( a.x, a.y, 0, 0 )

		for y as real = -2 to 2
			for x as real = -2 to 2

				V2Make( @a, x, y )
				ret = V2Unit( @a )
				CU_ASSERT_EQUAL( ret, @a )

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

	TEST( LimitValue_ )
		
		dim n as real

		for d as real = -3 to 3
			for x as real = -3 to 3
				for y as real = x to 3

					'' expected that x <= y
					n = LimitValue( d, x, y )

					CU_ASSERT( n >= x )
					CU_ASSERT( n <= y )

				next
			next
		next

	END_TEST

	TEST( V2Dot_ )

		dim a as vec2_t, b as vec2_t
		dim d as real
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						V2Make( @a, x1, y1 )
						V2Make( @b, x2, y2 )

						d = V2Dot( @a, @b )

						CU_ASSERT_REAL_EXACT( d, a.x * b.x + a.y * b.y )

					next
				next
			next
		next
			
	END_TEST

	TEST( V2Dist_ )

		dim a as vec2_t, b as vec2_t
		dim d1 as real, d2 as real
		
		for y1 as real = -2 to 2
			for x1 as real = -2 to 2
				for y2 as real = -2 to 2
					for x2 as real = -2 to 2
						
						V2Make( @a, x1, y1 )
						V2Make( @b, x2, y2 )

						d1 = V2Dist( @a, @b )
						d2 = sqr((b.x-a.x)^2 + (b.y-a.y)^2)

						CU_ASSERT_REAL_EXACT( d1, d2 )

					next
				next
			next
		next
			
	END_TEST

	TEST( V2Mag_ )
		
		dim a as vec2_t
		dim d1 as real, d2 as real

		for y as real = -3 to 3
			for x as real = -3 to 3

				V2Make( @a, x, y )

				d1 = V2Mag( @a )
				d2 = sqr( x^2 + y^2 )

				CU_ASSERT_REAL_EXACT( d1, d2 )

			next
		next

	END_TEST

	TEST( FixAngle360_ )

		dim a as real
		for angle as real = 0 to 359 step 30

			a = FixAngle360( angle )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 360 )

			a = FixAngle360( angle + 360 )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 360 )

			a = FixAngle360( angle + 720 )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 360 )

			a = FixAngle360( angle - 360 )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 360 )

			a = FixAngle360( angle - 720 )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 360 )

		next

	END_TEST

	TEST( FixAngle180_ )

		dim a as real
		for angle as real = -180 to 179 step 30

			a = FixAngle180( angle )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= -180 )
			CU_ASSERT( angle < 180 )

			a = FixAngle180( angle + 360 )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= -180 )
			CU_ASSERT( angle < 180 )

			a = FixAngle180( angle + 720 )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= -180 )
			CU_ASSERT( angle < 180 )

			a = FixAngle180( angle - 360 )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= -180 )
			CU_ASSERT( angle < 180 )

			a = FixAngle180( angle - 720 )
			CU_ASSERT_REAL_EXACT( angle, a )
			CU_ASSERT( angle >= -180 )
			CU_ASSERT( angle < 180 )

		next

	END_TEST

	TEST( V2Angle_ )

		for angle as real = -720 to 719 step 30

			dim v as vec2_t, a as real, clamp_angle as real

			V2Make( @v, COS( angle * (PI / 180) ), SIN( angle * (PI / 180) ) )

			clamp_angle = FixAngle360( angle )

			a = V2Angle( @v ) * 180 / PI

			CU_ASSERT( a >= 0 )

			'' !!! BUG? !!! - V2Angle() can return radian equivalent of 360 degrees
			CU_ASSERT( a <= 360 )
#if ENABLE_CHECK_BUGS
			CU_ASSERT( a < 360 )
#endif
			a = FixAngle360( a )
			CU_ASSERT( a < 360 )

			'' !!! near zero, selected epsilon is too small due to precision loss
			CU_ASSERT_REAL_EQUAL( a, clamp_angle, epsilon * 10 )
#if ENABLE_CHECK_BUGS
			CU_ASSERT_REAL_EQUAL( a, clamp_angle, epsilon )
#endif		
		next

	END_TEST

#if ENABLE_CHECK_BUGS

	TEST( GetAngleDelta_ )
		
		'' !!! BUG? !!! - Can't remember the intent of GetAngleDelta()
		'' it was 10 years ago I wrote it.

		dim a as real, a1 as single, a2 as single

		for angle1 as real = -720 to 720 step 30
			for angle2 as real = -720 to 720 step 30

				'' !!! TODO !!! - this might be wrong way to test
				a1 = FixAngle180( angle1 )
				a2 = FixAngle180( angle2 )
				
				a = GetAngleDelta( angle1, angle2 )

				CU_ASSERT_REAL_EXACT( a, FixAngle180(a2-a1) )

			next
		next
	END_TEST

#endif

END_SUITE
