##########################

MAKEFILES := fbcunit/makefile
MAKEFILES += src/makefile

##########################

MAKE := make.exe

.SUFFIXES:

VPATH = .

##########################

all: fbcunit vector tests

.PHONY: fbcunit
fbcunit:
	cd fbcunit && $(MAKE) -f makefile all

.PHONY: vector
vector: src/makefile
	cd $(<D) && $(MAKE) -f $(<F)

.PHONY: tests
tests:
	cd tests && $(MAKE) -f makefile

.PHONY: clean
clean:
	cd src && $(MAKE) -f makefile clean
	cd fbcunit && $(MAKE) -f makefile clean
	cd tests && $(MAKE) -f makefile clean
