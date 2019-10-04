.DEFAULT_GOAL := update
SHELL := /bin/bash

build:
	@docker build -t dustinblackman/csgo:latest -t "dustinblackman/csgo:$$(cat version)" .

update-version:
	@rm -f version
	@curl -L -s -H 'Referer: https://steamdb.info/app/740/history/' 'https://steamdb.info/api/GetAppHistory/?lastentry=0&appid=740' | jq -r -c .data.Rendered | grep 'Changelist' | head -n 1 | awk -F'[#<]' '{print $$3}' > version

update: update-version
	git add version
	git commit -m "Update to $$(cat version)"
	git tag -a "$$(cat version)" -m "Updated to version $$(cat version). https://steamdb.info/app/740/history/"
	git push origin --tags
