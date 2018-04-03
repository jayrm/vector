	vector - geometric vector library
	Copyright (C) 2018 Jeffery R. Marshall (coder[at]execulink[dot]com)

vector library
==============
	Library for working with geometric vectors written to be
	compiled by FreeBASIC compiler.


Licensing
---------

	Software is generally licensed under MIT license.  See license.txt

	Some portions of the software may be licensed more permissively
	and will be clearly indicated at the top of the source code
	file to which it applies.


Introduction
------------

	I like vectors, and I think they are handy.

	Purpose of this library is to:

		- share a vector library written for FreeBASIC with others.

		- consolidate my (too) many implementations of vector API's;
		  many times have I rewritten the same code, and too many
		  times have I just copied and pasted it to where I needed
		  it.

		- help with testing of another library: fbcunit, which 
		  in turn hopefully help improves FreeBASIC test-suite.
		  Specifically, floating ponit math tests, and since the
		  tests for vectors are nearly all floating point, I
		  thought it a good way to work on both.

	These API's for vectors are mostly as they were when they were
	first created.  Each set of API's typically had a specific purpose
	when they were made, so are not wholly consistent with each other.

	However, since some API's are variations of other API's, I have 
	wrapped them in a namespace to avoid naming collisions.  The
	coding style and features of the API's tend to follow what was
	available in the FreeBASIC language at the time.  So as work on
	this library progresses, should see the newer features of fbc
	get used.

	All of the tests are a recent addition.  The original code never 
	had any test-suite.  I should have not been surprised to find some
	bugs, or behaviour that was unexpected.

	DISCLAIMER: I write this library for my own use and reseve the
	right to change it as I see fit.  If it works for you, that's 
	great; if I happen to break an API, you have been warned.

	See documentation section in this file for more a description on 
	how to use that vector library API's.


Compiling
---------
	Expect to use latest version of free basic compiler, currently
	FreeBASIC version 1.0.6.
	
	To compile vector library, from top level directory:

		$ make

	To compile everything: the library, the test-suite, and 
	examples, from top level directory:

		$ make everything

	To list targets and options:

		$ make help


Testing
-------
	To test the library (using its test-suite), from top level
	directory:

		$ make tests && tests/tests.exe

	Also see ./examples directory for examples of usage


Installing
----------
	Copy the following files to the appropriate include and 
	library directories:

		./inc/*.bi
		./lib/lib*.a

	Or specify appropriate compiler & linker options to add
	./inc to the include paths, and ./lib to the library search
	paths.



Documentation
-------------
	See the ./doc directory for help files on this library and
	it's components.  Following, is brief information on the 
	major library components.


vector library
--------------
	Geometric vectors library using object oriented approach.

	vector2 - 2D vector data type
	vector3 - 3D vector data type

	Also has some other support functions and constants

	See:
		doc/vectors.txt
		doc/vectors_vector2.txt
		doc/vectors_vector3.txt


simple vector2 library
----------------------
	Simple 2D vector API using procedures only

	A very basic 2D vector api using one type (structure) and
	procedures only.  This one dates from 2006 and was imported
	from a similar looking library written in both QB and C.
	Because procedures only	only are used, code was failrly
	simple to translate between QB and C.  The original C version
	was for a compiler that did not support inline functions,
	so writing an API in this still would allow easy substitution
	for macros; an alternative to inline functions.

	Original filenames were vector.bi and vector.bas and
	no namespace added.

	See:
		doc/simple_vector2.txt
		

simple vector3 library
----------------------
	Simple 3D vector API using procedures only

	A very basic 3D vector api using one type (structure) and 
	procedures adapted from the Simple 2D vector api.

	Original filenames were vector3.bi and vector3.bas and
	no namespace added.

	See:
		doc/simple_vector3.txt


pointer vector (Vec2_T)
-----------------------
	A 2D vector API using procedures, taking only pointer arguments
	or returning pointer arguments.  Only ever used this one in one
	project (that was never published) and had heavy influence from
	another API I wrote in C.  The original C version was for a
	compiler that did not support inline functions, so writing an
	API in this still would allow easy substitution for macros; an
	alternative to inline functions. And the idea is that pointers
	would be fast and flexible, cast a pointer to any pair of float
	to use as an argument to the API.

	Original filenames were vec2.bi and vec2.bas

	See:
		doc/pointer_vec2.txt


Contact Information
-------------------
	e-mail:
		Jeffery R. Marshall (coder[at]execulink[dot]com)

	This project on github.com:
		https://github.com/jayrm/vector

	As "coderJeff" on FreeBASIC forums:
		https://www.freebasic.net

	Thanks for reading!

EOF
