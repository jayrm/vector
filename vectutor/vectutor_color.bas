#include once "GL/gl.bi"
#include once "vectutor_color.bi"

sub SetColor( byval index as const VECTUTOR_COLOR, byval intensity as const REAL = 1.0 )

	static clrs( 0 to (VECTUTOR_COLORS * 3) - 1 ) as single = _
	{ _
		/' COLOR_TEXT    '/   1.0, 1.0, 1.0, _
		/' COLOR_POINTS  '/   1.0, 1.0, 0.5, _
		/' COLOR_CONS	 '/   0.5, 0.5, 0.5, _
		_
		/' COLOR_BLACK	 '/   0.0, 0.0, 0.0, _
		/' COLOR_BLUE	 '/   0.0, 0.0, 1.0, _
		/' COLOR_GREEN	 '/   0.0, 1.0, 0.0, _
		/' COLOR_CYAN    '/   0.0, 1.0, 1.0, _
		/' COLOR_RED	 '/   1.0, 0.0, 0.0, _
		/' COLOR_MAGENTA '/   1.0, 0.0, 1.0, _
		/' COLOR_YELLOW  '/   1.0, 1.0, 0.0, _
		/' COLOR_WHITE   '/   1.0, 1.0, 1.0 _
	}

	dim i as integer = index
	dim s as REAL = intensity

	if i < 0 then i = 0
	if i > VECTUTOR_COLORS - 1 then i = VECTUTOR_COLORS - 1

	if s < 0.0 then s = 0.0
	if s > 1.0 then s = 1.0	

	glColor3f( clrs(i*3+0)*s,clrs(i*3+1)*s,clrs(i*3+2)*s )
	

end sub
