#include once "glscreen.bi"

extern gls as GLSCREEN
dim shared gls as GLSCREEN

declare sub MainLoop()

''
type SCREEN_MODE_DATA field = 1
	union
		mode as long
		type field = 1
			h as ushort
			w as ushort
		end type
	end union
end type

function CheckScreenModeValid( byval w as short, byval h as short, byval depth as long ) as boolean

	dim m as SCREEN_MODE_DATA

	m.mode = Screenlist( depth )

	while( m.mode <> 0 )
		if( m.w = w andalso m.h = h) then
			return true
		end if
		m.mode = Screenlist()
	wend

	return false

end function

sub ListScreenModes( byval w as short, byval h as short, byval depth as long )

	if( depth = 0 ) then
		ListScreenModes( w, h, 8 )
		ListScreenModes( w, h, 15 )
		ListScreenModes( w, h, 16 )
		ListScreenModes( w, h, 24 )
		ListScreenModes( w, h, 32 )
		exit sub
	end if

	dim m as SCREEN_MODE_DATA

	m.mode = Screenlist( depth )

	while( m.mode <> 0 )
		if((w=0 orelse (w<>0 andalso m.w=w)) andalso (h=0 orelse (h<>0 andalso m.h=h))) then
			print m.w & "x" & m.h & "x" & depth
		end if
		m.mode = Screenlist()
	wend

end sub

'' ------------------------------------
'' VECTUTOR -- MAIN
'' ------------------------------------

dim as integer opt_width = 0
dim as integer opt_height = 0
dim as integer opt_depth = 0
dim as boolean opt_list_modes = false
dim as boolean opt_help = false

dim i as integer = 1
while( command(i) > "" )
	select case left(command(i),1)
	case "-"
		select case command(i)
		case "-h", "--help"
			opt_help = true
		case "-listmodes"
			opt_list_modes = true
		case "-dw"
			i += 1: opt_width = val(command(i))
		case "-dh"
			i += 1: opt_height = val(command(i))
		case "-dd"
			i += 1: opt_depth = val(command(i))
		case "-listmodes"
			opt_list_modes = true
		case else
			print "unrecognized option '" & command(i) & "'"
			end 1
		end select
	case else
		print "unexpected option '" & command(i) & "'"
	end select
	i += 1
wend

if( opt_help ) then
	print "vectutor [options]"
	print "options:"
	print "   -h, --help     show help"
	print "   -dw WIDTH      set display width"
	print "   -dh HEIGHT     set display height"
	print "   -dd DEPTH      set display depth"
	print "   -listmodes     list all screen modes"
	end 0
end if

if( opt_list_modes ) then
	ListScreenModes( opt_width, opt_height, opt_depth )
	end 0
end if

if opt_width = 0 andalso opt_height = 0 then
	opt_width = 1024
	opt_height = 768
end if

if opt_width = 0 orelse opt_height = 0 then
	print "need both width and height"
	end 1
end if

if opt_depth = 0 then
	opt_depth = 16
end if

if( CheckScreenModeValid( opt_width, opt_height, opt_depth ) = false ) then
	print "invalid screen mode " & opt_width & "x" & opt_height & "x" & opt_depth
	end 1
end if

gls.SetMode( opt_width, opt_height, opt_depth )
gls.SetWorldOrtho( -125, 125, -100, 100 )

MainLoop()
