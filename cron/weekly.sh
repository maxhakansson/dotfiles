#!/bin/bash

# Backup files
rsync -avx --progress /Users/max/Documents/immich-app /Volumes/WDPASSPORT/Backup

rsync -avx --progress /Users/max/Documents/vaultwarden /Volumes/WDPASSPORT/Backup

rsync -avx --progress /Volumes/SamsungSSD/Music /Volumes/WDPASSPORT/Backup

# Upgrade immich
/usr/local/bin/docker compose --file $HOME/Documents/immich-app/docker-compose.yml down 
/usr/local/bin/docker compose --file $HOME/Documents/immich-app/docker-compose.yml pull
/usr/local/bin/docker compose --file $HOME/Documents/immich-app/docker-compose.yml up -d

# Upgrade Vault Warden
/usr/local/bin/docker compose --file $HOME/Documents/vaultwarden/docker-compose.yml down
/usr/local/bin/docker compose --file $HOME/Documents/vaultwarden/docker-compose.yml pull
/usr/local/bin/docker compose --file $HOME/Documents/vaultwarden/docker-compose.yml up -d

# Clean up unused docker data
/usr/local/bin/docker system prune -f
