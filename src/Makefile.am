install-exec-hook : %D%/logrd.bash
	$(mkdir_p) $(DESTDIR)$(libdir)
	$(INSTALL_PROGRAM) $(abs_top_srcdir)/%D%/logrd.bash $(DESTDIR)$(libdir)

uninstall-local:
	rm -f $(DESTDIR)$(libdir)/logrd.bash


# extra files to add to the distribution
EXTRA_DIST	+= %D%/logrd.bash

#-------------------------------------------------------------------
# Snippets go after here, unless their docs say otherwise

# this must be an explicit list of man pages; no make variables allowed.
# currently, only section l man pages are supported.

%C%_POD_SFX = .pod
%C%_dist_manl_MANS = %D%/$(PACKAGE).l
%C%_PODS = %D%/$(PACKAGE)
%C%_POD_HTML = %D%/$(PACKAGE).html
%C%_POD_PDF  = %D%/$(PACKAGE).pdf

README_POD = %D%/$(PACKAGE)
README_POD_SFX = .pod

README_MD_POD = %D%/$(PACKAGE)
README_MD_POD_SFX = .pod

include %D%/pod_all.mk
include %D%/pod_readme.mk
include %D%/pod_readme_md.mk
