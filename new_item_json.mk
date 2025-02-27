define NEW_ITEM_JSON_HEAD
{
	"model": {
		"type": "range_dispatch",
		"property": "custom_model_data",
		"fallback": {
			"type": "model",
			"model": "minecraft:item/gold_pickaxe"
		},
		"entries": [
endef

define NEW_ITEM_JSON_LINE
			{
				"threshold": \1,
				"model": {
					"type": "range_dispatch",
					"property": "damage",
					"fallback": {
						"type": "model",
						"model": "minecraft:item\/gold_pickaxe"
					},
					"entries": \[
						{
							"threshold": 0.9696969696969697,
							"model": {
								"type": "model",
								"model": "\2"
							}
						}
					\]
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
