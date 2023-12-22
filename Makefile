RESOURCE_PACK := hoganfam_trains.zip

JAVA2BEDROCK := $(PWD)/java2bedrock.sh
JAVA2BEDROCK_CONVERTER := $(JAVA2BEDROCK)/converter.sh
BEDROCK_DIR := .bedrock
BEDROCK_RESOURCE_PACK := hoganfam_trains_bedrock.mcpack
GEYSER_MAPPINGS := hoganfam_trains_mappings.json
ifneq ($(shell test -x $(JAVA2BEDROCK_CONVERTER) && echo x),)
BEDROCK_TARGETS += $(BEDROCK_RESOURCE_PACK)
endif

RES_SRC := res
RES_GEN := .res.gen

YML_FILES += srv/hoganfam_trains.yml
YML_FILES += srv/hoganfam_trains_lite.yml

YML_IN_FILES := $(YML_FILES:.yml=.yml.in)

DEPDIR := .deps
$(shell mkdir -p $(DEPDIR) >/dev/null)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td

all: $(RESOURCE_PACK)
all: $(YML_FILES)
all: $(BEDROCK_TARGETS)

TEXTURE_DIR := assets/minecraft/textures
MODEL_DIR := assets/minecraft/models
TC_PATH := item/amalon/tc

# Find skin textures, PNGs in a subdirectory under trains
SKIN_TEXTURES := $(patsubst $(RES_SRC)/$(TEXTURE_DIR)/%.png,%,$(wildcard $(RES_SRC)/$(TEXTURE_DIR)/item/amalon/tc/*/*/*.png))
# Find the skin names
SKIN_TEXTURE_DIRS := $(patsubst $(RES_SRC)/$(TEXTURE_DIR)/%,%,$(wildcard $(RES_SRC)/$(TEXTURE_DIR)/item/amalon/tc/*/*/))
SKINS := $(patsubst %/,%,$(filter $(dir $(SKIN_TEXTURES)),$(SKIN_TEXTURE_DIRS)))
# Find base textures that are overridden by skins
SKIN_BASES := $(foreach skin,$(SKIN_TEXTURES),$(patsubst %/,%,$(dir $(patsubst %/,%,$(dir $(skin)))))/$(notdir $(skin)))

# Find models which use these base textures
SKIN_BASE_MODELS := $(patsubst $(RES_SRC)/$(MODEL_DIR)/%,%,$(shell grep -Fl $(foreach base,$(SKIN_BASES),-e $(base)) -r $(RES_SRC)/$(MODEL_DIR)/$(TC_PATH)/))
# Construct skin model names for each skin
SKIN_MODELS := $(foreach base,$(SKIN_BASE_MODELS),$(foreach skin,$(filter $(dir $(base))%,$(SKINS)),$(skin)/$(notdir $(base))))

# Construct skin model file names
SKIN_MODEL_GEN := $(foreach model,$(SKIN_MODELS),$(RES_GEN)/$(MODEL_DIR)/$(model))

# Construct skin model wrappers
pc := %
.SECONDEXPANSION:
$(RES_GEN)/$(MODEL_DIR)/%.json: $$(patsubst $(RES_GEN)/$$(pc),$(RES_SRC)/$$(pc),$$(dir $$(patsubst $$(pc)/,$$(pc),$$(dir $$@))))$$(notdir $$@)
	@echo 'GEN $@'
	@mkdir -p '$(dir $@)'
	@echo '{' > '$@.tmp'
	@echo '	"parent": "$(dir $(patsubst %/,%,$(dir $(patsubst $(RES_GEN)/$(MODEL_DIR)/%,%,$@))))$(patsubst %.json,%,$(notdir $@))",' >> '$@.tmp'
	@echo '	"textures": {' >> '$@.tmp'
	@sed -n '/^\t"textures"/,//{/^\t\t/p;/^\t\}/q}' '$<' | \
		sed $(foreach base,$(SKIN_BASES),-e 's/$(subst /,\/,$(patsubst $(RES_SRC)/$(MODEL_DIR)/%,%,$(dir $<))$(notdir $(base)))/$(subst /,\/,$(patsubst $(RES_GEN)/$(MODEL_DIR)/%,%,$(dir $@))$(notdir $(base)))/') -e 's/,$$//' -e '$$ ! s/$$/,/' >> '$@.tmp'
	@echo '	}' >> '$@.tmp'
	@echo '}' >> '$@.tmp'
	@mv '$@.tmp' '$@'

.PHONY: $(RESOURCE_PACK)
$(RESOURCE_PACK): $(SKIN_MODEL_GEN)
	rm -f "$@"
	cd $(RES_SRC) && zip -r '../$@.tmp' assets/ pack.mcmeta  pack.png
	cd $(RES_GEN) && zip -g -r '../$@.tmp' $(patsubst $(RES_GEN)/%,'%',$(SKIN_MODEL_GEN))
	mv '$@.tmp' '$@'

$(BEDROCK_RESOURCE_PACK): $(RESOURCE_PACK)
	@mkdir -p $(BEDROCK_DIR)
	rm -f $@
	rm -fr $(BEDROCK_DIR)/config.json $(BEDROCK_DIR)/target
	cd $(BEDROCK_DIR) && $(JAVA2BEDROCK_CONVERTER) ../$(RESOURCE_PACK) -w false -m null -a entity_alphatest_one_sided -b alpha_test -f null
	mv $(BEDROCK_DIR)/target/geyser_mappings.json $(GEYSER_MAPPINGS)
	mv $(BEDROCK_DIR)/target/packaged/geyser_resources.mcpack $(BEDROCK_RESOURCE_PACK)

include $(wildcard $(patsubst %,$(DEPDIR)/%.d,$(basename $(YML_FILES))))

%.yml: %.yml.in
%.yml: %.yml.in $(DEPDIR)%.d
	@mkdir -p $(dir $(DEPDIR)/$*.Td)
	cpp $(DEPFLAGS) "$<" -o "$@"
	@mv -f "$(DEPDIR)/$*.Td" "$(DEPDIR)/$*.d" && touch "$@"
	@sed -i -e '/^\s*\(#.*\)\?$$/d' "$@"

clean:
	rm -f $(RESOURCE_PACK)
	rm -f $(YML_FILES)
	rm -fr $(RES_GEN)
	rm -fr $(DEPDIR)
	rm -f $(BEDROCK_RESOURCE_PACK) $(GEYSER_MAPPINGS)
	rm -fr $(BEDROCK_DIR)/config.json $(BEDROCK_DIR)/target

%.d: ;
.PRECIOUS: $(DEPDIR)/%.d
