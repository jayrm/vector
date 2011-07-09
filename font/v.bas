#define FALSE 0
#define TRUE (not FALSE)

#define GLYPHFILE "hershey"
''#define GLYPHFILE "occident"

type GlyphData
    index as integer
    count as integer
    text as string
    x1 as integer
    x2 as integer
    minx as integer
    miny as integer
    maxx as integer
    maxy as integer
end type

type FontData
    name as string
    glyph_index(0 to 255) as integer
end type

dim shared GlyphList(1 to 4000) as integer
dim shared GlyphListCount as integer

function LoadGlyphList( ) as integer
    
    function = FALSE

    dim n as integer
    dim fidx as integer
    dim s as string
    dim count as integer
    dim t as integer

    open GLYPHFILE for input as #1
    while eof(1) = 0
        line input #1, s
        if s = "" then 
            continue while
        end if

        fidx = val(left(s,5))

        count = val(mid(s,6,3))
        t = len(mid(s,9))

        while t < count * 2 and eof(1) = 0
            line input #1, s
            t = t + len(s)
        wend

        n = n + 1
        GlyphList(n) = fidx
    wend
    close #1

    GlyphListCount = n

    function = n

end function

function LoadGlyph( index as integer, glyph as GlyphData ) as integer

    dim s as string
    dim fidx as integer
    dim i as integer

    glyph.index = 0
    glyph.count = 0
    glyph.text = ""
    glyph.x1 = 0
    glyph.x2 = 0
    glyph.minx = 99
    glyph.miny = 99
    glyph.maxx = -99
    glyph.maxy = -99

    function = FALSE

    open GLYPHFILE for input as #1
    while eof(1) = 0
        line input #1, s
        if s = "" then 
            continue while
        end if
        fidx = val(left(s,5))
        if( fidx = index ) then
            function = TRUE
            glyph.count = val(mid(s,6,3))
            glyph.text = mid(s,9)

            glyph.x1 = asc(mid(glyph.text,1,1)) - asc("R")
            glyph.x2 = asc(mid(glyph.text,2,1)) - asc("R")

            while len(glyph.text) < glyph.count * 2 and eof(1) = 0
                line input #1, s
                glyph.text = glyph.text + s
            wend

            exit while
        end if
    wend
    close #1

    dim x as integer
    dim y as integer

    for i = 1 to glyph.count - 1

        x = asc(mid(glyph.text,i * 2 + 1, 1 )) - asc("R")
        y = asc(mid(glyph.text,i * 2 + 2, 2 )) - asc("R")

        if( x = (asc(" ") - asc("R")) and y = (asc("R") - asc("R")) ) then
        else
    
            if( x < glyph.minx ) then glyph.minx = x
            if( x > glyph.maxx ) then glyph.maxx = x
            if( y < glyph.miny ) then glyph.miny = y
            if( y > glyph.maxy ) then glyph.maxy = y
        end if
    next

end function

function LoadFont( file as string, font as FontData ) as integer
    
    font.name = file

    function = FALSE

    dim x as string
    dim index as integer = 32
    dim i as integer
    dim n1 as integer
    dim n2 as integer

    for i = 0 to 255
        font.glyph_index(i) = 0
    next

    open file + ".hmp" for input as #1

    while eof(1) = 0

        line input #1, x

        i = instr(x, "-" )

        if( i > 0 ) then
            n1 = val(left(x,i-1))
            n2 = val(mid(x,i+1))
            for i = n1 to n2
                font.glyph_index(index) = i
                index += 1
            next
        else
            x = ltrim(x)
            while x > ""
                i = instr(x, " ")
                if i = 0 then i = len(x) + 1
                n1 = val(left(x,i-1))
                font.glyph_index(index) = n1
                index += 1
                x = ltrim(mid(x, i + 1))
            wend
        end if

    wend

    close #1


end function


sub draw_glyph( glyph as GlyphData )

    dim penup as integer = TRUE
    dim x as integer = 0, y as integer = 0
    dim lastx as integer, lasty as integer
    dim xx as integer, yy as integer
    dim i as integer

    line( -16 * 3 + 200, 250 ) - ( 16 * 3 + 200, 250 ), 4
    line( 200, -16 * 3 + 250 ) - ( 200, 16 * 3 + 250 ), 4

    x = asc(mid(glyph.text,1, 1 )) - asc("R")
    y = asc(mid(glyph.text,2, 2 )) - asc("R")

    line( x * 3 + 200, 200 ) - ( x * 3 + 200, 250 ), 5
    line( y * 3 + 200, 200 ) - ( y * 3 + 200, 250 ), 5

    for i = 1 to glyph.count - 1

        lastx = x
        lasty = y

        x = asc(mid(glyph.text,i * 2 + 1, 1 )) - asc("R")
        y = asc(mid(glyph.text,i * 2 + 2, 2 )) - asc("R")

        if( x = (asc(" ") - asc("R")) and y = (asc("R") - asc("R")) ) then
            penup = TRUE
        elseif( penup = TRUE ) then
            penup = FALSE
        else
            line( lastx * 3 + 200, lasty * 3 + 250 ) - ( x * 3 + 200, y * 3 + 250 ), 10
        end if

    next

end sub

sub gen_hershey_romans_bi( font as FontData )

    dim c as integer
    dim curr_index as integer
    dim index(32 to 127) as integer
    dim count(32 to 127) as integer
    dim x as integer
    dim y as integer
    dim i as integer
    dim s as string
    dim t as string

    dim glyph as GlyphData
    dim glyph_index as integer
    
    for c = 32 to 127
        index(c) = 0
        count(c) = 0
    next

    open "../hershey_romans.bi" for output as #2

    print #2, "dim shared glyph_vectors_romans(0 to ...) _"
    print #2, "    as Hershey_GlyphVector  = { _"

    s = ""

    curr_index = 0

    for c = 32 to 127

        glyph_index = font.glyph_index( c )
        LoadGlyph( glyph_index, glyph )

        index(c) = curr_index
        count(c) = glyph.count
    
        for i = 0 to glyph.count - 1

            curr_index = curr_index + 1

            x = asc(mid(glyph.text,i * 2 + 1, 1 )) - asc("R")
            y = asc(mid(glyph.text,i * 2 + 2, 2 )) - asc("R")
    
            if( x = (asc(" ") - asc("R")) and y = (asc("R") - asc("R")) ) then
            end if

            t = "(" & x & ", " & y & ")"

            if( c = 127 and i = glyph.count - 1 ) then
                s = s & t & " _"
                print #2, s
            else
                s = s & t & ", "
                if len(s) > 55 then
                    s = s + "_"
                    print #2, s
                    s = ""
                end if
            end if
        next

    next

    print #2, "}"

    print #2,

    print #2, "dim shared glyph_index_romans(32 to 127) _"
    print #2, "    as Hershey_GlyphIndex = { _"

    s = ""

    for c = 32 to 127

        t = "(" & index(c) & ", " & count(c) & ")"

        if c = 127 then
            s = s & t & " _"
            print #2, s
        else
            s = s & t & ", "
            if( len(s) > 55 ) then
                s = s & "_"
                print #2, s
                s = ""
            end if
        end if

    next

    print #2, "}"
    print #2, 

    close #2
    
end sub

dim mode as integer = 0
dim font as FontData
dim list_index as integer = 1
dim glyph_index as integer = 1
dim char_index as integer = 1
dim k as string
dim update as integer = TRUE

LoadFont( "romans", font )

LoadGlyphList( )

gen_hershey_romans_bi( font )

screen 12

do

    if( list_index < 1 ) then list_index = 1
    if( list_index > GlyphListCount ) then list_index = GlyphListCount

    if( char_index < 32 ) then char_index = 32
    if( char_index > 127 ) then char_index = 127

    if mode <> 0 then
        glyph_index = font.glyph_index( char_index )
    else
        glyph_index = GlyphList( list_index )
    end if

    if update = TRUE then
        cls

        locate 1,1

        if mode = 0 then
            print "GLYPH: "; glyph_index; " ("; list_index; " of "; GlyphListCount; ")"
        else
            print "FONT: "; font.name
            print "CHARACTER: "; char_index
            print "GLYPH: "; glyph_index
        end if

        print

        dim glyph as GlyphData
        if( LoadGlyph( glyph_index, glyph ) = TRUE ) then

            print "COUNT = "; glyph.count
            print "X1 = "; glyph.x1
            print "X2 = "; glyph.x2
            print "Text = "; glyph.text
            print "Length = "; len(glyph.text)
            print "min/max x = "; glyph.minx; " to "; glyph.maxx
            print "min/max y = "; glyph.miny; " to "; glyph.maxy

        else
            print "NOT FOUND"
        end if

        draw_glyph( glyph )

        update = FALSE

    end if

    do
        k = inkey
    loop until k <> ""

    select case k
    case chr(27)
            exit do

    case "."
        if mode = 0 then
            list_index = list_index + 1
        else
            char_index = char_index + 1
        end if
        update = TRUE
    
    case ","
        if mode = 0 then
            list_index = list_index - 1
        else
            char_index = char_index - 1
        end if
        update = TRUE

    case "]"
        if mode = 0 then
            list_index = list_index + 10
        else
            char_index = char_index + 10
        end if
        update = TRUE
    
    case "["
        if mode = 0 then
            list_index = list_index - 10
        else
            char_index = char_index - 10
        end if
        update = TRUE

    case "m", "M"
        mode = 1 - mode
        update = TRUE

    end select

loop
