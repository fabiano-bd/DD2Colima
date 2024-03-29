#!/bin/sh

function RemoveColima
{
  # stop all containers
  docker kill $(docker ps -q)

  # remove all containers, images, volumes, networks and caches
  docker system prune --all --force --volumes  

  # stop colima
  colima stop

  # delete image
  colima delete

  # unistall docker
  brew uninstall docker

  # unistall docker-compose
  brew uninstall docker-compose

  # unistall colima 
  brew uninstall colima

  break
}

while true
do
  read -r -p 'You will remove Colima and all containers and images. Do you want to continue? ' choice
  case "$choice" in
      n|N) break;;
      y|Y) RemoveColima;;
      *) echo 'Y - yes or N - no';;
  esac
done

