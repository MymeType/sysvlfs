# Makefile for LFS
#
# Rewritten by tox <tox@tox.wtf>
# 2026-02-02

-include local.mk

THEMEDIR    ?= stylesheets/lfs-xsl
THEME       ?= light
RENDERTMP   := $(shell mktemp -du 'target/tmp-XXXX')
HTMLDIR     ?= target
DUMPDIR     ?= target/commands
INSTALLROOT ?= $(HOME)/public_html
INSTALLDIR  ?= $(INSTALLROOT)
CHUNK_QUIET ?= 1
SHELL       ?= /usr/bin/env bash

.PHONY: all aux-files validate wget-list dump-commands bootscripts version

ALLXML := $(shell find . -mindepth 1 -name '*.xml' ! -path '$(RENDERTMP)/*')
ALLXSL := $(shell find . -mindepth 1 -name '*.xsl' ! -path '$(RENDERTMP)/*')

ifdef V
  Q =
else
  Q = @
endif

all: $(HTMLDIR)/index.html wget-list md5sums
	$(Q)rm -rf $(RENDERTMP)

clean:
	$(Q)rm -rf target

install:
	$(Q)mkdir -p $(INSTALLDIR)
	$(Q)cp -af $(HTMLDIR) -T $(INSTALLDIR)

$(HTMLDIR)/index.html: $(HTMLDIR) $(RENDERTMP)/lfs-html.xml version
	@echo "Generating chunked XHTML files at $(HTMLDIR)..."
	$(Q)xsltproc --nonet                                    \
                --stringparam chunk.quietly $(CHUNK_QUIET) \
                --stringparam base.dir $(HTMLDIR)/         \
                stylesheets/lfs-chunked.xsl               \
                $(RENDERTMP)/lfs-html.xml
	
	@echo "Copying CSS code and images..."
	$(Q)mkdir -p $(HTMLDIR)/stylesheets
	
	$(Q)cp $(THEMEDIR)/$(THEME).lfs.css $(HTMLDIR)/stylesheets/lfs.css
	$(Q)cp stylesheets/lfs-xsl/lfs-print.css $(HTMLDIR)/stylesheets
	$(Q)sed -i 's|../stylesheet|stylesheet|' $(HTMLDIR)/index.html
	
	$(Q)mkdir -p $(HTMLDIR)/images
	$(Q)cp -af images/* $(HTMLDIR)/images
	$(Q)cd $(HTMLDIR)/; sed -i "s|../images|images|g" *.html
	
	@echo "Running Tidy and obfuscate.sh on chunked XHTML..."
	$(Q)for filename in `find $(HTMLDIR) -name "*.html"`; do       \
      tidy -config tidy.conf $$filename;                          \
      true;                                                       \
      bash obfuscate.sh $$filename;                               \
      sed -i "1,20s|text/html|application/xhtml+xml|g" $$filename; \
   done;

$(RENDERTMP):
	$(Q)mkdir -p $(RENDERTMP)

validate: $(RENDERTMP)/lfs-full.xml

bootscripts: $(RENDERTMP)/bootscripts

$(RENDERTMP)/bootscripts: $(RENDERTMP)
	$(Q)cp -af bootscripts $(RENDERTMP)/bootscripts

$(RENDERTMP)/packages.ent: $(RENDERTMP)
	$(Q)cp -f packages.ent $(RENDERTMP)/packages.ent

aux-files: $(RENDERTMP)/packages.ent $(RENDERTMP)/bootscripts
	@echo "Processing bootscripts..."
	$(Q)./process-scripts.sh
	
	$(Q)RENDERTMP=$(RENDERTMP) ./make-aux-files.sh

$(RENDERTMP)/lfs-full.xml: $(RENDERTMP) general.ent $(RENDERTMP)/packages.ent bootscripts $(ALLXML) $(ALLXSL) version aux-files
	@echo "Rendering the book..."
	$(Q)xsltproc --nonet                               \
                --xinclude                            \
                --output $(RENDERTMP)/lfs-html2.xml   \
                stylesheets/lfs-xsl/profile.xsl       \
                index.xml
	
	@echo "Validating the book..."
	$(Q)xmllint --nonet                            \
               --encode UTF-8                     \
               --postvalid                        \
               --output $(RENDERTMP)/lfs-full.xml \
               $(RENDERTMP)/lfs-html2.xml
	
	$(Q)rm -f appendices/*.script
	$(Q)RENDERTMP=$(RENDERTMP) ./aux-file-data.sh $(RENDERTMP)/lfs-full.xml

$(RENDERTMP)/lfs-html.xml: $(RENDERTMP)/lfs-full.xml version
	@echo "Generating profiled XML for XHTML..."
	$(Q)xsltproc --nonet                              \
                --stringparam profile.condition html \
                --output $(RENDERTMP)/lfs-html.xml   \
                stylesheets/lfs-xsl/profile.xsl      \
                $(RENDERTMP)/lfs-full.xml

DOWNLOADS_DEP = chapter03/packages.xml chapter03/patches.xml \
                packages.ent patches.ent general.ent version

wget-list: $(HTMLDIR)/wget-list

$(HTMLDIR):
	$(Q)mkdir -p $(HTMLDIR)

$(HTMLDIR)/wget-list: stylesheets/wget-list.xsl $(DOWNLOADS_DEP) version
	@echo "Generating wget-list file at $(HTMLDIR)/wget-list..."
	$(Q)xsltproc --nonet                             \
                --xinclude                          \
                --output $(RENDERTMP)/wget-list.xml \
                stylesheets/lfs-xsl/profile.xsl     \
                chapter03/chapter03.xml
	
	$(Q)xsltproc --nonet                       \
                --output $(HTMLDIR)/wget-list \
                stylesheets/wget-list.xsl     \
                $(RENDERTMP)/wget-list.xml

md5sums: $(HTMLDIR)/md5sums

$(HTMLDIR)/md5sums: $(HTMLDIR) $(RENDERTMP) stylesheets/wget-list.xsl $(DOWNLOADS_DEP) version aux-files
	@echo "Generating md5sums file at $(HTMLDIR)/md5sums ..."
	$(Q)xsltproc --nonet                          \
                --xinclude                       \
                --output $(RENDERTMP)/md5sum.xml \
                stylesheets/lfs-xsl/profile.xsl  \
                chapter03/chapter03.xml
	
	$(Q)xsltproc --nonet                     \
                --output $(HTMLDIR)/md5sums \
                stylesheets/md5sum.xsl      \
                $(RENDERTMP)/md5sum.xml
	
	$(Q)RENDERTMP=$(RENDERTMP) ./aux-file-data.sh $(HTMLDIR)/md5sums

version:
	$(Q)./git-version.sh

dump-commands: $(DUMPDIR)

$(DUMPDIR): $(RENDERTMP)/lfs-full.xml version
	@echo "Dumping book commands to $(DUMPDIR)..."
	$(Q)xsltproc --output $(DUMPDIR)/          \
                stylesheets/dump-commands.xsl \
                $(RENDERTMP)/lfs-full.xml

# dist:
# 	$(Q)DIST=/tmp/LFS-RELEASE ./git-version.sh
# 	$(Q)rm -f lfs-$$(</tmp/LFS-RELEASE).tar.xz
# 	$(Q)tar cJf lfs-$$(</tmp/LFS-RELEASE).tar.xz \
# 		$(shell git ls-tree HEAD . --name-only -r) version.ent \
# 		-C /tmp LFS-RELEASE \
# 		--transform "s,^,lfs-$$(</tmp/LFS-RELEASE)/,"
# 	$(Q)echo "Generated XML tarball lfs-$$(</tmp/LFS-RELEASE).tar.xz"
