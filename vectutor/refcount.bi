#ifndef __REFCOUNT_BI_INCLUDE__
#define __REFCOUNT_BI_INCLUDE__

#ifndef DEBUG_TRACE_LOG
#ifdef DEBUG_TRACE
#define DEBUG_TRACE_LOG(t_) print t_
#else
#define DEBUG_TRACE_LOG(t_)
#endif
#endif

''
type REFCOUNTER
	declare constructor()
	declare destructor()
	declare function AddRef( byval p as any ptr ) as integer
	declare function Release( byval p as any ptr ) as integer
	refcount as integer
end type

''
#macro DECL_REFCOUNTER( _name_ )

	declare constructor()
	declare constructor( byref parent as const _name_ )
	declare destructor()
	declare operator let ( byref parent as const _name_ )

#endmacro

''
#macro IMPL_REFCOUNTER( _name_ )

''
constructor _name_()
	_ctx = new _name_##CTX
	DEBUG_TRACE_LOG( "constructor " & #_name_ & "(" & hex(@this) & ")" )
	_ctx->ref.AddRef( @this )
end constructor

''
constructor _name_( byref parent as const _name_ )
	_ctx = parent._ctx
	DEBUG_TRACE_LOG( "copy constructor " & #_name_ & "(" & hex(@this) & ")" )
	_ctx->ref.AddRef( @this )
end constructor

''
operator _name_.let( byref parent as const _name_ )
	DEBUG_TRACE_LOG( "assignment " & #_name_ & "(" & hex(@this) & ")" )
	if( _ctx->ref.Release( @this ) = 0 ) then
		delete _ctx
	end if
	_ctx = parent._ctx
	_ctx->ref.AddRef( @this )
end operator

''
destructor _name_()
	DEBUG_TRACE_LOG( "destructor " & #_name_ & "(" & hex(@this) & ")" )
	if( _ctx->ref.Release( @this ) = 0 ) then
		delete _ctx
	end if
end destructor

#endmacro

#endif
