.PHONY: hoganfam_trains.zip

hoganfam_trains.zip:
	rm -f "$@"
	cd res && zip -r "../$@" assets/ pack.mcmeta  pack.png
