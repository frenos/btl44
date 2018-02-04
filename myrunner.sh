#!/bin/bash

#Calculate queryport see wiki.battaliongame.com
let QUERY_PORT=SERVER_PORT+3
./Battalion/Binaries/Linux/BattalionServer /Game/Maps/Final_Maps/Derailed?Game=/Script/ShooterGame.BombGameMode?listen -broadcastip="${PUBLICIP}" -PORT=${SERVER_PORT} -QueryPort=${QUERY_PORT} -log -defgameini="../../../DefaultGame.ini"