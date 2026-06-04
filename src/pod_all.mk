##============================================================================
## pod_all.mk - generate documentation from POD input


%C%_POD_ALL_MK =

## this snippets orchestrates the creation of PDF, HTML, and
## UNIX man pages from POD input.  All POD files *must* have names
## which end in .X$(POD_SFX), where X is the UNIX man page section to
## which they belong. The only supported sections are l, 3, 5, and 7.

## Prerequisites:
MST_POD_GEN_DOCS_M4 +=
CREATE_AM_MACROS_MK +=
DOC_DIRS_MK +=


## The caller must define
##  %C%_POD_SFX - the suffix of the pod source file
##  %C%_PODS    - the list of documentation, basenames only
%C%_POD_SFX +=
%C%_PODS    +=

## Because of how automake works, the caller must set all of the
## following which are applicable:
##
## 	 %C%_dist_manl_MANS
##       %C%_dist_man3_MANS
##       %C%_dist_man5_MANS
##       %C%_dist_man7_MANS
##
## to the explicit list of man pages. no makefile variables allowed!

## Note that this implies that all pod source files have the same suffix
## If this is not the case, add rules to create .pod files like so:
##
## %.X.pod : %.xx
##	podselect %< > $@
##
## and set %C%_POD_SFX to .pod.  Just make sure that %.xx is an invariant
## file (i.e. not something created from a .in file).  Usually just using
## the .in file as the source is pretty safe.

## PODS elements should already have a %D% prefix
EXTRA_DIST    += $(%C%_PODS:%=%$(%C%_POD_SFX))

include %D%/create_reldir.mk
include %D%/pod_html.mk
include %D%/pod_man.mk
include %D%/pod_pdf.mk


