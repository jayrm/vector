#ifndef __VECTORS_VECTYPES_BI_INCLUDE__
#define __VECTORS_VECTYPES_BI_INCLUDE__ 1

	#inclib "vectors"

	#define VECTORS_VERSION_MAJOR 0
	#define VECTORS_VERSION_MINOR 4

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
	#include once "angle.bi"

	namespace vectors

		const PI as real = 3.14159265358979323846#

		const EPSILON as real = 1e-14

		#define min(a,b)		(iif((a)<(b),(a),(b)))
		#define max(a,b)		(iif((a)>(b),(a),(b)))
		#define clamp(v,a,b)	(min((a),max((b),(v))))

	end namespace

#endif
