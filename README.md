# csgo

Simple Dockerfile that bundles [CS:GO Server](https://steamdb.info/app/740/). Images are versioned based on the [history](https://steamdb.info/app/740/history/) of the app on Steam. A [`start.sh`](./csgo/start.sh) script is provided to help get you up and running quickly, otherwise you can call `/csgo/srcds_run` directly.

The goal of this image is for one off spawning CS:GO servers, rather then something you maintain and update. This means that updates are not layered, the image is rebuilt from scratch for every update.

## Usage

The following will start up a public server. You can generate your steam account key [here](https://steamcommunity.com/dev/managegameservers). See [`start.sh`](./csgo/start.sh) for other environment variable options.

```
  docker run -it -p 27015:27015 -p 27015:27015/udp -e STEAM_ACCOUNT=KEY_HERE dustinblackman/csgo:latest
```

## Game Modes

Game modes are configured through the console. Remember you must change maps after changing game types.

__Game Types:__ https://developer.valvesoftware.com/wiki/CSGO_Game_Mode_Commands

__Maps:__ https://totalcsgo.com/maps

The docker image provides quick commands to change game types. The full list can be found [here](https://github.com/dustinblackman/csgo/tree/master/csgo/csgo/cfg).

### Classic

```
  rcon_password PASSWORD
  rcon exec play_classic.cfg
```

### Arms Race

```
  rcon_password PASSWORD
  rcon exec play_armsrace.cfg
```

### Death Match

```
  rcon_password PASSWORD
  rcon exec play_deathmatch.cfg
```

### Other

You can find configs for the rest of the game mode types with the above docs and the configs within the docker image. Quick output:

```
csgo@05d882533007:/csgo/csgo/cfg$ ls -ll | grep gamemode
-rwxr-xr-x 1 csgo csgo   4112 Oct 10 00:01 gamemode_armsrace.cfg
-rwxr-xr-x 1 csgo csgo   4480 Oct 10 00:01 gamemode_casual.cfg
-rwxr-xr-x 1 csgo csgo   4367 Oct 10 00:01 gamemode_competitive.cfg
-rwxr-xr-x 1 csgo csgo   4333 Oct 10 00:01 gamemode_competitive2v2.cfg
-rwxr-xr-x 1 csgo csgo   1436 Oct 10 00:01 gamemode_cooperative.cfg
-rwxr-xr-x 1 csgo csgo   3197 Oct 10 00:01 gamemode_coopmission.cfg
-rwxr-xr-x 1 csgo csgo   3729 Oct 10 00:01 gamemode_custom.cfg
-rwxr-xr-x 1 csgo csgo   4443 Oct 10 00:01 gamemode_deathmatch.cfg
-rwxr-xr-x 1 csgo csgo   4716 Oct 10 00:01 gamemode_demolition.cfg
-rwxr-xr-x 1 csgo csgo   5364 Oct 10 00:01 gamemode_survival.cfg
-rwxr-xr-x 1 csgo csgo   4205 Oct 10 00:01 gamemode_teamdeathmatch.cfg
-rwxr-xr-x 1 csgo csgo   3543 Oct 10 00:01 gamemode_training.cfg
```

```
  rcon_password PASSWORD
  rcon game_type ID
  rcon game_mode ID
  rcon exec FILE
  rcon changelevel de_dust2
```
