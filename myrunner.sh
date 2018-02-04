#!/bin/bash

./Battalion/Binaries/Linux/BattalionServer /Game/Maps/Final_Maps/Derailed?Game=/Script/ShooterGame.BombGameMode?listen -broadcastip="${PUBLICIP}" -PORT=7777 -QueryPort=7780 -log -defgameini="../../../DefaultGame.ini"
