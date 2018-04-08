LIBS := $(wildcard lib/*.a)
INCS := $(wildcard inc/*.bi)

FBC := fbc
DIFF := diff

GETEX := checks/getex.exe

DOCFILES := doc/simple_vector2.txt
DOCFILES += doc/simple_vector3.txt
DOCFILES += doc/pointer_vec2.txt
DOCFILES += doc/vectors.txt
DOCFILES += doc/vectors_vector2.txt
DOCFILES += doc/vectors_vector3.txt

BASFILES := $(patsubst %.txt,checks/chk-%.bas,$(notdir $(DOCFILES)))
TXTFILES := $(BASFILES:.bas=.txt)
EXEFILES := $(BASFILES:.bas=.exe)
LOGFILES := $(BASFILES:.bas=.log)
DIFFILES := $(BASFILES:.bas=.diff)

FBCFLAGS := -g -exx -p lib -i inc -mt

.phony: all
all: $(DIFFILES)

$(GETEX): checks/getex.bas
	@$(FBC) $(FBCFLAGS) $< -x $@

$(DIFFILES): checks/chk-%.diff: checks/chk-%.txt checks/chk-%.log
	@$(DIFF) -u $^

$(BASFILES): checks/chk-%.bas: doc/%.txt $(GETEX)
	$(GETEX) $< $@ $(@:.bas=.txt)

$(EXEFILES): checks/chk-%.exe: checks/chk-%.bas $(LIBS) $(INCS)
	@$(FBC) $(FBCFLAGS) $< -x $@

$(TXTFILES): checks/chk-%.txt: checks/chk-%.exe

$(LOGFILES): checks/chk-%.log: checks/chk-%.exe
	@$< > $@

###

.phony: clean
clean:
	-rm -f $(BASFILES) $(TXTFILES) $(EXEFILES) $(LOGFILES) $(DIFFILES)
	-rm -f checks/getex.exe
