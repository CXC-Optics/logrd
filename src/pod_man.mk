##============================================================================
## pod_man.mk
## May be multiply included

%C%_POD_MAN_MK =

## Prerequisites:
INST_VARS_MK += 
%C%_POD_ALL_MK +=
DOC_MAN_INIT_MK +=

#----------------------------------------

## Variables required:
##
## see pod_man_init.mk
##
##  POD?SFX
##    may be empty.  explicit suffix for .? files. used in conjunction
##    with POD_SFX

%C%_POD_MAN		=			\
		$(%C%_dist_manl_MANS)		\
		$(%C%_dist_man3_MANS)		\
		$(%C%_dist_man5_MANS)		\
		$(%C%_dist_man7_MANS)

dist_manl_MANS += $(%C%_dist_manl_MANS)
dist_man3_MANS += $(%C%_dist_man3_MANS)
dist_man5_MANS += $(%C%_dist_man5_MANS)
dist_man7_MANS += $(%C%_dist_man7_MANS)


if MST_POD_GEN_DOCS_MAN

MAINTAINERCLEANFILES	+= $(%C%_POD_MAN)

CLEANFILES		+= $(%C%_POD_MAN)

SUFFIXES +=					\
	$(PODL_SFX) $(PODL_SFX)$(%C%_POD_SFX)	\
	$(POD3_SFX) $(POD3_SFX)$(%C%_POD_SFX)	\
	$(POD5_SFX) $(POD5_SFX)$(%C%_POD_SFX)	\
	$(POD7_SFX) $(POD7_SFX)$(%C%_POD_SFX)

## e.g. create foo.l from foo.pod
$(%C%_POD_SFX).l:
	p="$@"; $(mst__mkdir_p)
	pod2man --name=`basename $< $(%C%_POD_SFX)` \
		--section=l --release=' ' --center=' ' $< > $@

## e.g. create foo.l from foo.l.pod
$(PODL_SFX)$(%C%_POD_SFX).l:
	p="$@"; $(mst__mkdir_p)
	pod2man --name=`basename $< $(PODL_SFX)$(%C%_POD_SFX)` \
		--section=l --release=' ' --center=' ' $< > $@

$(POD3_SFX)$(%C%_POD_SFX).3:
	p="$@"; $(mst__mkdir_p)
	pod2man --name=`basename $< $(POD3_SFX)$(%C%_POD_SFX)` \
		--section=3 --release=' ' --center=' ' $< > $@

$(POD5_SFX)$(%C%_POD_SFX).5:
	p="$@"; $(mst__mkdir_p)
	pod2man --name=`basename $< $(POD5_SFX)$(%C%_POD_SFX)` \
		--section=5 --release=' ' --center=' ' $< > $@

$(POD7_SFX)$(%C%_POD_SFX).7:
	p="$@"; $(mst__mkdir_p)
	pod2man --name=`basename $< $(POD7_SFX)$(%C%_POD_SFX)` \
		--section=7 --release=' ' --center=' ' $< > $@


endif MST_POD_GEN_DOCS_MAN


