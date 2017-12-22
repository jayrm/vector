##########################

MAKEFILES := src/makefile
MAKEFILES += fbcunit/makefile

##########################

MAKE := make.exe

.SUFFIXES:

VPATH = $(LIBDIR)

##########################

all: vector fbcunit tests

vector: src/makefile
	$(MAKE) -C $(<D) -f $(<F)

.PHONY: fbcunit
fbcunit:
	$(MAKE) -C fbcunit -f makefile

.PHONY: tests
tests:
	$(MAKE) -C tests -f makefile

.PHONY: clean
clean:
	$(MAKE) -C src -f makefile clean
	$(MAKE) -C fbcunit -f makefile clean
	$(MAKE) -C tests -f makefile clean
