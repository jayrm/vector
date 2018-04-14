#ifndef __MATH_ANGLE_BI_INCLUDE__
#define __MATH_ANGLE_BI_INCLUDE__

'' ------------------------------------
'' ANGLE
'' ------------------------------------

	#include once "real.bi"

	namespace angles

		type radians as real
		type degrees as real
		type gradians as real
		type turns as real

		const PI as double = 3.1415926535897932384626433832795
		const PI_BY_2 as double = PI * 0.5
		const TWO_PI as double = PI * 2.0

		#define deg_per_rad     (180.0 / PI)
		#define rad_per_deg     (PI / 180.0)

		#define DEGTORAD(d)		((d) * rad_per_deg)
		#define RADTODEG(r)		((r) * deg_per_rad)

		'' ----- Angle Conversion

		declare function Deg2Rad( byval angle as const degrees ) as radians
		declare function Deg2Grad( byval angle as const degrees ) as gradians
		declare function Deg2Turn( byval angle as const degrees ) as turns

		declare function Rad2Deg( byval angle as const radians ) as degrees
		declare function Rad2Grad( byval angle as const radians ) as gradians
		declare function Rad2Turn( byval angle as const radians ) as turns

		declare function Grad2Rad( byval angle as const gradians ) as radians
		declare function Grad2Deg( byval angle as const gradians ) as degrees
		declare function Grad2Turn( byval angle as const gradians ) as turns

		declare function Turn2Rad( byval angle as const turns ) as radians
		declare function Turn2Deg( byval angle as const turns ) as degrees
		declare function Turn2Grad( byval angle as const turns ) as gradians

		declare function FixAngle180( byval a as real ) as real
		declare function FixAngle360( byval a as real ) as real
		declare function FixAnglePI( byval a as real ) as real
		declare function FixAnglePI2( byval a as real ) as real

	end namespace

#endif
