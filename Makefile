RESOURCE_PACK := hoganfam_trains.zip

YML_FILES += srv/class158/car_1.yml
YML_FILES += srv/class158/bogie.yml
YML_FILES += srv/class158/class158.yml
YML_FILES += srv/hoganfam_trains.yml

YML_IN_FILES := $(YML_FILES:.yml=.yml.in)

DEPDIR := .deps
$(shell mkdir -p $(DEPDIR) >/dev/null)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td

all: $(RESOURCE_PACK)
all: $(YML_FILES)

.PHONY: $(RESOURCE_PACK)
$(RESOURCE_PACK):
	rm -f "$@"
	cd res && zip -r "../$@" assets/ pack.mcmeta  pack.png

include $(wildcard $(patsubst %,$(DEPDIR)/%.d,$(basename $(YML_FILES))))

%.yml: %.yml.in
%.yml: %.yml.in $(DEPDIR)%.d
	@mkdir -p $(dir $(DEPDIR)/$*.Td)
	cpp $(DEPFLAGS) "$<" -o "$@"
	@mv -f "$(DEPDIR)/$*.Td" "$(DEPDIR)/$*.d" && touch "$@"
	@sed -i -e '/^#.*$$/d' "$@"

clean:
	rm -f $(RESOURCE_PACK)
	rm -f $(YML_FILES)
	rm -fr $(DEPDIR)

%.d: ;
.PRECIOUS: $(DEPDIR)/%.d
