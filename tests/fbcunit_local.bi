#ifndef __FBCUNIT_LOCAL_BI_INCLUDE__
#define __FBCUNIT_LOCAL_BI_INCLUDE__ 1

	'' check that type 'a' is same as type 'b'

	#macro check_type( a, b )
		#if typeof( a ) = typeof( b )
			CU_PASS()
		#else
			CU_FAIL()
		#endif
	#endmacro

	'' single has about 7 decimal digits of precision, though not always
	const test_epsilon_single as single = 1E-6

	'' double has about 16 decimal digits of precision, though not always
	const test_epsilon_double as double = 1D-15

	'' minimum 9 digits required
	const test_PI_single as single = 3.1415926536

	'' minimum 17 digits required
	const test_PI_double as double = 3.14159265358979323846
	
	'' map assertion macros depending on type of REAL
	#if( typeof(real) = typeof(single) )

		#define CU_ASSERT_REAL_EXACT  CU_ASSERT_SINGLE_EXACT
		#define CU_ASSERT_REAL_APPROX CU_ASSERT_SINGLE_APPROX
		#define CU_ASSERT_REAL_EQUAL  CU_ASSERT_SINGLE_EQUAL
		const test_epsilon_real as real = test_epsilon_single
		const test_PI_real as real = test_PI_single

	#elseif( typeof(real) = typeof(double) )

		#define CU_ASSERT_REAL_EXACT  CU_ASSERT_DOUBLE_EXACT
		#define CU_ASSERT_REAL_APPROX CU_ASSERT_DOUBLE_APPROX
		#define CU_ASSERT_REAL_EQUAL  CU_ASSERT_DOUBLE_EQUAL
		const test_epsilon_real as real = test_epsilon_double
		const test_PI_real as real = test_PI_double

	#else
		#error unrecognized float type
	#endif

#endif
