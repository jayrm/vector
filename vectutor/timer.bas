#include once "timer.bi"

extern GTIMER as SYSTIMER

dim shared GTIMER as SYSTIMER

constructor SYSTIMER
	tcurr = timer()
	tlast = tcurr - 0.001
	tdelta = 0.001
end constructor

destructor SYSTIMER
end destructor

sub SYSTIMER.Update( )

	tlast = tcurr
	tcurr = timer()
	tdelta = tcurr - tlast
	
	tframes += tdelta
	nframes += 1
	
	if tframes > 1.0 then
		fps = nframes / tframes 
		nframes = 0
		tframes = 0.0
	end if
	
end sub
