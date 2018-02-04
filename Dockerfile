FROM ubuntu:latest
MAINTAINER Frenos <Frederic@codepotion.de>
ARG DEBIAN_FRONTEND="noninteractive"

ENV SERVER_DL_URL="https://storage.googleapis.com/battalion_public/BattalionLinuxServer_10849.zip"
ENV PUBLICIP="127.0.0.1"

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y wget unzip curl lib32gcc1 xdg-user-dirs

RUN wget "${SERVER_DL_URL}" -O serverfiles.zip
RUN unzip serverfiles.zip && rm serverfiles.zip

RUN chmod +x ./LinuxServer/Battalion/Binaries/Linux/BattalionServer

WORKDIR ./LinuxServer

ADD myrunner.sh .
RUN chmod +x ./myrunner.sh

EXPOSE  7777 7780

CMD ./myrunner.sh
