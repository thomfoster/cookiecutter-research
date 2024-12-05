#!/bin/bash

# Configuration variables
IMAGE_NAME="my_custom_image"  # Change to your custom Docker image
CONTAINER_NAME="jupyter_container"
HOST_PORT=8888
CONTAINER_PORT=8888
WORK_DIR="/home/user/notebooks"  # Change this to the directory you want to mount
HOST_DIR="$PWD"  # Mounts the current directory as the working directory

# Check if the container is already running
if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
    echo "Stopping existing container $CONTAINER_NAME..."
    docker stop $CONTAINER_NAME
fi

# Remove existing container if it exists
echo "Cleaning up old container..."
docker rm $CONTAINER_NAME 2>/dev/null

# Run the Docker container
echo "Starting Docker container $CONTAINER_NAME with Jupyter server..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $HOST_PORT:$CONTAINER_PORT \
  -v "$HOST_DIR:$WORK_DIR" \
  $IMAGE_NAME \
  bash -c "jupyter lab --ip=0.0.0.0 --no-browser --allow-root"

# Get the container's Jupyter token
sleep 2
CONTAINER_LOG=$(docker logs $CONTAINER_NAME 2>&1)
TOKEN=$(echo "$CONTAINER_LOG" | grep -oP 'token=\K[\w]*')

# Check if the container started successfully
if [ -z "$TOKEN" ]; then
    echo "Failed to start Jupyter server in the container. Check the container logs for details."
    exit 1
fi

# Display the Jupyter server access URL
echo "Jupyter server is running in Docker container."
echo "Access it at: http://localhost:$HOST_PORT/lab?token=$TOKEN"
