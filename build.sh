#!/bin/bash

echo 'Building Dockerfile with image name thomf_cookiecutter'
docker build \
    --build-arg UID=$(id -u ${USER}) \
    --build-arg GID=1234 \
    --build-arg REQS="$(cat requirements.txt)" \
    -t thomf_cookiecutter \
    .
    # --no-cache \