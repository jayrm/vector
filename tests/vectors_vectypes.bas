#include once "fbcunit.bi"
#include once "vectypes.bi"

using vectors

SUITE( vectors_vectypes )

	#if( typeof(real) = typeof(single) )

		#define CU_ASSERT_REAL_EXACT  CU_ASSERT_SINGLE_EXACT
		#define CU_ASSERT_REAL_APPROX CU_ASSERT_SINGLE_APPROX
		#define CU_ASSERT_REAL_EQUAL  CU_ASSERT_SINGLE_EQUAL
		const epsilon = 1E-6

	#elseif( typeof(real) = typeof(double) )

		#define CU_ASSERT_REAL_EXACT  CU_ASSERT_DOUBLE_EXACT
		#define CU_ASSERT_REAL_APPROX CU_ASSERT_DOUBLE_APPROX
		#define CU_ASSERT_REAL_EQUAL  CU_ASSERT_DOUBLE_EQUAL
		const epsilon = 1D-15

	#else
		#error unrecognized float type
	#endif

	TEST( header )

		#macro check_type( a, b )
			#if typeof( a ) = typeof( b )
				CU_PASS()
			#else
				CU_FAIL()
			#endif
		#endmacro

		#if defined( __VECTORS_VECTYPES_BI_INCLUDE__ )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		CU_ASSERT_EQUAL( NULL, 0 )
		CU_ASSERT_EQUAL( false, 0 )
		CU_ASSERT_EQUAL( true, not 0 )

		#if defined( boolean )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if defined( BOOL )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if defined( CVBOOL )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		check_type( real, single )

	END_TEST

	TEST( CVBOOL_ )

		CU_ASSERT_EQUAL( CVBOOL(0), false )
		CU_ASSERT_EQUAL( CVBOOL(1), true )
		CU_ASSERT_EQUAL( CVBOOL(-1), true )

	END_TEST

	TEST( CVNBOOL_ )

		CU_ASSERT_EQUAL( CVNBOOL(0), true )
		CU_ASSERT_EQUAL( CVNBOOL(1), false )
		CU_ASSERT_EQUAL( CVNBOOL(-1), false )

	END_TEST

	TEST( FixAngle180_ )

		'' we can test for exact values because
		'' the values we are testing are exactly
		'' representable by floating point

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

	TEST( FixAngle360_ )

		'' we can test for exact values because
		'' the values we are testing are exactly
		'' representable by floating point

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

	TEST( FixAnglePI_ )

		'' comparisons must be approximate due
		'' to precision errors
		
		dim a as real, angle as real
		for deg_angle as real = -180 to 179 step 30

			angle = DEGTORAD( deg_angle )

			a = FixAnglePI( angle )
			CU_ASSERT_REAL_APPROX( angle, a, 0 )
			CU_ASSERT( angle >= -PI )
			CU_ASSERT( angle < PI )

			a = FixAnglePI( angle + 2 * PI )
			CU_ASSERT_REAL_APPROX( angle, a, 2 )
			CU_ASSERT( angle >= -PI )
			CU_ASSERT( angle < PI )

			'' because of the way FixAnglePI() works, we can get
			'' cumulative precision errors, where the answer is
			'' supposed to be (PI - epsilon) < answer <= PI, 
			'' but instead it's -PI < answer <= (-PI + epsilon)

			a = FixAnglePI( angle + 4 * PI )
			if( abs(a) >= PI-epsilon ) then
				CU_ASSERT_REAL_APPROX( abs(angle), abs(a), 3 )
			else
				CU_ASSERT_REAL_APPROX( angle, a, 3 )
			end if
			CU_ASSERT( angle >= -PI )
			CU_ASSERT( angle < PI )

			a = FixAnglePI( angle - 2 * PI )
			CU_ASSERT_REAL_APPROX( angle, a, 2 )
			CU_ASSERT( angle >= -PI )
			CU_ASSERT( angle < PI )

			a = FixAnglePI( angle - 4 * PI )
			CU_ASSERT_REAL_APPROX( angle, a, 3 )
			CU_ASSERT( angle >= -PI )
			CU_ASSERT( angle < PI )

		next

	END_TEST

	TEST( FixAnglePI2_ )

		'' comparisons must be approximate due
		'' to precision errors

		dim a as real, angle as real
		for deg_angle as real = 0 to 359 step 30

			angle = DEGTORAD( deg_angle )

			a = FixAnglePI2( angle )
			CU_ASSERT_REAL_APPROX( angle, a, 0 )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 2 * PI )

			a = FixAnglePI2( angle + 2 * PI )
			CU_ASSERT_REAL_APPROX( angle, a, 2 )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 2 * PI )

			a = FixAnglePI2( angle + 4 * PI )
			CU_ASSERT_REAL_APPROX( angle, a, 3 )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 2 * PI )

			a = FixAnglePI2( angle - 2 * PI )
			CU_ASSERT_REAL_APPROX( angle, a, 2 )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 2 * PI )

			a = FixAnglePI2( angle - 4 * PI )
			CU_ASSERT_REAL_APPROX( angle, a, 3 )
			CU_ASSERT( angle >= 0 )
			CU_ASSERT( angle < 2 * PI )

		next

	END_TEST

END_SUITE
