#!/bin/bash
WANDB_API_KEY=$(cat ./wandb_key)
# git pull

# set gpus to 'all' if empty string
gpus=$1
if [ "$gpus" = "" ]; then
    gpus="all"
fi

echo "Launching single container jaxcredibots_$gpus on GPU $gpus"
docker run \
    --gpus device=$gpus \
    -e WANDB_API_KEY=$WANDB_API_KEY \
    -e PYTHONPATH=/home/duser/jaxcredibots \
    -v $(pwd):/home/duser/jaxcredibots \
    --name jaxcredibots_$gpus \
    --user $(id -u) \
    --rm \
-d \
    -it jaxcredibots /bin/bash
    

# if you're running stuff inside a long running docker image you'll need tmux
docker exec -it --user root jaxcredibots_$gpus /bin/bash -c "apt install -y tmux"