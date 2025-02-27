RESOURCE_PACK := hoganfam_trains.zip

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

TEXTURE_DIR := assets/minecraft/textures
MODEL_DIR := assets/minecraft/models
OLD_ITEMS_DIR := $(MODEL_DIR)/item
NEW_ITEMS_DIR := assets/minecraft/items
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

# The item json file has moved directory
OLD_ITEM_JSON_GEN := $(RES_GEN)/$(OLD_ITEMS_DIR)/golden_pickaxe.json
NEW_ITEM_JSON_GEN := $(RES_GEN)/$(NEW_ITEMS_DIR)/golden_pickaxe.json
JSON_ITEMS_GEN := $(OLD_ITEM_JSON_GEN) $(NEW_ITEM_JSON_GEN)

# Get defines for generating item json files
include old_item_json.mk new_item_json.mk

# Join lines together ready for use in sed
define \n


endef
OLD_ITEM_JSON_LINE := $(subst ${\n},\n,$(OLD_ITEM_JSON_LINE))
NEW_ITEM_JSON_LINE := $(subst ${\n},\n,$(NEW_ITEM_JSON_LINE))

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
		grep -F $(foreach base,$(SKIN_BASES),-e $(base)) | \
		sed -e 's/$(subst /,\/,$(patsubst $(RES_SRC)/$(MODEL_DIR)/%,%,$(dir $<)))/$(subst /,\/,$(patsubst $(RES_GEN)/$(MODEL_DIR)/%,%,$(dir $@)))/' -e 's/,$$//' -e '$$ ! s/$$/,/' >> '$@.tmp'
	@echo '	}' >> '$@.tmp'
	@echo '}' >> '$@.tmp'
	@mv '$@.tmp' '$@'

# Item json file for versions < 1.21.4
$(OLD_ITEM_JSON_GEN): custom_models.csv old_item_json.mk
	@echo 'GEN $@'
	@mkdir -p '$(dir $@)'
	@echo "$$OLD_ITEM_JSON_HEAD" > '$@.tmp'
	@sed "s/^\(.*\),\(.*\)$$/$$OLD_ITEM_JSON_LINE/" < '$<' >> '$@.tmp'
	@echo "$$OLD_ITEM_JSON_TAIL" >> '$@.tmp'
	@mv '$@.tmp' '$@'

# Item json file for versions >= 1.21.4
$(NEW_ITEM_JSON_GEN): custom_models.csv new_item_json.mk
	@echo 'GEN $@'
	@mkdir -p '$(dir $@)'
	@echo "$$NEW_ITEM_JSON_HEAD" > '$@.tmp'
	@sed "s/^\(.*\),\(.*\)$$/$$NEW_ITEM_JSON_LINE/" < '$<' | sed '$$s/,$$//' >> '$@.tmp'
	@echo "$$NEW_ITEM_JSON_TAIL" >> '$@.tmp'
	@mv '$@.tmp' '$@'

.PHONY: $(RESOURCE_PACK)
$(RESOURCE_PACK): $(SKIN_MODEL_GEN) $(JSON_ITEMS_GEN)
	rm -f "$@"
	cd $(RES_SRC) && zip -r '../$@.tmp' assets/ pack.mcmeta  pack.png
	cd $(RES_GEN) && zip -g -r '../$@.tmp' $(patsubst $(RES_GEN)/%,'%',$(SKIN_MODEL_GEN) $(JSON_ITEMS_GEN))
	mv '$@.tmp' '$@'

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

%.d: ;
.PRECIOUS: $(DEPDIR)/%.d
