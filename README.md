# btl44
A dedicated server for Battalion 1944 in docker.
Get your community server started easily!

## Getting Started

Install Docker on any host that is connected to the internet.
To get more information about installing docker, please refer to the [official docker documentation](https://docs.docker.com/install/).

Then just pull and start this image.

### Configuring

To have a minimal running server just run:
```
docker run --name btlserver -d frenos/btl44
```
It will find your IP and set a default server with the name 'Community Server frenos/btl44' on port 7777 with gamemode set to 'Arcade' and without a password.

You can put in your public ip to run on a specific interface, use the ENV variable '$PUBLICIP':
```
docker run --name btlserver -e "PUBLICIP=1.2.3.4" frenos/btl44
```
If you don't supply the IP you want to use, the container will make a single call to Amazon Web Services to find out your public IP and use that.

The command above will start a server on default port 7777 with the name of 'Community Server frenos/btl44'.
You can also configure multiple configuration values directly via ENV variables, namely:
- Servername
- Port
- Password
- Playmode
- AdminSteamID

An example for a private unranked Server with two admins would be
```
docker run --name btlserver -e 'PUBLICIP=1.2.3.4' -e 'SERVERNAME="My awesome Server"' -e 'PASSWORD=secret' -e 'PLAYMODE=unranked' -e 'ADMINSTEAMID=XXX,YYY' frenos/btl44
```

where XXX and YYY are two valid SteamIDs.

#### Custom configuration 
To use a complete custom configuration, get a "DefaultGame.ini" and customize it to your liking.
Then just link that config into the container:
```
docker run --name btlserver -e 'PUBLICIP=1.2.3.4' -e 'SERVERNAME="My awesome Server"' -e 'PASSWORD=secret' -e 'PLAYMODE=unranked' -e 'ADMINSTEAMID=XXX,YYY' -v /my/configs/DefaultGame.ini:/config/DefaultGame.ini frenos/btl44
```
The container will then copy that configuration, override the values given with ENV vars and start the gameserver.

If you also want to custom loadout decks in your server also link a loadout directory into the container: 
```
docker run --name btlserver -e 'PUBLICIP=1.2.3.4' -e 'SERVERNAME="My awesome Server"' -e 'PASSWORD=secret' -e 'PLAYMODE=unranked' -e 'ADMINSTEAMID=XXX,YYY' -v /my/configs/DefaultGame.ini:/config/DefaultGame.ini  -v /my/configs/Loadouts:/config/Loadouts frenos/btl44
```
Same as with the _DefaultGame.ini_ the decks are copied to the right directory and can be used in DefaultGame.ini just as the default decks.

## Links
[Battalion Community Server Wiki](http://wiki.battaliongame.com)
