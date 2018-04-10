#include once "hershey.bi"
#include once "hershey_file.bi"

'' ========================================================
'' vfont.bas
'' ========================================================

using hershey

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

dim mode as integer = 0
dim font as FontData
dim list_index as integer = 1
dim glyph_index as integer = 1
dim char_index as integer = 1
dim k as string
dim update as integer = TRUE

'' pre-load a font
LoadFont( "romans", font )
LoadGlyphList( )

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

		'' !!! FIXME !!! - LoadGlyph reads the glyph file every time!
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
