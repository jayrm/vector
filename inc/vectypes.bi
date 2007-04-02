#ifndef __VECTYPES_BI
#define __VECTYPES_BI

#inclib "vectors"

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

type real as single

#define creal( v ) cast( (real), (v) )

const pi as real = 3.1415926535897932384626433832795
const pi_by_2 as real = pi * 0.5
const two_pi as real = pi * 2.0

const deg_per_rad = 180.0 / pi
const rad_per_deg = pi / 180.0

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

#endif
