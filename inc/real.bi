#ifndef __VECTORS_REAL_BI_INCLUDE__
#define __VECTORS_REAL_BI_INCLUDE__

namespace vectors

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

end namespace

#endif
