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

WORKDIR /csgo

RUN groupadd -r csgo && useradd --no-log-init -r -g csgo csgo && \
    mkdir -p /home/csgo && \
    chown -R csgo:csgo /csgo /steamcmd /home/csgo
USER csgo

RUN mkdir -p /home/csgo/.steam/sdk32 && \
    ln -s /steamcmd/linux32/steamclient.so /home/csgo/.steam/sdk32/steamclient.so

RUN /steamcmd/steamcmd.sh +login anonymous +force_install_dir /csgo +app_update 740 +quit
COPY --chown=csgo:csgo ./csgo .

EXPOSE 27015/udp

CMD ["/csgo/start.sh"]
