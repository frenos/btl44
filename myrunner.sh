#!/bin/bash
#add env vars to config before launching
sed -i "/ServerName=COMMUNITY SERVER/c ServerName=$SERVERNAME" ./DefaultGame.ini
sed -i "/Password=/c Password=$PASSWORD" ./DefaultGame.ini
sed -i "/PlayMode=Arcade/c PlayMode=$PLAYMODE" ./DefaultGame.ini
sed -i "/+AdminSteamIDs=/c +AdminSteamIDs=\"$ADMINSTEAMID\"" ./DefaultGame.ini
#finished editing config, lets go

#Calculate queryport see wiki.battaliongame.com
let QUERY_PORT=SERVER_PORT+3
#Echo configuration#
echo "Starting your Server \"$SERVERNAME\" on port $SERVER_PORT ..."
echo "We are running with Gamemode $PLAYMODE and password \"$PASSWORD\""
echo "Lets go, remember to bring up issues and feedback at https://github.com/frenos/btl44."
echo "                                                                      - Frenos"
echo "--------------------------------------------------------------------------------------"
./Battalion/Binaries/Linux/BattalionServer /Game/Maps/Final_Maps/Derailed?Game=/Script/ShooterGame.BombGameMode?listen -broadcastip="${PUBLICIP}" -PORT=${SERVER_PORT} -QueryPort=${QUERY_PORT} -log -defgameini="../../../DefaultGame.ini"
