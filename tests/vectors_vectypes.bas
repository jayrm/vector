#include once "fbcunit.bi"
#include once "vectypes.bi"

using vectors

/'
	See:
		inc/vectypes.bi
		src/vectypes.bas
		doc/vectors.txt

'/

SUITE( vectors_vectypes )

	#include once "fbcunit_local.bi"

	TEST( header )

		#if defined( __VECTORS_VECTYPES_BI_INCLUDE__ )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		'' test version
		'' if changed:
		'    - update readme.txt
		CU_ASSERT_EQUAL( VECTORS_VERSION_MAJOR, 0 )
		CU_ASSERT_EQUAL( VECTORS_VERSION_MINOR, 3 )


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

		'' comparisons must be approximate due to precision
		'' errors, and since we are comparing mul/div
		'' calculation to an add/sub calculation we may end
		'' up close to -PI or +PI, which in this case are
		'' nearly equivalent angles, though different numbers

		'' choose a suitable epsilon
		const e = test_epsilon_real * exp(log(PI))

		#macro check_angle( ref_angle, cal_angle )
			'' test for equivalent near the endpoints
			if( (ref_angle < -PI+e) and (cal_angle > PI-e) _
			or (cal_angle < -PI-e) and (ref_angle > PI-e) ) then
				CU_PASS()
			else
				CU_ASSERT_REAL_APPROX( ref_angle, angle, 3 )
			end if

			CU_ASSERT( angle >= -PI-e )
			CU_ASSERT( angle < PI+e )
		#endmacro
		
		dim a as real, angle as real
		for deg_angle as real = -180 to 179 step 30

			angle = DEGTORAD( deg_angle )

			a = FixAnglePI( angle )
			check_angle( angle, a )

			a = FixAnglePI( angle + 2 * PI )
			check_angle( angle, a )

			a = FixAnglePI( angle + 4 * PI )
			check_angle( angle, a )

			a = FixAnglePI( angle - 2 * PI )
			check_angle( angle, a )

			a = FixAnglePI( angle - 4 * PI )
			check_angle( angle, a )

		next

	END_TEST

	TEST( FixAnglePI2_ )

		'' comparisons must be approximate due to precision
		'' errors, and since we are comparing mul/div
		'' calculation to an add/sub calculation we may end
		'' up close to 0 or 2*PI, which in this case are
		'' nearly equivalent angles, though different numbers

		const e = test_epsilon_real * exp(log(2*PI))

		#macro check_angle( ref_angle, cal_angle )
			if( (ref_angle < e) and (cal_angle > 2*PI-e) _
			or (cal_angle < e) and (ref_angle > 2*PI-e) ) then
				CU_PASS()
			else
				CU_ASSERT_REAL_EQUAL( ref_angle, cal_angle, e )
			end if

			CU_ASSERT( angle >= 0-e )
			CU_ASSERT( angle < 2*PI+e )
		#endmacro

		dim a as real, angle as real
		for deg_angle as real = 0 to 359 step 30

			angle = DEGTORAD( deg_angle )

			a = FixAnglePI2( angle )
			check_angle( angle, a )

			a = FixAnglePI2( angle + 2 * PI )
			check_angle( angle, a )

			a = FixAnglePI2( angle + 4 * PI )
			check_angle( angle, a )

			a = FixAnglePI2( angle - 2 * PI )
			check_angle( angle, a )

			a = FixAnglePI2( angle - 4 * PI )
			check_angle( angle, a )

		next

	END_TEST

END_SUITE
