#!/bin/sh

function RemoveDocker
{
  # stop all containers
  docker kill $(docker ps -q)

  # remove all containers, images, volumes, networks and caches
  docker system prune --all --force --volumes

  #stop docker desktop
  osascript -e 'quit app "Docker"'

  # unistall docker desktop
  if brew ls --version --casks docker > /dev/null; then
      brew uninstall --zap --cask docker
  else    
      rm -Rf /Applications/Docker.app
  fi

  # edit .docker/config.json to remove 's' from 'credsStore'
  # if not remove, it will cause a error while trying to download a new image.
  sed -i.bak 's/credsStore/credStore/g' ~/.docker/config.json
}

function InstallColima
{
  RemoveDocker

  brew install colima
  brew install docker
  brew install docker-compose

  break
}

clear
echo ''
echo 'This script will install Colima as an alternative to Docker Desktop.'
echo ''
echo 'ATTENTION!'
echo '    An attempt to remove Docker Desktop and all its containers and images will occour.'
echo '    Are you sure that you want to continue?'
echo ''

while true
do
  read -r -p 'Type "y" to continue, "n" to cancel: ' choice
  case "$choice" in
      n|N) break;;
      y|Y) InstallColima;;
      *) echo 'Y - yes or N - no';;
  esac
done

