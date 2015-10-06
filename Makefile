TAG_NAME=helioncf/base-build
all: clean build
build:
	docker build --tag=$(TAG_NAME) .

clean: clean_temp clean_tagged

clean_tagged:
	@image_ids=$$(docker images | grep "$TAG_NAME" | perl -pe 's/ +/ /g' | cut -d' ' -f3); \
	if [ "X$$image_ids" != X ]; then \
		(set -x; docker rmi "$$image_ids"); \
	fi

clean_temp:
	@image_ids=$$(docker images | grep "^<none>" | perl -pe 's/ +/ /g' | cut -d' ' -f3); \
	if [ "X$$image_ids" != X ]; then \
		(set -x; docker rmi "$$image_ids"); \
	fi
