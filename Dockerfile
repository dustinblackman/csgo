FROM debian:10-slim

RUN apt-get update && \
    apt-get install -y curl lib32gcc1 lib32stdc++6 && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

COPY ./version /

RUN mkdir /steamcmd && \
    cd /steamcmd && \
    curl -S -L -o steamcmd_linux.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -zxvf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz

RUN mkdir -p /root/.steam/sdk32 && \
    ln -s /steamcmd/linux32/steamclient.so /root/.steam/sdk32/steamclient.so

WORKDIR /csgo
RUN /steamcmd/steamcmd.sh +login anonymous +force_install_dir /csgo +app_update 740 +quit
COPY ./csgo .

EXPOSE 27015/udp

CMD ["/csgo/start.sh"]
