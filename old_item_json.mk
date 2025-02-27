define OLD_ITEM_JSON_HEAD
{
	"parent": "item/handheld",
	"textures": {
		"layer0": "item/gold_pickaxe"
	},
	"overrides": [
		{"predicate": {"damage": 0}, "model": "item/golden_pickaxe"},
endef

define OLD_ITEM_JSON_LINE
		{"predicate": {"damaged": 0, "damage": 0.9696969696969697, "custom_model_data":\1}, "model": "\2"},
endef

define OLD_ITEM_JSON_TAIL
		{"predicate": {"damaged": 1}, "model": "item/golden_pickaxe"}
	]
}
endef

export OLD_ITEM_JSON_HEAD
export OLD_ITEM_JSON_LINE
export OLD_ITEM_JSON_TAIL
