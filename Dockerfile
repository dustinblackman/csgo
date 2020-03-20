FROM debian:10-slim

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository contrib && \
    add-apt-repository non-free && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt-get install -y curl lib32gcc1 lib32stdc++6 steamcmd && \
    apt-get remove -y software-properties-common && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

COPY ./version /
WORKDIR /csgo

RUN groupadd -r csgo && useradd --no-log-init -r -g csgo csgo && \
    mkdir -p /home/csgo && \
    chown -R csgo:csgo /csgo /home/csgo
USER csgo

RUN /usr/games/steamcmd +login anonymous +force_install_dir /csgo +app_update 740 +quit
COPY --chown=csgo:csgo ./csgo .

EXPOSE 27015/udp

CMD ["/csgo/start.sh"]
