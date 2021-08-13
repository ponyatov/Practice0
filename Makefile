# \ var
# detect module/project name by current directory
MODULE  = $(notdir $(CURDIR))
# detect OS name (only Linux in view)
OS      = $(shell uname -s)
# current date in the `ddmmyy` format
NOW     = $(shell date +%d%m%y)
# release hash: four hex digits (for snapshots)
REL     = $(shell git rev-parse --short=4 HEAD)
# number of CPU cores (for parallel builds)
CORES   = $(shell grep processor /proc/cpuinfo| wc -l)
# / var

# \ dir
# current (project) directory
CWD     = $(CURDIR)
# documentation & external manuals downloads
DOC     = $(CWD)/doc
# source code (not for all languages, Rust/C included)
SRC     = $(CWD)/src
# temporary/generated files
TMP     = $(CWD)/tmp
# / dir

# \ tool
# http/ftp download tool
CURL    = curl -L -o
JAVA    = $(which java)
JAVAC   = $(which javac)
ANTLR   = $(which antlr4)
# / tool

# \ cfg
JFLAGS += -source 8 -target 1.8
# / cfg



P0    = ../Practice0
TEST  = $(P0)/Test
ABOUT = $(TEST)/about.me

AUTHOR = "Dmitry Ponyatov"
UNIVERCITY = "SSAU"
YEAR = 2003

.PHONY: all
all:
	$(MAKE) dirs
	$(MAKE) $(ABOUT)
	$(MAKE) move about year56 year7 cmp

# p.1,2
.PHONY: dirs
dirs:
	mkdir -p $(P0) $(TEST)

# p.2
$(ABOUT):
	echo $(AUTHOR) > $@
	echo $(UNIVERCITY) >> $@

# p.3
.PHONY: move
move: $(P0)/about.me
$(P0)/about.me: $(ABOUT)
	mv $< $@ && chmod -w $@

# p.4
.PHONY: about
about: $(P0)/about.me
	echo `head -n1 $<` "учился в" `tail -n1 $<`

# p.5,6
.PHONY: year56
year56: $(TEST)/about_.me
$(TEST)/about_.me: $(P0)/about.me
	cp $< $@ && touch $@
	chmod +w $@ ; echo $(YEAR) >> $@

# p.7
.PHONY: year7
year7: $(P0)/about.me
	chmod +w $< ; echo $(YEAR) >> $<

# p.8
.PHONY: cmp
cmp: $(P0)/about.me $(TEST)/about_.me
	fc $^


.PHONY: install $(OS)_install
install: $(OS)_install
$(OS)_install:
	sudo apt update
	sudo apt install -u `cat apt.txt`

MERGE  = Makefile README.md apt.txt .gitignore .vscode $(S)

.PHONY: dev
dev: ponymuck
	git checkout $@
	git checkout ponymuck -- $(MERGE)

.PHONY: ponymuck
ponymuck:
	git checkout $@
