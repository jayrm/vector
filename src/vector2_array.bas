''	vector - geometric vector library
''	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)

#include once "vector2.bi"
#include once "vector2_array.bi"

#define NULL 0

constructor VECTOR2_ARRAY()
	list = NULL
	n = 0
end constructor

constructor VECTOR2_ARRAY( varray as VECTOR2_ARRAY )
	list = NULL
	n = 0
	Assign( varray )
end constructor

destructor VECTOR2_ARRAY()
	if( list <> NULL ) then
		deallocate list
	end if
end destructor

property VECTOR2_ARRAY.Count() as integer
	property = n
end property

property VECTOR2_ARRAY.v( index as integer ) as VECTOR2
	if( index >= 1 ) and ( index <= n ) then
		property = list[index-1]
	else
		property = VECTOR2( 0.0, 0.0 )
	end if
end property

property VECTOR2_ARRAY.v( index as integer, p as VECTOR2 )
	if( index >= 1 ) and ( index <= n ) then
		list[index-1] = p
	end if
end property

sub VECTOR2_ARRAY.Clear( )
	if( list <> NULL ) then
		deallocate list
		list = NULL
		n = 0
	end if
end sub

sub VECTOR2_ARRAY.Assign( varray as VECTOR2_ARRAY )

	Clear()

	if( varray.Count > 0 ) then
		list = allocate( sizeof( VECTOR2 ) * varray.Count )
		if( list <> NULL ) then
			for i as integer = 1 to varray.Count
				list[i-1] = varray.v( i )
			next
			n = varray.Count
		end if
	end if 
end sub

operator VECTOR2_ARRAY.let( varray as VECTOR2_ARRAY )
	Assign( varray )
end operator


function VECTOR2_ARRAY.Add( p as VECTOR2 ) as integer

	dim newlist as VECTOR2 PTR = reallocate( list, sizeof(VECTOR2) * (n + 1) )
	if( newlist <> NULL ) then
		list = newlist
		list[n] = p
		n += 1
		function = n
	else
		function = 0
	end if

end function

function VECTOR2_ARRAY.AddUnique( p as VECTOR2, e as REAL = EPSILON ) as integer
	dim i as integer = Near( p, e )
	if( i > 0 ) then
		function = i
	else
		function = Add( p )
	end if
end function

function VECTOR2_ARRAY.Insert( p as VECTOR2, index as integer = 0 ) as integer
	if( index <= 0 or index > n ) then
		function = Add( p )
	else
		dim newlist as VECTOR2 ptr = reallocate( list, sizeof(VECTOR2) * (n + 1) )
		if( newlist <> NULL ) then
			list = newlist
			n += 1
			for i as integer = n - 1 to index step - 1
				list[i] = list[i-1]
			next 
			list[index-1] = p
			function = index
		else
			function = 0
		end if
	end if

end function

sub VECTOR2_ARRAY.Remove( index as integer )

	if ( index >= 1 ) and ( index <= n ) then
		for i as integer = index to n - 1
			list[i-1] = list[i]
		next 

		n = n - 1

		if n = 0 then

			deallocate list
			list = NULL
		
		else
		
			dim newlist as VECTOR2 ptr = reallocate( list, sizeof(VECTOR2) * n )
			if newlist <> NULL then
				list = newlist
			end if
			
		end if

	end if 

end sub

function VECTOR2_ARRAY.Near( p as VECTOR2, e as REAL = EPSILON ) as integer
	
	function = 0

	for i as integer = 0 to n - 1
		if abs(list[i].x - p.x) <= e and abs(list[i].y - p.y) <= e then
			function = i + 1
			exit for
		end if
	next

end function

sub VECTOR2_ARRAY.SortXY( )

	if n <= 0 then
		exit sub
	end if
	
	dim i as integer

	'' Not already sorted?
	for i = 1 to n - 1
		if compareXY( list[i-1], list[i] ) < 0 then
			exit for
		end if
	next	

	if i <= n - 1 then
		quicksortXY( 0, n-1 )
	end if

end sub

function VECTOR2_ARRAY.compareXY( v1 as VECTOR2, v2 as VECTOR2 ) as integer

	if( v1.x < v2.x ) then
		function = -1
	elseif( v1.x > v2.x ) then
		function = 1
	elseif( v1.y < v2.y ) then
		function = -1
	elseif( v1.y > v2.y ) then
		function = 1
	else
		function = 0
	end if

end function

sub VECTOR2_ARRAY.quicksortXY( lidx as integer, ridx as integer )

	dim pidx as integer		'' pivot index
	dim sidx as integer		'' "store to" index
	dim idx as integer		'' comparison index
	
	if lidx < ridx then
	
		pidx = (lidx + ridx) \ 2
		swap list[pidx], list[ridx]
		sidx = lidx
		for idx = lidx to ridx - 1
			if compareXY( list[idx], list[ridx] ) < 0 then
				swap list[idx], list[sidx]
				sidx += 1
			end if
		next
		swap list[sidx], list[ridx]
		
		quicksortXY lidx, sidx - 1
		quicksortXY sidx + 1, ridx

	end if
	
end sub

function VECTOR2_ARRAY.ConvexHull( ) as VECTOR2_ARRAY

	dim hull as VECTOR2_ARRAY
	
	if count < 3 then
		hull = this

	else

		dim sorted as VECTOR2_ARRAY = this
		sorted.SortXY()

		hull.Add( sorted.v(1) )	
		
		for i as integer = 2 to sorted.count - 1
			dim p1 as VECTOR2 = hull.v( hull.count )
			dim p2 as VECTOR2 = sorted.v(i) '' candidate
			dim a as VECTOR2 = p2 - p1
			dim j as integer
			
			for j = i + 1 to sorted.count
				dim b as VECTOR2 = sorted.v(j) - p2
				if ( a.x * b.y - b.x * a.y ) > 0 then
					exit for				
				end if
			next
			
			if j > sorted.count then
				hull.add p2
			end if

		next
		
		hull.add( sorted.v( sorted.count ) )

		for i as integer = sorted.count - 1 to 2 step - 1

			dim p1 as VECTOR2 = hull.v( hull.count )
			dim p2 as VECTOR2 = sorted.v(i) '' candidate
			dim a as VECTOR2 = p2 - p1
			dim j as integer
			
			for j = i - 1 to 1 step - 1
				dim b as VECTOR2 = sorted.v(j) - p2
				if ( a.x * b.y - b.x * a.y ) > 0 then
					exit for				
				end if
			next
			
			if j < 1 then
				hull.add p2
			end if
		
		next 
		
	end if

	function = hull

end function

          	      