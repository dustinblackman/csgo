#!/bin/bash

export SERVER_HOSTNAME="${SERVER_HOSTNAME:-MyCSGO}"
export SERVER_PASSWORD="${SERVER_PASSWORD:-changeme}"
export RCON_PASSWORD="${RCON_PASSWORD:-changeme}"
export STEAM_ACCOUNT="${STEAM_ACCOUNT:-changeme}"
export CSGO_DIR="${CSGO_DIR:-/csgo}"
export PORT="${PORT:-27015}"
export TICKRATE="${TICKRATE:-128}"
export GAME_TYPE="${GAME_TYPE:-0}"
export GAME_MODE="${GAME_MODE:-1}"
export MAP="${MAP:-de_dust2}"
export MAPGROUP="${MAPGROUP:-mg_active}"
export MAXPLAYERS="${MAXPLAYERS:-12}"
export IP="${IP:-0.0.0.0}"

cd $CSGO_DIR

tee -a "$CSGO_DIR/csgo/cfg/server.cfg" << END
hostname "$SERVER_HOSTNAME"
rcon_password "$RCON_PASSWORD"
sv_password "$SERVER_PASSWORD"
sv_lan 0
sv_cheats 0
END

./srcds_run \
    -console \
    -usercon \
    -game csgo \
    -tickrate $TICKRATE \
    -port $PORT \
    -maxplayers_override $MAXPLAYERS \
    +game_type $GAME_TYPE \
    +game_mode $GAME_MODE \
    +mapgroup $MAPGROUP \
    +map $MAP \
    +ip $IP \
    +sv_setsteamaccount $STEAM_ACCOUNT
