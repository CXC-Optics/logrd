##============================================================================
## create_am_macros.mk

CREATE_AM_MACROS_MK =

include %D%/am_vars.mk
include %D%/inst_vars.mk

# automake uses $(PACKAGE)-$(VERSION), but if we change $(PACKAGE) to include
# a version (e.g. gtk+-2.0, gtk+-3.0) so that parallel installs are possible,
# the distribution looks like gtk+-2.0-2.x.x, which is bonkers.
distdir = $(PACKAGE_TARNAME)-$(VERSION)

##-------------------------------------------------------------------
## The following must ALWAYS be defined, as certain makefile snippets
## require them.  If you get errors like
##
##  EXTRA_DIST must be set with `=' before using `+='
##
## we've missed defining one here.

## programs
bin_PROGRAMS		=

## distributed scripts
bin_SCRIPTS		=

## distributed scripts
dist_bin_SCRIPTS	=

## local build scripts
noinst_SCRIPTS		=

## local headers
noinst_HEADERS		=

## convenience libraries
noinst_LTLIBRARIES	=

noinst_DATA		=

## libtool libraries
lib_LTLIBRARIES		=
pkglib_LTLIBRARIES	=

## sysconf
sysconf_DATA		=

## perl libs
perllibdir		= @perllibdir@
perllib_DATA		=

## installed headers
include_HEADERS		=
pkginclude_HEADERS	=
nobase_include_HEADERS	=
nobase_pkginclude_HEADERS	=

AM_CPPFLAGS             =

## -----------------------
## Test stuff

AM_TESTS_ENVIRONMENT    =
TESTS			=
TESTS_ENVIRONMENT	=
TEST_EXTENSIONS		=
XFAIL_TESTS		=
check_PROGRAMS		=
check_SCRIPTS		=
check_LTLIBRARIES	=

## sources that must be made prior to compilation
BUILT_SOURCES           =

## extra files to add to the distribution
EXTRA_DIST              =

## Files tha make built but that one would want to rebuild
MOSTLYCLEANFILES	=

## Any other files make built
CLEANFILES              =

## Any files configure built
DISTCLEANFILES          =

## Any files maintainer built (with autoconf, automake, etc)
MAINTAINERCLEANFILES    =

## Extra suffixes for automake
SUFFIXES		=

## -----------------------
## Automake hook targets
##
## Keep hook targets single-colon for POSIX make.  Snippets add their
## hook-specific helper targets to these aggregate prerequisite lists.

ALL_LOCAL_HOOKS		=
CHECK_LOCAL_HOOKS	=
CLEAN_LOCAL_HOOKS	=
DIST_HOOKS		=
DISTCLEAN_LOCAL_HOOKS	=
INSTALL_DATA_HOOKS	=
INSTALL_DATA_LOCAL_HOOKS =
INSTALL_EXEC_HOOKS	=
INSTALL_EXEC_LOCAL_HOOKS =
INSTALLCHECK_LOCAL_HOOKS =
MAINTAINER_CLEAN_LOCAL_HOOKS =
UNINSTALL_HOOKS		=
UNINSTALL_LOCAL_HOOKS	=

all-local: $(ALL_LOCAL_HOOKS)
check-local: $(CHECK_LOCAL_HOOKS)
clean-local: $(CLEAN_LOCAL_HOOKS)
dist-hook: $(DIST_HOOKS)
distclean-local: $(DISTCLEAN_LOCAL_HOOKS)
install-data-hook: $(INSTALL_DATA_HOOKS)
install-data-local: $(INSTALL_DATA_LOCAL_HOOKS)
install-exec-hook: $(INSTALL_EXEC_HOOKS)
install-exec-local: $(INSTALL_EXEC_LOCAL_HOOKS)
installcheck-local: $(INSTALLCHECK_LOCAL_HOOKS)
maintainer-clean-local: $(MAINTAINER_CLEAN_LOCAL_HOOKS)
uninstall-hook: $(UNINSTALL_HOOKS)
uninstall-local: $(UNINSTALL_LOCAL_HOOKS)
