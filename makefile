##########################

MAKE := make

FBC := fbc

ECHO := echo

SIMPLE_VECTOR2_LIBRARY := lib/libsimple_vector2.a
SIMPLE_VECTOR2_SRCS    := src/simple_vector2.bas
SIMPLE_VECTOR2_HDRS    := inc/simple_vector2.bi

SIMPLE_VECTOR3_LIBRARY := lib/libsimple_vector3.a
SIMPLE_VECTOR3_SRCS    := src/simple_vector3.bas
SIMPLE_VECTOR3_HDRS    := inc/simple_vector3.bi

POINTER_VEC2_LIBRARY := lib/libpointer_vec2.a
POINTER_VEC2_SRCS    := src/pointer_vec2.bas
POINTER_VEC2_HDRS    := inc/pointer_vec2.bi

VECTORS_LIBRARY := lib/libvectors.a

VECTORS_SRCS    += src/vector2.bas
VECTORS_SRCS    += src/vector3.bas
VECTORS_SRCS    += src/camera3.bas
VECTORS_SRCS    += src/plane3.bas
VECTORS_SRCS    += src/line2.bas
VECTORS_SRCS    += src/vector2_array.bas
VECTORS_SRCS    += src/vector2_aabb.bas
VECTORS_SRCS    += src/angle.bas

VECTORS_HDRS    := inc/vectypes.bi
VECTORS_HDRS    += inc/vector2.bi
VECTORS_HDRS    += inc/vector3.bi
VECTORS_HDRS    += inc/camera3.bi
VECTORS_HDRS    += inc/plane3.bi
VECTORS_HDRS    += inc/line2.bi
VECTORS_HDRS    += inc/vector2_array.bi
VECTORS_HDRS    += inc/vector2_aabb.bi
VECTORS_HDRS    += inc/angle.bi

TEST_SRCS := tests/tests.bas
TEST_SRCS += tests/simple_vector2_api.bas
TEST_SRCS += tests/simple_vector3_api.bas
TEST_SRCS += tests/pointer_vec2_api.bas
TEST_SRCS += tests/vectors_vectypes.bas
TEST_SRCS += tests/vectors_vector2.bas
TEST_SRCS += tests/vectors_vector3.bas
TEST_SRCS += tests/math_angle.bas

TEST_HDRS := tests/fbcunit_local.bi

TEST_OBJS := $(patsubst %.bas,%.o,$(TEST_SRCS))

TEST_EXE  := tests/tests.exe

EXAMPLES := examples/ex01.exe

LIBRARIES := $(SIMPLE_VECTOR2_LIBRARY)
LIBRARIES += $(SIMPLE_VECTOR3_LIBRARY)
LIBRARIES += $(POINTER_VEC2_LIBRARY)
LIBRARIES += $(VECTORS_LIBRARY)

HDRS := $(SIMPLE_VECTOR2_HDRS)
HDRS += $(SIMPLE_VECTOR3_HDRS)
HDRS += $(POINTER_VEC2_HDRS)

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

FBCFLAGS += -mt -i ./inc -i ./fbcunit/inc -w pendantic

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
	@$(ECHO) "   library        - builds $(LIBRARIES)"
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
library: $(LIBRARIES)

.PHONY: tests
tests: fbcunit $(TEST_EXE)

.PHONY: examples
examples: $(EXAMPLES)

$(SIMPLE_VECTOR2_LIBRARY): $(SIMPLE_VECTOR2_SRCS) $(SIMPLE_VECTOR2_HDRS)
	$(FBC) $(FBCFLAGS) -lib $(SIMPLE_VECTOR2_SRCS) -x $@

$(SIMPLE_VECTOR3_LIBRARY): $(SIMPLE_VECTOR3_SRCS) $(SIMPLE_VECTOR3_HDRS)
	$(FBC) $(FBCFLAGS) -lib $(SIMPLE_VECTOR3_SRCS) -x $@

$(POINTER_VEC2_LIBRARY): $(POINTER_VEC2_SRCS) $(POINTER_VEC2_HDRS)
	$(FBC) $(FBCFLAGS) -lib $(POINTER_VEC2_SRCS) -x $@

$(VECTORS_LIBRARY): $(VECTORS_SRCS) $(VECTORS_HDRS)
	$(FBC) $(FBCFLAGS) -lib $(VECTORS_SRCS) -x $@

tests/%.o: tests/%.bas $(HDRS) $(TEST_HDRS) $(LIBRARIES)
	$(FBC) $(FBCFLAGS) -m tests -c $< -o $@

examples/%.exe: examples/%.bas $(HDRS) $(LIBRARIES)
	$(FBC) $(FBCFLAGS) $< -p ./lib -p ./fbcunit/lib -x $@

$(TEST_EXE): $(TEST_OBJS) $(LIBRARIES) fbcunit
	$(FBC) $(FBCFLAGS) $(TEST_OBJS) -p ./lib -p ./fbcunit/lib -x $@

.PHONY: clean
clean:
	-rm -f $(LIBRARIES)
	-rm -f $(TEST_OBJS) $(TEST_EXE)
	-rm -f $(EXAMPLES)
	$(MAKE) -C fbcunit -f makefile clean
