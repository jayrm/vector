#include once "fbcunit.bi"
#include once "vector2.bi"

using vectors

SUITE( vectors_vector2 )

	TEST( header )
		#if defined( __VECTORS_VECTOR2_BI_INCLUDE__ )
			CU_PASS()
		#else
			CU_FAIL()
		#endif
	END_TEST

END_SUITE