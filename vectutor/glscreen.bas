#include once "refcount.bi"
#include once "gl/gl.bi"
#include once "fbgfx.bi"
#include once "glscreen.bi"
#include once "real.bi"
#include once "angle.bi"

'' --------------------------------------------------------
'' GLSCREENCTX
'' --------------------------------------------------------

''
type GLSCREENCTX

	declare constructor()
	declare destructor()
	ref as REFCOUNTER

	'' width and height of display in pixels
	_display_width as real
	_display_height as real

	'' extents of display ortho projection
	_display_left as real
	_display_top as real
	_display_right as real
	_display_bottom as real

	'' width and height of the world ortho projection
	_width as real
	_height as real

	'' extents of world ortho projection
	_left as real
	_top as real
	_right as real
	_bottom as real

	m_DisplayOrtho( 0 to 15 ) as single
	m_WorldOrtho( 0 to 15 ) as single
	m_Perspective( 0 to 15 ) as single
	m_Model( 0 to 15 ) as single
	m_view(0 to 3) as integer

end type

#define HALF_PIXEL 0.5

''
private constructor GLSCREENCTX()
	_display_width = 0
	_display_height = 0
end constructor

''
private destructor GLSCREENCTX()
end destructor

'' --------------------------------------------------------
'' GLSCREEN
'' --------------------------------------------------------

IMPL_REFCOUNTER( GLSCREEN )

''
sub GLSCREEN.SetDisplayOrtho _
	( _
		byval _left as const real, _
		byval _right as const real, _
		byval _bottom as const real, _
		byval _top as const real _
	)

	_ctx->_display_left = _left
	_ctx->_display_right = _right
	_ctx->_display_bottom = _bottom
	_ctx->_display_top = _top
	_ctx->_display_width = _right - _left
	_ctx->_display_height = _top - _bottom

	glMatrixMode( GL_PROJECTION )
	glLoadIdentity()
	glOrtho( _left, _right, _bottom, _top, -1, 1000 )

	glGetFloatv( GL_PROJECTION_MATRIX, @_ctx->m_DisplayOrtho(0) )

end sub

''
sub GLSCREEN.LoadDisplayOrtho()
	glMatrixMode( GL_PROJECTION )
	glLoadMatrixf( @_ctx->m_DisplayOrtho(0) )
end sub

''
function GLSCREEN.GetDisplayWidth() as real
	function = _ctx->_display_width
end function

''
function GLSCREEN.GetDisplayHeight() as real
	function = _ctx->_display_height
end function

''
sub GLSCREEN.SetWorldOrtho _
	( _
		byval _left as const real, _
		byval _right as const real, _
		byval _bottom as const real, _
		byval _top as const real _
	)

	_ctx->_left = _left
	_ctx->_right = _right
	_ctx->_bottom = _bottom
	_ctx->_top = _top
	_ctx->_width = _right - _left
	_ctx->_height = _top - _bottom

	glMatrixMode( GL_PROJECTION )
	glLoadIdentity()
	glOrtho( _left, _right, _bottom, _top, -1, 1000 )

	glGetFloatv( GL_PROJECTION_MATRIX, @_ctx->m_WorldOrtho(0) )

end sub

''
sub GLSCREEN.LoadWorldOrtho()
	glMatrixMode( GL_PROJECTION )
	glLoadMatrixf( @_ctx->m_WorldOrtho(0) )
end sub

''
function GLSCREEN.GetWidth() as integer
	function = _ctx->_width
end function

''
function GLSCREEN.GetHeight() as integer
	function = _ctx->_height
end function

''
function GLSCREEN.GetLeft() as real
	function = _ctx->_left
end function

''
function GLSCREEN.GetRight() as real
	function = _ctx->_right
end function

''
function GLSCREEN.GetBottom() as real
	function = _ctx->_bottom
end function

''
function GLSCREEN.GetTop() as real
	function = _ctx->_top
end function

''
sub GLSCREEN.SetPerspective _
	( _
		byval fov as const real, _
		byval aspect as const real, _
		byval znear as const real, _
		byval zfar as const real _
	)

	glMatrixMode( GL_PROJECTION )
	glLoadIdentity()

	'' equivalent to gluPerspective()
	dim as real fh = tan( fov / 360 * pi ) * zNear
	dim as real fw = fh * aspect
	glFrustum( -fw, fw, -fh, fh, znear, zfar )

	glGetFloatv( GL_PROJECTION_MATRIX, @_ctx->m_Perspective(0) )

end sub

''
sub GLSCREEN.LoadPerspective()
	glMatrixMode( GL_PROJECTION )
	glLoadMatrixf( @_ctx->m_Perspective(0) )
end sub

''
sub GLSCREEN.SaveView()
	glGetIntegerv( GL_VIEWPORT, @_ctx->m_View(0) )
end sub

''
sub GLSCREEN.SetCamera _
	( _
		byref p as const vector3, _
		byref v as const vector3, _
		byref u as const vector3 _
	)

	'' equivelent to gluLookAt()

/'
	gluLookAt p.x, p.y, p.z, _
		  p.x + v.x, p.y + v.y, p.z + v.z, _
					u.x, u.y, u.z
'/

''	dim as vector3 f = v.unit()
''	dim as vector3 up = u.unit()
	dim as vector3 s = v.cross(u)
	dim as vector3 t = s.unit().cross(v)

	dim m(0 to 15) as double = { _
		s.x, t.x, -v.x, 0, _
		s.y, t.y, -v.y, 0, _
		s.z, t.z, -v.z, 0, _
		  0,   0,    0, 1 }

	glMultMatrixd( @m(0) )
	glTranslated( -p.x, -p.y, -p.z )

end sub


''
function GLSCREEN.SetMode _
	( _
		byval w as const integer, _
		byval h as const integer, _
		byval d as const integer _
	) as integer

	_ctx->_display_width = w
	_ctx->_display_height = h
	_ctx->_display_left = -HALF_PIXEL
	_ctx->_display_top = h-HALF_PIXEL
	_ctx->_display_right = w-HALF_PIXEL
	_ctx->_display_bottom = -HALF_PIXEL

	_ctx->_left = -HALF_PIXEL
	_ctx->_top = h-HALF_PIXEL
	_ctx->_right = w-HALF_PIXEL
	_ctx->_bottom = -HALF_PIXEL
	_ctx->_width = _ctx->_right - _ctx->_left
	_ctx->_height = _ctx->_top - _ctx->_bottom

	'' Initialize the screen
	screenres w, h, d, , fb.GFX_OPENGL
	glViewport( 0, 0, w, h )
	SaveView()

	'' Initialize display ortho projection
	SetDisplayOrtho( -0.5, w - 0.5, h - 0.5, 0.5 )

	'' Initialize world ortho projection
	SetDisplayOrtho( -0.5, w - 0.5, h - 0.5, 0.5 )

	'' Initialize perspective projection
	SetPerspective( 45.0, csng(w)/csng(h), 10, 10000.0 )

	'' Initialize model view
	glMatrixMode( GL_MODELVIEW )
	glLoadIdentity()

	''Shading
	glShadeModel(GL_SMOOTH)
	glClearColor( 0.0f, 0.0f, 0.0f, 1.0f )
	glColor4f( 1.0f, 1.0f, 1.0f, 1.0f )
	glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST )

	'' Depth
	glClearDepth( 1.0f ) 
	glDepthFunc( GL_LEQUAL )
	glEnable( GL_DEPTH_TEST )

	'' Allow glScale when drawing
	glEnable( GL_NORMALIZE )

	'' coloring
	glColorMaterial( GL_FRONT, GL_AMBIENT_AND_DIFFUSE )
	''glEnable( GL_COLOR_MATERIAL )

	'' Texuturing
	glEnable( GL_TEXTURE_2D )

	'' Blending
	glEnable( GL_BLEND )
	glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA )

    glEnable( GL_LINE_SMOOTH )
	glHint( GL_LINE_SMOOTH_HINT, GL_NICEST )

	function = 0

end function

''
sub GLSCREEN.Flip()
	..flip
end sub

''
sub GLSCREEN.BeginFrame()
	glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT )
end sub

''
sub GLSCREEN.EndFrame()
	glFlush()
end sub

''
sub GLSCREEN.DisplayOrtho()
	glDisable( GL_DEPTH_TEST )
	glDisable( GL_CULL_FACE )

	glMatrixMode( GL_PROJECTION )
	LoadDisplayOrtho()

	glMatrixMode( GL_MODELVIEW )
	glLoadIdentity()
end sub

''
sub GLSCREEN.WorldOrtho()
	glDisable( GL_DEPTH_TEST )
	glDisable( GL_CULL_FACE )

	glMatrixMode( GL_PROJECTION )
	LoadWorldOrtho()

	glMatrixMode( GL_MODELVIEW )
	glLoadIdentity()
end sub

''
sub GLSCREEN.Perspective _
	( _
	)

	glMatrixMode( GL_MODELVIEW )
	glLoadIdentity()
	
	glMatrixMode( GL_PROJECTION )
	LoadPerspective()

	glEnable( GL_CULL_FACE )
	glEnable( GL_DEPTH_TEST )

end sub

function GLSCREEN.MapDisplayWtoWorldW( byval w as const real ) as real
	function = w / _ctx->_display_width * _ctx->_width
end function

function GLSCREEN.MapDisplayHtoWorldH( byval h as const real ) as real
	function = h / _ctx->_display_height * _ctx->_height
end function

function GLSCREEN.MapWorldWtoDisplayW( byval w as const real ) as real
	function = w / _ctx->_width * _ctx->_display_width
end function

function GLSCREEN.MapWorldHtoDisplayH( byval h as const real ) as real
	function = h / _ctx->_height * _ctx->_display_height
end function

function GLSCREEN.MapDisplayXtoWorldX( byval x as const real ) as real
	function = (x - _ctx->_display_left) / _ctx->_display_width * _ctx->_width + _ctx->_left
end function

function GLSCREEN.MapDisplayYtoWorldY( byval y as const real ) as real
	function = (y - _ctx->_display_bottom) / _ctx->_display_height * _ctx->_height + _ctx->_bottom
end function

function GLSCREEN.MapWorldXtoDisplayX( byval x as const real ) as real
	function = (x - _ctx->_left) / _ctx->_width * _ctx->_display_width + _ctx->_display_left
end function

function GLSCREEN.MapWorldYtoDisplayY( byval y as const real ) as real
	function = (y - _ctx->_bottom) / _ctx->_height * _ctx->_display_width + _ctx->_display_bottom
end function

function GLSCREEN.MapDisplayXYtoWorldXY( byref a as const VECTOR2 ) as VECTOR2
	function = type _
		( _
			MapDisplayXtoWorldX( a.x ), _
			MapDisplayYtoWorldY( a.y ) _
		)
end function

function GLSCREEN.MapWorldXYtoDisplayXY( byref a as const VECTOR2 ) as VECTOR2
	function = type _
		( _
			MapWorldXtoDisplayX( a.x ), _
			MapWorldYtoDisplayY( a.y ) _
		)
end function

''
function GetPickVector _
	( _
		byval x as const single, _
		byval y as const single _
	) as vector3

	'' map window coords to a pick vector relative to camera position

	dim v as vector3 = ( x, y, 1 )

	function = v

end function
