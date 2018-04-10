HDRS := $(wildcard ../inc/*.bi)
HDRS += $(wildcard *.bi)

LIBS += $(wildcard ../lib/*.a )

VFONT_SRCS := vfont.bas
VFONT_SRCS += hershey_file.bas

MKFONT_SRCS := mkfont.bas
MKFONT_SRCS += hershey_file.bas

.phony: all
all: vfont.exe mkfont.exe

vfont.exe: $(VFONT_SRCS) $(HDRS) $(LIBS)
	fbc -mt -i ../inc -p ../lib -g -exx $(VFONT_SRCS) -x $@

mkfont.exe: $(MKFONT_SRCS) $(HDRS) $(LIBS)
	fbc -mt -i ../inc -p ../lib -g -exx $(MKFONT_SRCS) -x $@

.phony: clean
clean:
	-rm vfont.exe mkfont.exe
