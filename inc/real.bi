#ifndef __MATH_REAL_BI_INCLUDE__
#define __MATH_REAL_BI_INCLUDE__

#ifndef REAL
	type REAL as single
#endif

#if typeof( real ) = typeof( single )
	#define REAL_ZERO 0.0!
	#define CREAL( value ) CSNG( value )
#elseif typeof( real ) = typeof( double )
	#define REAL_ZERO 0.0#
	#define CREAL( value ) CDBL( value )
#else
	#error iInvalid data type for type REAL
#endif

#endif
