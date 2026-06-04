#============================================================================
# pod_readme_md.mk

POD_README_MD_MK =

# Prerequisites:
CREATE_AM_MACROS_MK +=


#----------------------------------------
# caller must define these
#

# The  file used for README.md, without a suffix. Must be defined by caller.
README_MD_POD +=

# the suffix of the files containing POD
README_MD_POD_SFX +=

# Only attempt to generate documentation if we can.  Always
# distribute it; this will cause failure on devel systems without
# pod2readme_md, but that's ok.


if MST_POD_GEN_DOCS_README_MD

SUFFIXES += $(README_MD_POD_SFX)

README.md : $(README_MD_POD)$(README_MD_POD_SFX)
	pod2markdown $< $@

else !MST_POD_GEN_DOCS_README_MD

# can't create documentation.  for end user, the distributed
# documentation will get installed.

# for maintainer, must create fake docs or make will fail,
# but don't distribute


README.md:
	touch $@

DIST_HOOKS += POD_README_MD_FALSE_DIST_HOOK
.PHONY: POD_README_MD_FALSE_DIST_HOOK
POD_README_MD_FALSE_DIST_HOOK:
	echo >&2 "Cannot create distribution as cannot create README.md documentation"
	echo >&2 "Install pod2markdown (from CPAN)"
	false

endif !MST_POD_GEN_DOCS_README_MD

BUILT_SOURCES += README.md
EXTRA_DIST += README.md $(README_MD_POD)$(README_MD_POD_SFX)
