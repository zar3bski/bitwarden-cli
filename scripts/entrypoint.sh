#!/bin/ash

VERSION=$(bw --version)
set -e

### Env setting

doas /set-svc-credentials.sh

doas /update-ca-certificates.sh

### App setting

echo "[INFO] configuring bitwarden-cli v.$VERSION"
bw config server ${BW_HOST}

if [ -n "$BW_CLIENTID" ] && [ -n "$BW_CLIENTSECRET" ]; then
    echo "[INFO] Using apikey to log in"
    bw login --apikey --raw
    export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
else
    echo "[INFO] Using username and password to log in"
    export BW_SESSION=$(bw login ${BW_USER} --passwordenv BW_PASSWORD --raw)
fi

bw unlock --check

echo '[INFO] Running `bw server` on  127.0.0.1:8088'
bw serve --hostname 127.0.0.1 --port 8088 &

echo '[INFO] Running `nginx` on  0.0.0.0:8087'
doas nginx
tail -f /var/log/nginx/*.log
