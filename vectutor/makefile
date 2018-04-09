MAIN := vectutor

SRCS := $(MAIN).bas
SRCS += mouse.bas
SRCS += ogl_draw.bas
SRCS += ogl_font.bas
SRCS += ogl_stuff.bas
SRCS += timer.bas
SRCS += trig.bas
SRCS += vectutor_circle.bas
SRCS += vectutor_angle.bas
SRCS += vectutor_color.bas
SRCS += vectutor_hull.bas
SRCS += vectutor_line.bas
SRCS += vectutor_misc.bas
SRCS += vectutor_points.bas
SRCS += vectutor_triangle.bas

HDRS := $(wildcard ../inc/*.bi)

.phony: all
all: $(MAIN).exe

$(MAIN).exe: $(SRCS) $(HDRS) $(LIBS)
	fbc -mt -i ../inc -p ../lib -g -exx $(SRCS) -x $@

.phony: clean
clean:
	-rm $(MAIN).exe
