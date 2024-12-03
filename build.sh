#!/bin/bash

echo 'Building Dockerfile with image name jaxcredibots'
docker build \
    --build-arg UID=$(id -u ${USER}) \
    --build-arg GID=1234 \
    --build-arg REQS="$(cat requirements.txt)" \
    -t jaxcredibots \
    --no-cache \
    .