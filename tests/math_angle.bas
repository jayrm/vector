#include once "fbcunit.bi"
#include once "angle.bi"

using angles

/'
	See:
		inc/angle.bi
		src/angle.bas
		doc/angle.txt

'/

SUITE( math_angles )

	#include once "fbcunit_local.bi"

	TEST( header )
		#if defined( __MATH_ANGLE_BI_INCLUDE__ )
			CU_PASS()
		#else
			CU_FAIL()
		#endif
	END_TEST

	'' select appropriate epsilons for the test ranges

	const e_deg = test_epsilon_real * exp(log(360))
	const e_rad = test_epsilon_real * exp(log(2*PI))
	const e_grad = test_epsilon_real * exp(log(400))
	const e_turn = test_epsilon_real * exp(log(1))

	#macro check_real( a, b, e )
		CU_ASSERT_REAL_EQUAL( a, b, e )
	#endmacro

	TEST( deg_conversion )
		
		for d as real = -720 to 720 step 0.1
			
			dim r as real = Deg2Rad(d)
			dim g as real = Deg2Grad(d)
			dim t as real = Deg2Turn(d)

			check_real( Deg2Rad(d + 360), r + 2 * PI, e_rad )
			check_real( Deg2Grad(d + 360), g + 400, e_grad )
			check_real( Deg2Turn(d + 360), t + 1, e_turn )

		next

	END_TEST

	TEST( rad_conversion )
		
		for r as real = -4*PI to 4*PI step 0.1
			
			dim d as real = Rad2Deg(r)
			dim g as real = Rad2Grad(r)
			dim t as real = Rad2Turn(r)

			check_real( Rad2Deg(r + 2*PI), d + 360, e_deg )
			check_real( Rad2Grad(r + 2*PI), g + 400, e_grad )
			check_real( Rad2Turn(r + 2*PI), t + 1, e_turn )

		next

	END_TEST

	TEST( grad_conversion )
		
		for g as real = -800 to 800 step 0.1
			
			dim d as real = Grad2Deg(g)
			dim r as real = Grad2Rad(g)
			dim t as real = Grad2Turn(g)

			check_real( Grad2Deg(g + 400), d + 360, e_deg )
			check_real( Grad2Rad(g + 400), r + 2*PI, e_rad )
			check_real( Grad2Turn(g + 400), t + 1, e_turn )

		next

	END_TEST

	TEST( turn_conversion )
		
		for t as real = -2 to 2 step 0.05
			
			dim d as real = Turn2Deg(t)
			dim r as real = Turn2Rad(t)
			dim g as real = Turn2Grad(t)

			check_real( Turn2Deg(t + 1), d + 360, e_deg )
			check_real( Turn2Rad(t + 1), r + 2*PI, e_rad )
			check_real( Turn2Grad(t + 1), g + 400, e_grad )

		next

	END_TEST

END_SUITE
