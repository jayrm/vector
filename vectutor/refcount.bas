#include once "refcount.bi"

''
constructor REFCOUNTER()
	refcount = 0
end constructor

''
destructor REFCOUNTER()
end destructor

''
function REFCOUNTER.AddRef( byval p as any ptr ) as integer
	DEBUG_TRACE_LOG( "    " & hex(p) & ".AddRef()" )
	refcount += 1
	function = refcount
end function

''
function REFCOUNTER.Release( byval p as any ptr ) as integer
	if( refcount ) then
		refcount -= 1
	end if
	function = refcount
	DEBUG_TRACE_LOG( "    " & hex(p) & ".Release()" )
end function
