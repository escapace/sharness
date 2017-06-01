prefix = $(HOME)

INSTALL_DIR = $(prefix)/share/sharness
DOC_DIR = $(prefix)/share/doc/sharness
EXAMPLE_DIR = $(DOC_DIR)/examples

INSTALL_FILES = sharness.sh
DOC_FILES = API.md CHANGELOG.md COPYING README.git README.md
EXAMPLE_FILES = test/Makefile test/simple.t

INSTALL = install
RM = rm -f
SED = sed
TOMDOCSH = tomdoc.sh

all:

install: all
	$(INSTALL) -d -m 755 $(INSTALL_DIR) $(DOC_DIR) $(EXAMPLE_DIR)
	$(INSTALL) -m 644 $(INSTALL_FILES) $(INSTALL_DIR)
	$(INSTALL) -m 644 $(DOC_FILES) $(DOC_DIR)
	$(SED) -e "s!. ./sharness.sh!. $(INSTALL_DIR)/sharness.sh!" test/simple.t > $(EXAMPLE_DIR)/simple.t

uninstall:
	$(RM) -r $(INSTALL_DIR) $(DOC_DIR) $(EXAMPLE_DIR)

doc: all
	{ printf "# Sharness API\n\n"; \
	  $(TOMDOCSH) -m -a Public sharness.sh; \
	  printf "Generated by "; $(TOMDOCSH) --version; } >API.md

test: all
	$(MAKE) -C test

.PHONY: all install uninstall doc test
