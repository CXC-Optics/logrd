%C%_CREATE_RELDIR_MK =

## prerequesites:

CREATE_AM_MACROS_MK +=

BUILT_SOURCES += %D%/$(mst__dirstamp)
CLEANFILES    += %D%/$(mst__dirstamp)


%D%/$(mst__dirstamp):
	@$(MKDIR_P) %D%
	@: > %D%/$(mst__dirstamp)
