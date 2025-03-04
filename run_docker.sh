#!/bin/bash
echo "Launching container thomf_cookiecutter"

CUDA_VISIBLE_DEVICES=1

docker run \
    --gpus "device=${CUDA_VISIBLE_DEVICES}" \
    --env-file .env \
    -e PYTHONPATH=/home/duser/project \
    --name thomf_cookiecutter \
    --rm \
    -v $(pwd):/home/duser/project \
    --user $(id -u) \
    thomf_cookiecutter \
    /bin/bash -c "python3 scripts/env_debugger.py"