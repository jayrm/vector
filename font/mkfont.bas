#include once "datetime.bi"
#include once "vbcompat.bi"
#include once "hershey.bi"
#include once "hershey_file.bi"

'' ========================================================
'' mkfont.bas
'' ========================================================

'' !!! FIXME !!! - hershey_file uses global shared data to
'' read in the font and glyph data.  This makes loading 
'' multiple fonts impossible.

using hershey

const INCDIR = "../inc/"

''
sub gen_hershey_fontname_bi( font as FontData )

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

	dim fontname as string = font.name

	for c = 32 to 127
		index(c) = 0
		count(c) = 0
	next

	open INCDIR + "hershey_" & fontname & ".bi" for output as #2

	print #2, "'' DO NOT EDIT - automatically generated " & format( now(), "yyyy-mm-dd hh:nn:ss" )
	print #2,
	print #2, "dim shared glyph_vectors_" & fontname & "(0 to ...) _"
	print #2, "    as Hershey_GlyphVector = _"
	print #2, "{ _"

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

	print #2, "dim shared glyph_index_" & fontname & "(32 to 127) _"
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

''
sub make_include_file( byref file as string )

	dim font as FontData

	'' load font definition 
	'' - this will fill the global variable GlyphList
	LoadFont( file, font )

	'' load all the GlyphData using GlyphList
	LoadGlyphList( )

	gen_hershey_fontname_bi( font )

end sub


make_include_file( "romans" )
make_include_file( "romanp" )
