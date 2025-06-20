#!/bin/sh
set -e

for f in $(find /usr/local/share/ca-certificates -type f); do
    cat $f >>/etc/ssl/certs/ca-certificates.crt
    echo "[INFO] $f imported"
done
