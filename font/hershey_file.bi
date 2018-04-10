#ifndef __HERSHEY_FILE_BI_INCLUDE__
#define __HERSHEY_FILE_BI_INCLUDE__

	namespace hershey

		extern GlyphList(1 to 4000) as integer
		extern GlyphListCount as integer

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

		declare function LoadGlyphList( ) as integer
		declare function LoadGlyph( index as integer, glyph as GlyphData ) as integer
		declare function LoadFont( file as string, font as FontData ) as integer

	end namespace

#endif
