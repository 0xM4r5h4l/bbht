#!/bin/bash

# Prompt the user to stop running containers
read -p "Do you want to stop running containers before clearing Docker's cache? [y/n] " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Stop all running containers
    running_containers="$(docker ps -q)"
    if [ -n "$running_containers" ]; then
        docker stop $running_containers
    else
        echo "There are no running containers."
    fi
fi

# Prompt the user for confirmation before proceeding
echo "Warning: this will remove all stopped containers, unused images, volumes, networks, and cached layers."
read -p "Are you sure you want to proceed? [y/n] " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Remove all stopped containers
    docker container prune -f

    # Remove all unused images
    docker image prune -a -f

    # Remove all unused volumes
    docker volume prune -f

    # Remove all unused networks
    docker network prune -f

    # Remove all cached images and layers
    docker builder prune -a -f
fi
