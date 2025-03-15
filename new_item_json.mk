define NEW_ITEM_JSON_HEAD
{
	"model": {
		"type": "minecraft:range_dispatch",
		"property": "minecraft:custom_model_data",
		"fallback": {
			"type": "minecraft:model",
			"model": "minecraft:item/golden_pickaxe"
		},
		"entries": [
endef

define NEW_ITEM_JSON_LINE
			{
				"threshold": \1,
				"model": {
					"type": "minecraft:model",
					"model": "\2"
				}
			},
endef

define NEW_ITEM_JSON_TAIL
		]
	}
}
endef

export NEW_ITEM_JSON_HEAD
export NEW_ITEM_JSON_LINE
export NEW_ITEM_JSON_TAIL
