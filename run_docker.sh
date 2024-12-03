#!/bin/bash
WANDB_API_KEY=$(cat ./wandb_key)
# git pull

script_and_args="${@:2}"
if [ $1 == "all" ]; then
    gpus="0 1 2 3 4 5 6 7"
else
    gpus=$1
fi

echo "launching on $gpus"

for gpu in $gpus; do
    echo "Launching container jaxcredibots_$gpu on GPU $gpu"
    docker run \
        --gpus device=$gpu \
        -e WANDB_API_KEY=$WANDB_API_KEY \
        -e PYTHONPATH=/home/duser/jaxcredibots \
        -v $(pwd):/home/duser/jaxcredibots \
        --name jaxcredibots_$gpu \
        --user $(id -u) \
        --rm \
	-d \
        -t jaxcredibots \
        /bin/bash -c "$script_and_args"
done