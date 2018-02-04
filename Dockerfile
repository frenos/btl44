FROM ubuntu:latest
MAINTAINER Frenos <Frederic@codepotion.de>
ARG DEBIAN_FRONTEND="noninteractive"

ENV SERVER_DL_URL="https://storage.googleapis.com/battalion_public/BattalionLinuxServer_10849.zip"
ENV PUBLICIP="127.0.0.1"
ENV SERVER_PORT=7777

#Serverconfiguration default values
ENV SERVERNAME="Community Server frenos/btl44"
ENV PASSWORD=
ENV PLAYMODE=Arcade
ENV ADMINSTEAMID=000000000000000

RUN apt-get update && apt-get install -y wget unzip lib32gcc1 xdg-user-dirs

RUN wget "${SERVER_DL_URL}" -O serverfiles.zip && unzip serverfiles.zip && rm serverfiles.zip

RUN chmod +x ./LinuxServer/Battalion/Binaries/Linux/BattalionServer

WORKDIR ./LinuxServer

ADD myrunner.sh .
RUN chmod +x ./myrunner.sh

EXPOSE ${SERVER_PORT}

CMD ./myrunner.sh
