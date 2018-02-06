[![](https://img.shields.io/docker/pulls/frenos/btl44.svg)](https://hub.docker.com/r/frenos/btl44/ "Click to view the image on Docker Hub")

# btl44
A dedicated server for Battalion 1944 in docker.
Get your community server started easily!

## Getting Started

Install Docker on any host that is connected to the internet.
To get more information about installing docker, please refer to the [official docker documentation](https://docs.docker.com/install/).

Then just pull and start this image or simply use
```
docker run --name btlserver -d frenos/btl44
```

### Configuration

The simplest run configuration is shown above. It will find your IP and set a default server with the name 'Community Server frenos/btl44' on port 7777 with gamemode set to 'Arcade' and without a password.

You can put in your public IP or domain to run on a specific interface, use the ENV variable '$PUBLICIP':
```
docker run -d --name btlserver -e "PUBLICIP=1.2.3.4" frenos/btl44
```
If you don't supply a IP, the container will make a single call to Amazon Web Services to find and use your public IP.

The command above will start a server on IP `1.2.3.4` and port `7777` with the name of 'Community Server frenos/btl44'.
You can also configure multiple configuration values directly via ENV variables, namely:
- Servername
- Port
- Password
- Playmode
- AdminSteamID
- StartType
- RequiredPlayers

An example for a private unranked Server with two admins would be
```
docker run -d --name btlserver -e 'PUBLICIP=1.2.3.4' -e 'SERVERNAME="My awesome Server"' -e 'PASSWORD=secret' -e 'PLAYMODE=unranked' -e 'ADMINSTEAMID=XXX,YYY' -e 'STARTTYPE=ReadyUp' frenos/btl44
```
where XXX and YYY are two valid SteamIDs. The game will start when all players ready up.

Also check the _docker-compose.yml_ in the /examples directory.
#### Custom configuration
To use a complete custom configuration, get a "DefaultGame.ini" and customize it to your liking.
Then just bind that config into the container:
```
docker run -d --name btlserver -e 'PUBLICIP=1.2.3.4' -e 'SERVERNAME="My awesome Server"' -e 'PASSWORD=secret' -e 'PLAYMODE=unranked' -e 'ADMINSTEAMID=XXX,YYY' -v /my/configs/DefaultGame.ini:/config/DefaultGame.ini frenos/btl44
```
The container will then copy that configuration, override values that are passed as ENV vars (e.g. SERVERNAME) and start the gameserver. This allows you to use a single base configuration file for n servers with for example different server names and passwords.
Check out the _docker-compose.multi.yml_ in the /examples. When running different servers, make sure they run on different ports. Remember you need the _baseport_ and _baseport+3 as queryport. 

If you also want to use custom loadout decks in your server, simply link a loadout directory into the container: 
```
docker run -d --name btlserver -e 'PUBLICIP=1.2.3.4' -e 'SERVERNAME="My awesome Server"' -e 'PASSWORD=secret' -e 'PLAYMODE=unranked' -e 'ADMINSTEAMID=XXX,YYY' -v /my/configs/DefaultGame.ini:/config/DefaultGame.ini  -v /my/configs/Loadouts:/config/Loadouts frenos/btl44
```
Same as with the _DefaultGame.ini_ the decks are copied to the right directory and can be used in DefaultGame.ini just as the default decks.

## Links
[Battalion Community Server Wiki](http://wiki.battaliongame.com)
