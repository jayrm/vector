#ifndef __TIMER_BI_INCLUDE__
#define __TIMER_BI_INCLUDE__

type SYSTIMER

	tcurr as double
	tlast as double
	tdelta as double
	tframes as double
	nframes as double
	fps as double
	
	declare constructor( )
	declare destructor( )
	
	declare sub Update( )
	
end type

#endif

