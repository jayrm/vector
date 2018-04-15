#ifndef __SHEET_BI_INCLUDE__
#define __SHEET_BI_INCLUDE_

	type SHEET
		
		'' !!! TODO !!! this is what I want but fbc fails assert()
		'' GetInterface as function( byval m as const integer = 0 ) as SHEET

		Title as string
		
		HandleInput as sub( byref ctx as SHEET )
		DrawScene as sub( byref ctx as SHEET )

		AddPoint as function( byref ctx as SHEET, byref p as const VECTOR2 ) as BOOLEAN
		DeletePoint as function( byref ctx as SHEET, byval index as const integer ) as BOOLEAN
		MovePoint as function( byref ctx as SHEET, byval index as const integer, byref p as const VECTOR2 ) as BOOLEAN

		MaxPoints as integer
		Points as VECTOR2_ARRAY ptr

		MaxModes as integer
		Mode as integer

		declare constructor()
		declare destructor()

	end type

	type SHEET_INTERFACE as function( byval m as const integer = 0 ) as SHEET

	declare function GetSheetInterface( byval i as const integer = 0, byval m as const integer = 0 ) as SHEET
	

#endif
