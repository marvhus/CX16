SUBDIRS := $(wildcard [0-9][0-9][0-9])

.PHONY: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ run
