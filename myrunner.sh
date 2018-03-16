#!/bin/bash

#check if we need to update the server
/steam/steamcmd.sh +runscript scmd_script.txt

chmod +x /LinuxServer/Linux/Battalion/Binaries/Linux/BattalionServer

#check if a custom config was linked and copy it first
if [ -f /config/DefaultGame.ini ]; then
   echo "Using your custom configuration."
   cp /config/DefaultGame.ini ./DefaultGame.ini
else
   echo "No config linked, using default config."
fi

if [ -d /config/Loadouts ]; then
   cp /config/Loadouts/* ./Battalion/Loadouts/
   echo "Using your custom loadouts."
else
   echo "No custom loadouts linked, using default loadouts."
fi

#add env vars to config before launching
sed -i "/ServerName=/c ServerName=$SERVERNAME" ./DefaultGame.ini
sed -i "/Password=/c Password=$PASSWORD" ./DefaultGame.ini
sed -i "/PlayMode=/c PlayMode=$PLAYMODE" ./DefaultGame.ini
sed -i "/StartType=/c StartType=$STARTTYPE" ./DefaultGame.ini
sed -i "/RequiredPlayers=/c RequiredPlayers=$REQUIREDPLAYERS" ./DefaultGame.ini

#insert SteamIDs
IFS=',' read -r -a steamIDSArray <<< "$ADMINSTEAMID"
for steamID in "${steamIDSArray[@]}"
do
    awk '!found && /\+AdminSteamIDs\=/{print;print "+AdminSteamIDs=\"'$steamID'\""; found=1;next} 1' ./DefaultGame.ini > tmp && mv tmp DefaultGame.ini
done
sed -i '0,/+AdminSteamIDs=000000000000000/{//d}' ./DefaultGame.ini

#finished editing config, lets go

#check if external ip was supplied, otherwise ask amazon what our ip is
if [ -z ${PUBLICIP+x} ]; then PUBLICIP=$(curl -s checkip.amazonaws.com); else echo "PUBLICIP already set to '$PUBLICIP'"; fi

#Calculate queryport see wiki.battaliongame.com
let QUERY_PORT=SERVER_PORT+3
#Echo configuration#
echo "Starting your Server \"$SERVERNAME\" on port  $PUBLICIP:$SERVER_PORT ..."
echo "We are running with Gamemode $PLAYMODE and password \"$PASSWORD\"."
echo "The StartType is $STARTTYPE".
echo "Lets go, remember to bring up issues and feedback at https://github.com/frenos/btl44."
echo "                                                                      - Frenos"
echo "--------------------------------------------------------------------------------------"
./Battalion/Binaries/Linux/BattalionServer /Game/Maps/Final_Maps/Derailed?Game=/Script/ShooterGame.BombGameMode?listen -broadcastip="${PUBLICIP}" -PORT=${SERVER_PORT} -QueryPort=${QUERY_PORT} -log -defgameini="../../../DefaultGame.ini"
