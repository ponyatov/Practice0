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
