#============================================================================
# pod_readme.mk

POD_README_MK =

# Prerequisites:
CREATE_AM_MACROS_MK +=

#----------------------------------------
# caller must define these
#
# The  file used for README, without a suffix. Must be defined by caller.

README_POD +=

# the suffix of the files containing POD
README_POD_SFX +=

if MST_POD_GEN_DOCS_README

SUFFIXES += $(README_POD_SFX)

README : $(README_POD)$(README_POD_SFX)
	pod2readme $< $@

else !MST_POD_GEN_DOCS_README

# can't create documentation.  for end user, the distributed
# documentation will get installed.

# for maintainer, must create fake docs or make will fail,
# but don't distribute


README:
	touch $@

DIST_HOOKS += POD_README_FALSE_DIST_HOOK
.PHONY: POD_README_FALSE_DIST_HOOK
POD_README_FALSE_DIST_HOOK:
	echo >&2 "Cannot create distribution as cannot create README documentation"
	echo >&2 "Install pod2readme (from CPAN)"
	false

endif !MST_POD_GEN_DOCS_README

BUILT_SOURCES += README
EXTRA_DIST += README $(README_POD)$(README_POD_SFX)
