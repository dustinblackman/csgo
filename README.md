# csgo

Simple Dockerfile that bundles [CS:GO Server](https://steamdb.info/app/740/). Images are versioned based on the [history](https://steamdb.info/app/740/history/) of the app on Steam. A [`start.sh`](./csgo/start.sh) script is provided to help get you up and running quickly, otherwise you can call `/csgo/srcds_run` directly.

The goal of this image is for one off spawning CS:GO servers, rather then something you maintain and update. This means that updates are not layered, the image is rebuilt from scratch for every update.

## Usage

The following will start up a public server. You can generate your steam account key [here](https://steamcommunity.com/dev/managegameservers). See [`start.sh`](./csgo/start.sh) for other environment variable options.

```
  docker run -it -p 27015:27015 -p 27015:27015/udp -e STEAM_ACCOUNT=KEY_HERE dustinblackman/csgo:latest
```
