#!/bin/bash

# Backup files
rsync -avx --progress /Users/max/Documents/immich-app /Volumes/WDPASSPORT/Backup

rsync -avx --progress /Users/max/Documents/vaultwarden /Volumes/WDPASSPORT/Backup

# Upgrade immich
docker compose --file $HOME/Documents/immich-app/docker-compose.yml down && docker compose --file $HOME/Documents/immich-app/docker-compose.yml pull && docker compose --file $HOME/Documents/immich-app/docker-compose.yml up -d

# Clean up unused docker data
/usr/local/bin/docker system prune -f
