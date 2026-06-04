##============================================================================
# pod_html.mk
## May be included multiple times

%C%_POD_HTML_MK =

## Prerequisites:
CREATE_AM_MACROS_MK +=
%C%_POD_ALL_MK +=

##----------------------------------------
## caller must define these
##
## A simple list of POD files to process.  Just the basename's, no suffix.
## No Make Magic
%C%_PODS +=

## A simple list of the generated HTML files.  No Make Magic!
%C%_POD_HTML +=

## the suffix of the files containing POD
%C%_POD_SFX +=


## Note that this implies that all pod source files have the same suffix
## If this is not the case, add rules to create .pod files like so:
##
## %.pod : %.xx
##	podselect %< > $@
##
## and set POD_SFX to .pod.  Just make sure that %.xx is an invariant
## file (i.e. not something created from a .in file).  Usually just using
## the .in file as the source is pretty safe.

## if the caller is using this file directly (and not going through prog_pod.mk)
## add
##
##   EXTRA_DIST += $(PODS:%=%$(POD_SFX))


## Only attempt to generate documentation if we can.  Always
## distribute it; this will cause failure on devel systems without
## pod2html, but that's ok.


## Any files make built
CLEANFILES		+=			\
			%D%/pod2htmi.tmp	\
			%D%/pod2htmd.tmp


MAINTAINERCLEANFILES	+= $(%C%_POD_HTML)

dist_html_DATA		+= $(%C%_POD_HTML)

if MST_POD_GEN_DOCS_HTML

SUFFIXES += .html $(%C%_POD_SFX)

$(%C%_POD_SFX).html:
	p=$<; p=$(mst__strip_sfx) ; p=$(mst__basename); \
	pod2html --outfile=$@ --infile=$< --cachedir=%D% --title=$$p

CLEANFILES		+= $(%C%_POD_HTML)


else !MST_POD_GEN_DOCS_HTML

## can't create documentation.  for end user, the distributed
## documentation will get installed.

## for maintainer, must create fake docs or make will fail,
## but don't distribute


$(%C%_POD_SFX).html:
	touch $@

DIST_HOOKS += %C%_DIST_HOOK_POD_HTML_FALSE
%C%_DIST_HOOK_POD_HTML_FALSE:
	echo >&2 "Cannot create distribution as cannot create HTML documentation"
	echo >&2 "Install pod2html (from CPAN)"
	false

endif !MST_POD_GEN_DOCS_HTML
