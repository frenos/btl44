# btl44
A dedicated server for Battalion 1944 in docker.
Get your community server started easily!

## Getting Started

Install Docker on any host that is connected to the internet.
To get more information about installing docker, please refer to the [official docker documentation](https://docs.docker.com/install/).

Then just pull and start this image.

### Configuring

You have to at least put in your public ip to get the server running, use the ENV variable '$PUBLICIP':
```
docker run --name btlserver -e "PUBLICIP=1.2.3.4" frenos/btl44
```
This will start a server on default port 7777 with the name of 'Community Server frenos/btl44'.
You can also configure multiple configuration values directly via ENV variables, namely:
- Servername
- Port
- Password
- Playmode
- AdminSteamID

An example for a private unranked Server would be
```
docker run --name btlserver -e 'PUBLICIP=1.2.3.4' -e 'SERVERNAME="My awesome Server"' -e 'PASSWORD=secret' -e 'PLAYMODE=unranked' frenos/btl44
```

If you need more customization mount a local config to '/LinuxServer/DefaultGame.ini' in the container. This was not tested yet.

## Links
[Battalion Community Server Wiki](http://wiki.battaliongame.com)
