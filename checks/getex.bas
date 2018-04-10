/'
getex - helper tool to GET EXAMPLES from the docs and write
to files for testing.

INPUT                  COMMAND                OUTPUT
.
. checks/getex.bas --->[ fbc              ]---> checks/getex.exe
. 
. doc/file.txt ------->[ checks/getex.exe ]---> checks/file.bas
.                      [                  ]---> checks/file.txt
. 
. checks/file.bas ---->[ fbc              ]---> checks/file.exe
. 
. checks/file.exe ---->[ shell output     ]---> checks/file.log
. 
. checks/file.txt ---->[ diff -u          ]---> checks/file.diff
. checks/flie.log ---->[                  ]
.


Expectation is that the documentation file has patterns in the
following format:

	....any-text....

	TITLE
	-----

	....any-text....

		Example:
			source code
			source code
			source code

		Output:
			text
			text

	...any-text...

'/

function StartsWith( x as string, check as string ) as boolean
	function = cbool( ucase(left( x, len(check) )) = ucase(check) )
end function

sub outprog( x as string )
	print #2, x
end sub

sub outlog( x as string )
	print #3, x
end sub

sub outinclude( includes as string )

	select case includes
	case "vector2"
		outprog( !"#include once \"vector2.bi\"" )

	case "vector3"
		outprog( !"#include once \"vector3.bi\"" )

	case "line2"
		outprog( !"#include once \"line2.bi\"" )

	case "simple_vector2"
		outprog( !"#include once \"simple_vector2.bi\"" )

	case "simple_vector3"
		outprog( !"#include once \"simple_vector3.bi\"" )

	case "pointer_vec2"
		outprog( !"#include once \"pointer_vec2.bi\"" )

	end select

end sub

sub GetExamples( infile as string, outfile as string, logfile as string, includes as string )

	if( open( infile for input access read as #1 ) <> 0 ) then
		print "Unable to open '" & infile & "' for read"
		end 1
	end if

	if( open( outfile for output as #2 ) <> 0 ) then
		print "Unable to open '" & outfile & "' for write"
		end 1 
	end if

	if( open( logfile for output as #3 ) <> 0 ) then
		print "Unable to open '" & logfile & "' for write"
		end 1 
	end if

	dim x as string, last_x as string
	dim title as string
	dim lineno as integer = 0, start_lineno as integer = 0

	if( includes > "" ) then
		outinclude( includes )
	else
		while eof(1) = false
			line input #1, x
			if( StartsWith( x, chr(9) + chr(9) + "#include" ) ) then
				outprog( x )
				exit while
			end if
		wend
		seek #1, 1
	end if

	while eof(1) = false

		last_x = x
		line input #1, x
		lineno += 1
		start_lineno = lineno

		if( StartsWith( x, "---" ) ) then
			title = last_x
			continue while
		end if

		if( StartsWith( x, chr(9) + "Example:" ) ) then

			outprog( "scope" )
			outprog( !"\tprint \"" & infile & !"\" & \"(\" & " & start_lineno ) & !" & \"): \""
			outprog( !"\tprint \"" & title & !"\"" )
			
			while eof(1) = false
				line input #1, x
				lineno += 1

				if( StartsWith( x, chr(9) + "Output:" ) ) then
					exit while
				end if

				outprog( x )

			wend

			outprog( !"\tprint" )
			outprog( "end scope" )
			outprog( "" )
		end if

		if( StartsWith( x, chr(9) + "Output:" ) ) then

			outlog( infile & "(" & start_lineno &"): " )
			outlog( title )
			while eof(1) = false
				line input #1, x
				lineno += 1
				if( trim( x, any " " + chr(9) ) = "" ) then
					exit while
				end if
				outlog( ltrim( x, chr(9) ) )
			wend
			outlog( "" )
		end if

	wend

	close #3
	close #2
	close #1

end sub

dim opt_help as boolean = false
dim opt_doc_file as string = ""
dim opt_bas_file as string = ""
dim opt_out_file as string = ""
dim opt_inc_file as string = ""

dim i as integer = 1
while( command(i) > "" )
	if( left( command(i), 1 )  = "-" ) then
		select case lcase( command(i) )
		case "-h", "-help", "--help"
			opt_help = true
		case "-i", "--input"
			i += 1
			opt_doc_file = command(i)
		case "-b", "--bas"
			i += 1
			opt_bas_file = command(i)
		case "-o", "--output"
			i += 1
			opt_out_file = command(i)
		case "--include"
			i += 1
			opt_inc_file = command(i)
		case else
			print "unrecognized option '" & command(i) & "'"
		end select
	else
		if opt_doc_file = "" then
			opt_doc_file = command(i)
		elseif opt_bas_file = "" then
			opt_bas_file = command(i)
		elseif opt_out_file = "" then
			opt_out_file = command(i)
		elseif opt_inc_file = "" then
			opt_inc_file = command(i)
		else
			print "unexpected argument '" & command(i) & "'"
		end if
	end if
	i += 1
wend

if( opt_help ) then
	print "getex infile basfile outfile include"
	print
	print "Options:"
	print "  -h, -help, --help        show help"
	print "  [-i, --input] infile     input file"
	print "  [-b, --bas] basfile      basic test file"
	print "  [-o, --output] outfile   output file"
	print "  [--include] include      include file"
	print
	print "Extract example code and output from doc file"
	print "   $ checks/getex.exe doc/vectors_vector2.txt checks/chk2.bas \"
	print "       checks/chk2.txt vector2"
	print
	print "Test build all the examples"
	print "   $ fbc -g -exx checks/chk2.bas -i inc -p lib -x checks/chk2.exe"
	print
	print "Run the test file and capture the output"
	print "   $ checks/chk2.exe > checks/chk2.log"
	print
	print "Compare the output in the doc with the actual output"
	print "   $ diff checks/chk2.txt checks/chk2.log"
	print
	end 0
end if

GetExamples opt_doc_file, opt_bas_file, opt_out_file, opt_inc_file
