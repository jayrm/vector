#ifndef __MATH_ANGLE_BI_INCLUDE__
#define __MATH_ANGLE_BI_INCLUDE__

#include once "real.bi"

type radians as real
type degrees as real
type gradians as real
type turns as real

const PI as real = 3.14159265358979323846#

'' ----- Angle Conversion

declare function Deg2Rad( byval angle as degrees ) as radians
declare function Deg2Grad( byval angle as degrees ) as gradians
declare function Deg2Turn( byval angle as degrees ) as turns

declare function Rad2Deg( byval angle as radians ) as degrees
declare function Rad2Grad( byval angle as radians ) as gradians
declare function Rad2Turn( byval angle as radians ) as turns

declare function Grad2Rad( byval angle as gradians ) as radians
declare function Grad2Deg( byval angle as gradians ) as degrees
declare function Grad2Turn( byval angle as gradians ) as turns

declare function Turn2Rad( byval angle as turns ) as radians
declare function Turn2Deg( byval angle as turns ) as degrees
declare function Turn2Grad( byval angle as turns ) as gradians

#endif
