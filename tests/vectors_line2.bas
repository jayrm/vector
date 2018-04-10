#include once "fbcunit.bi"
#include once "line2.bi"

using vectors

/'
	See:
		inc/vector2.bi
		src/vector2.bas
		doc/vectors_vector2.txt

'/

SUITE( vectors_vector2 )

	#include once "fbcunit_local.bi"

	TEST( header )
		#if defined( __VECTORS_LINE2_BI_INCLUDE__ )
			CU_PASS()
		#else
			CU_FAIL()
		#endif
	END_TEST

	TEST( types )

		dim v as line2

		check_type( v, line2 )
		check_type( v.a, real )
		check_type( v.b, real )
		check_type( v.c, real )

		check_type( v.n, vector2 )

		check_type( v.n.x, real )

		check_type( v.n.y, real )

	END_TEST

END_SUITE
