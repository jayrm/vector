MAIN := vectutor

SRCS := $(MAIN).bas
SRCS += mouse.bas
SRCS += glscreen.bas
SRCS += ogl_draw.bas
SRCS += ogl_font.bas
SRCS += timer.bas
SRCS += vectutor_main.bas
SRCS += refcount.bas
SRCS += sheet.bas
SRCS += vectutor_color.bas
SRCS += vectutor_basic.bas
SRCS += vectutor_circle.bas
SRCS += vectutor_angle.bas
SRCS += vectutor_hull.bas
SRCS += vectutor_line.bas
SRCS += vectutor_misc.bas
SRCS += vectutor_points.bas
SRCS += vectutor_triangle.bas

OBJS := $(patsubst %.bas,./obj/%.o,$(SRCS))

HDRS := $(wildcard ../inc/*.bi) $(wildcard *.bi)

FBCFLAGS := -m vectutor -mt -i ../inc -p ../lib -g -exx -w pedantic

.phony: all
all: $(MAIN).exe

$(MAIN).exe: $(OBJS) $(LIBS)
	fbc $(FBCFLAGS) $(OBJS) -x $@

./obj/%.o: %.bas $(HDRS)
	fbc -c $< $(FBCFLAGS) -o $@

.phony: clean
clean:
	-rm $(MAIN).exe
	-rm $(OBJS)

