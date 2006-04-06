##########################

MAKE := make

FBC := fbc

ECHO := echo

LIBRARY := lib/libvector.a
SRCS    := src/vector.bas
HDRS    := inc/vector.bi

TEST_SRCS := tests/tests.bas
TEST_SRCS += tests/vector_api.bas

TEST_OBJS := $(patsubst %.bas,%.o,$(TEST_SRCS))

TEST_EXE  := tests/tests.exe

EXAMPLES := examples/ex01.exe

ifneq ($(ARCH),)
	FBCFLAGS += -arch $(ARCH)
endif
ifneq ($(TARGET),)
	FBCFLAGS += -target $(TARGET)
endif
ifneq ($(FPU),)
	FBCFLAGS += -fpu $(FPU)
endif
ifeq ($(DEBUG),1)
	FBCFLAGS += -g -exx
endif

FBCFLAGS += -mt -g -exx -i ./inc -i ./fbcunit/inc -w pedantic

.SUFFIXES: .bas

VPATH = .

##########################

.PHONY: all
all: library

.PHONY: help
help:
	@$(ECHO) "usage: make target [options]"
	@$(ECHO) ""
	@$(ECHO) "Targets:"
	@$(ECHO) "   help           - displays this information"
	@$(ECHO) "   library        - builds $(LIBRARY)"
	@$(ECHO) "   tests          - builds tests for fbcunit"
	@$(ECHO) "   examples       - builds all the examples"
	@$(ECHO) "   everything     - builds library, tests, examples"
	@$(ECHO) "   clean          - cleans up all built files"
	@$(ECHO) ""
	@$(ECHO) "Options:"
	@$(ECHO) "   FBC=/path/fbc  - set path to FBC compiler"
	@$(ECHO) "   TARGET=target"
	@$(ECHO) "   ARCH=arch (default is 486)"
	@$(ECHO) "   FPU=fpu | sse"

.PHONY: everything
everything: fbcunit library tests

.PHONY: fbcunit
fbcunit: fbcunit/makefile
	$(MAKE) -C $(<D) -f $(<F) library

.PHONY: library
library: $(LIBRARY)

.PHONY: tests
tests: fbcunit $(TEST_EXE)

.PHONY: examples
examples: $(EXAMPLES)

$(LIBRARY): $(SRCS) $(HDRS)
	$(FBC) $(FBCFLAGS) -lib $(SRCS) -x $@

tests/%.o: tests/%.bas $(HDRS)
	$(FBC) $(FBCFLAGS) -m tests -c $< -o $@

examples/%.exe: examples/%.bas $(HDRS) $(LIBRARY)
	$(FBC) $(FBCFLAGS) $< -p ./lib -p ./fbcunit/lib -x $@

$(TEST_EXE): $(TEST_OBJS) $(LIBRARY) fbcunit
	$(FBC) $(FBCFLAGS) $(TEST_OBJS) -p ./lib -p ./fbcunit/lib -x $@

.PHONY: clean
clean:
	-rm -f $(LIBRARY)
	-rm -f $(TEST_OBJS) $(TEST_EXE)
	-rm -f $(EXAMPLES)
	$(MAKE) -C fbcunit -f makefile clean
