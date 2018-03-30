vector
------

Library for working with geometric vectors

These API's for vectors are typically as they were when they were
first created.  Each set of API's typically had a specific purpose
when they were made, so are not wholly consistent with each other.


Components
----------

simple vector

	Simple 2D vector API using procedures only

	A very basic 2D vector api using one type (structure) and 
	procedures only.  This one dates from 2006 and was imported 
	from a similar looking library written in both QB and C.  
	Because procedures only	only are used, code was failrly
	simple to translate between QB and C.

	See:
		doc/simple_vector.txt
		src/simple_vector.bas
		inc/simple_vector.bi
		tests/simple_vector_api.bas
		

simple vector3

	Simple 3D vector API using procedures only

	A very basic 3D vector api using one type (structure) and 
	procedures adapted from the Simple 2D vector api.

	See:
		doc/simple_vector3.txt
		src/simple_vector3.bas
		inc/simple_vector3.bi
		tests/simple_vector3_api.bas
