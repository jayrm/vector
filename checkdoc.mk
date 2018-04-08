LIBS := $(wildcard lib/*.a)
INCS := $(wildcard inc/*.bi)

FBC := fbc
DIFF := diff

GETEX := checks/getex.exe

DIFFS := checks/simple_vector2.diff

FBCFLAGS := -g -exx -p lib -i inc -mt

.phony: all
all: $(DIFFS)

###

checks/getex.exe: checks/getex.bas $(LIBS) $(INCS)
	$(FBC) $(FBCFLAGS) $< -x $@

###

checks/chksv2.bas: doc/simple_vector2.txt $(GETEX)
	$(GETEX) $< $@ $(@:.bas=.txt) "simple_vector2"

checks/chksv2.txt: checks/chksv2.bas

checks/chksv2.exe: checks/chksv2.bas $(LIBS) $(INCS)
	$(FBC) $(FBCFLAGS) $< -x $@

checks/chksv2.log: checks/chksv2.exe
	$< > $@
	
checks/simple_vector2.diff: checks/chksv2.txt checks/chksv2.log
	$(DIFF) -u $^


###

.phony: clean
clean:
	-rm -f $(DIFFS)
	-rm -f checks/getex.exe
	-rm -f checks/chkpv2.bas checks/chkpv2.txt checks/chkpv2.log checks/chkpv2.exe
	-rm -f checks/chksv2.bas checks/chksv2.txt checks/chksv2.log checks/chksv2.exe
	-rm -f checks/chksv3.bas checks/chksv3.txt checks/chksv3.log checks/chksv3.exe
	-rm -f checks/chkvv2.bas checks/chkvv2.txt checks/chkvv2.log checks/chkvv2.exe
	-rm -f checks/chkvv3.bas checks/chkvv3.txt checks/chkvv3.log checks/chkvv3.exe
