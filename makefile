##########################

MAKE := make

.SUFFIXES:

VPATH = .

##########################

.PHONY: all
all: fbcunit vector tests

.PHONY: fbcunit
fbcunit: fbcunit/makefile
	$(MAKE) -C $(<D) -f $(<F)

.PHONY: vector
vector: src/makefile
	$(MAKE) -C $(<D) -f $(<F)

.PHONY: tests
tests: tests/makefile
	$(MAKE) -C $(<D) -f $(<F)

.PHONY: clean
clean:
	$(MAKE) -C tests  -f makefile clean
	$(MAKE) -C src -f makefile clean
	$(MAKE) -C fbcunit  -f makefile clean
