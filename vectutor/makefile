MAIN := vectutor

SRCS := vec_test.bas
SRCS += mouse.bas
SRCS += ogl_draw.bas
SRCS += ogl_font.bas
SRCS += ogl_stuff.bas
SRCS += timer.bas
SRCS += trig.bas
SRCS += vec_test_circle.bas
SRCS += vec_test_angle.bas
SRCS += vec_test_color.bas
SRCS += vec_test_hull.bas
SRCS += vec_test_line.bas
SRCS += vec_test_misc.bas
SRCS += vec_test_points.bas
SRCS += vec_test_triangle.bas

HDRS := $(wildcard ../inc/*.bi)

.phony: all
all: vec_test.exe

vec_test.exe: $(SRCS) $(HDRS) $(LIBS)
	fbc -mt -i ../inc -p ../lib -g -exx $(SRCS) -x $@

.phony: clean
clean:
	-rm vec_test.exe
