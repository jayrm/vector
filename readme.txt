vector library
==============

Library for working with geometric vectors

Purposes for this library:

- I like vectors, and I think they are handy
- consolidate my (too) many implementations of vector API's
- testing for another library: fbcunit

These API's for vectors are typically as they were when they were
first created.  However, since some are variations are others, I
have wrapped them in a namespace to avoid naming collisions.

However, each set of API's typically had a specific purpose
when they were made, so are not wholly consistent with each other.

Originally when the code was written, the only testing/debugging done 
was by using the code.  


Components
==========

simple vector
-------------

	Simple 2D vector API using procedures only

	A very basic 2D vector api using one type (structure) and 
	procedures only.  This one dates from 2006 and was imported 
	from a similar looking library written in both QB and C.  
	Because procedures only	only are used, code was failrly
	simple to translate between QB and C.

	Original filenames were vector.bi and vector.bas and
	no namespace added.

	See:
		doc/simple_vector.txt
		src/simple_vector.bas
		inc/simple_vector.bi
		tests/simple_vector_api.bas
		

simple vector3
--------------

	Simple 3D vector API using procedures only

	A very basic 3D vector api using one type (structure) and 
	procedures adapted from the Simple 2D vector api.

	Original filenames were vector3.bi and vector3.bas and
	no namespace added.

	See:
		doc/simple_vector3.txt
		src/simple_vector3.bas
		inc/simple_vector3.bi
		tests/simple_vector3_api.bas
