TAG_NAME=helioncf/base-build
all: clean build
build:
	docker build --tag=$(TAG_NAME) .

clean: clean_tagged clean_temp

clean_tagged:
	@$$(docker images | grep "$(TAG_NAME)" | perl -pe 's/ +/ /g' | cut -d " " -f3 | (set -x; xargs docker rmi -f););

clean_temp:
	@$$(docker images | grep "^<none>" | perl -pe 's/ +/ /g' | cut -d " " -f3 | (set -x; xargs docker rmi -f););
