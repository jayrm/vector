#ifndef __VECTORS_VECTYPES_BI_INCLUDE__
#define __VECTORS_VECTYPES_BI_INCLUDE__ 1

	#inclib "vectors"

	#define VECTORS_VERSION_MAJOR 0
	#define VECTORS_VERSION_MINOR 3

	#ifndef NULL
	#define NULL 0
	#endif

	#ifndef FALSE
	#define FALSE 0
	#endif

	#ifndef TRUE
	#define TRUE 1
	#endif

	#ifndef boolean
	type boolean as unsigned integer
	#endif

	#ifndef BOOL
	type BOOL as boolean
	#endif

	#ifndef CVBOOL
	#define CVBOOL(x) (iif(x, TRUE, FALSE ))
	#define CVNBOOL(x) (iif(x, FALSE, TRUE ))
	#endif

	#include once "real.bi"

	namespace vectors

		const pi as double = 3.1415926535897932384626433832795
		const pi_by_2 as double = pi * 0.5
		const two_pi as double = pi * 2.0

		const deg_per_rad as double = 180.0 / pi
		const rad_per_deg as double = pi / 180.0

		const EPSILON as real = 1e-14

		#define DEGTORAD(d)		((d) * rad_per_deg)
		#define RADTODEG(r)		((r) * deg_per_rad)

		#define min(a,b)		(iif((a)<(b),(a),(b)))
		#define max(a,b)		(iif((a)>(b),(a),(b)))
		#define clamp(v,a,b)	(min((a),max((b),(v))))

		declare function FixAngle180( byval a as real ) as real
		declare function FixAngle360( byval a as real ) as real
		declare function FixAnglePI( byval a as real ) as real
		declare function FixAnglePI2( byval a as real ) as real

	end namespace

#endif
