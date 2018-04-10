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
		CU_ASSERT_EQUAL( VECTORS_VERSION_MINOR, 4 )


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

END_SUITE
