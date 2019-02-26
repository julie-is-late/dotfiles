docker stop plex
docker rm plex

docker run \
    -d \
    --restart unless-stopped \
    --runtime=nvidia \
    --name=plex \
    -e ADVERTISE_IP="http://192.168.1.102:32400/" \
    -h perplexed \
    -p 32400:32400/tcp \
    -p 3005:3005/tcp \
    -p 8324:8324/tcp \
    -p 32469:32469/tcp \
    -p 1900:1900/udp \
    -p 32410:32410/udp \
    -p 32412:32412/udp \
    -p 32413:32413/udp \
    -p 32414:32414/udp \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_CAPABILITIES=compute,video,utility \
    -e VERSION=latest \
    -e TZ=America/Chicago \
    -v /mnt/ume/plex/config/:/config \
    -v /mnt/ume/tv/:/data/tvshows \
    -v /mnt/ume/movies/:/data/movies \
    -v /mnt/ume/Music/:/data/music \
    -v /mnt/ume/anime/:/data/anime \
    -v /mnt/ume/plex/transcode/:/transcode \
    -e PLEX_UID=973 \
    -e PLEX_GID=973 \
    -e CHANGE_CONFIG_DIR_OWNERSHIP=false \
    plexinc/pms-docker:public

