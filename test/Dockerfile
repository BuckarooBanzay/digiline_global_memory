ARG ENGINE_VERSION=5.7.0
FROM registry.gitlab.com/minetest/minetest/server:${ENGINE_VERSION}

USER root

RUN apk add git &&\
    mkdir -p /root/.minetest/worlds/world/worldmods/ &&\
    cd /root/.minetest/worlds/world/worldmods/ &&\
    git clone https://github.com/BuckarooBanzay/mtt &&\
    git clone https://github.com/minetest-mods/mesecons &&\
    git clone https://github.com/minetest-mods/digilines

ENTRYPOINT minetestserver --config /minetest.conf