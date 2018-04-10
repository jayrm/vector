#include once "hershey_file.bi"

const GLYPHFILE = "hershey"
'' const GLYPHFILE = "occident"

const DATADIR = "./hershey-data/"

'' ========================================================
'' hershey_file.bas
'' ========================================================

/'

hershey-data/*.hmp files

gothgbt         Gothic English Triplex
gothgrt         Gothic German Triplex
gothitt         Gothic Italian Triplex
greekc          Greek Complex
greekcs         Greek Complex Small
greekp          Greek Plain
greeks          Greek Simplex
cyrilc          Cyrillic complex
italicc         Italic Complex
italiccs        Italic Complex Small
italict         Italic Triplex
scriptc         Script Complex
scripts         Script Simplex
romanc          Roman Complex
romancs         Roman Complex Small
romand          Roman Duplex
romanp          Roman Plain
romans          Roman Simplex
romant          Roman Triplex
'/

'' All characters are assumed to start at 0,0 and current
'' vector (1,0)

namespace hershey

	dim shared GlyphList(1 to 4000) as integer
	dim shared GlyphListCount as integer

	''
	function LoadGlyphList( ) as integer
    
		function = FALSE

		dim n as integer
		dim fidx as integer
		dim s as string
		dim count as integer
		dim t as integer

		open DATADIR + GLYPHFILE for input as #1
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

	''
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

		open DATADIR + GLYPHFILE for input as #1
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

	''
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

		open DATADIR + file + ".hmp" for input as #1

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

end namespace
