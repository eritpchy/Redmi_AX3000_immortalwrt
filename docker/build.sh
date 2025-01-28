#!/bin/bash
set -xe
cd ${0%/*}

export $(grep -v '^#' ".env" | xargs) || true
export PUID=$(id -u)
export PGID=$(id -g)
docker compose run --build -it --rm builder /bin/bash  /home/builder/openwrt/build.sh