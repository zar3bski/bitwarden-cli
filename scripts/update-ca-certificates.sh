#!/bin/sh
set -e

for f in /usr/local/share/ca-certificates/*; do
    cat $f >>/etc/ssl/certs/ca-certificates.crt
    echo "[INFO] $f imported"
done
