.DEFAULT_GOAL := build
SHELL := /bin/bash

build:
	docker build -t dustinblackman/csgo:latest -t "dustinblackman/csgo:$$(cat version)" .

commit-update: update
	git add version
	git commit -m "Update to $$(cat version)"
	git tag -a "$$(cat version)" -m "Updated to version $$(cat version). https://steamdb.info/app/740/history/"
	git push --follow-tags --set-upstream origin "$$(git symbolic-ref --short HEAD)"

docker:
	docker build -t dustinblackman/csgo:latest -t "dustinblackman/csgo:$$(cat version)" .
	docker push dustinblackman/csgo:latest
	docker push "dustinblackman/csgo:$$(cat version)"

docker-ci:
	(docker build -t dustinblackman/csgo:latest -t "dustinblackman/csgo:$$(cat version)" . & PID=$$!; while [ -d "/proc/$$PID" ]; do echo "." && sleep 300; done) | while read line; do echo "$$(date)| $$line"; done;
	@docker push dustinblackman/csgo:latest & PID=$$!; while [ -d "/proc/$$PID" ]; do echo "." && sleep 300; done;
	docker push "dustinblackman/csgo:$$(cat version)"

update:
	@rm -f version
	@curl -L -s \
		-H 'Referer: https://steamdb.info/app/740/history/' \
		-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:77.0) Gecko/20100101 Firefox/77.0' \
		'https://steamdb.info/api/GetAppHistory/?lastentry=0&appid=740' | jq -r -c .data.Rendered | grep 'Changelist' | head -n 1 | awk -F'[#<]' '{print $$3}' > version
