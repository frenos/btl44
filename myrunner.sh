#!/bin/bash
#add env vars to config before launching
sed -i "/ServerName=COMMUNITY SERVER/c ServerName=$SERVERNAME" ./DefaultGame.ini
sed -i "/Password=/c Password=$PASSWORD" ./DefaultGame.ini
sed -i "/PlayMode=Arcade/c PlayMode=$PLAYMODE" ./DefaultGame.ini

#insert SteamIDs
IFS=',' read -r -a steamIDSArray <<< "$ADMINSTEAMID"
for steamID in "${steamIDSArray[@]}"
do
    awk '!found && /\+AdminSteamIDs\=/{print;print "+AdminSteamIDs=\"'$steamID'\""; found=1;next} 1' ./DefaultGame.ini > tmp && mv tmp DefaultGame.ini
done
sed -i '0,/+AdminSteamIDs=/{//d}' ./DefaultGame.ini

#finished editing config, lets go

#check if external ip was supplied, otherwise ask amazon what our ip is
if [ -z ${PUBLICIP+x} ]; then PUBLICIP=$(curl checkip.amazonaws.com); else echo "PUBLICIP already set to '$PUBLICIP'"; fi

#Calculate queryport see wiki.battaliongame.com
let QUERY_PORT=SERVER_PORT+3
#Echo configuration#
echo "Starting your Server \"$SERVERNAME\" on port  $PUBLICIP:$SERVER_PORT ..."
echo "We are running with Gamemode $PLAYMODE and password \"$PASSWORD\""
echo "Lets go, remember to bring up issues and feedback at https://github.com/frenos/btl44."
echo "                                                                      - Frenos"
echo "--------------------------------------------------------------------------------------"
./Battalion/Binaries/Linux/BattalionServer /Game/Maps/Final_Maps/Derailed?Game=/Script/ShooterGame.BombGameMode?listen -broadcastip="${PUBLICIP}" -PORT=${SERVER_PORT} -QueryPort=${QUERY_PORT} -log -defgameini="../../../DefaultGame.ini"
