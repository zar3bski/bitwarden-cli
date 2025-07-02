#!/bin/ash

code=$(wget -S -q http://127.0.0.1:8087/sync?force=true --post-data='' -O /dev/null 2>&1 | grep -m 1 "HTTP/" | awk '{print $2}')

if [[ $code != "200" ]]; then
   echo "[WARN] livenessProbe got HTTP status code != 200"
   exit 1
else
   exit 0
fi
