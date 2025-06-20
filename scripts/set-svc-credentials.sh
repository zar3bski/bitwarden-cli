#!/bin/sh
set -e

if [[ -z "${SVC_USER}" || -z "${SVC_PASSWORD}" ]]; then
    echo "[ERROR] Inbound credentials missing (SVC_USER, SVC_PASSWORD)"
    exit 1
else
    echo "[INFO] Setting credentials for $SVC_USER"
    htpasswd -cbB -C 17 /etc/nginx/.htpasswd $SVC_USER $SVC_PASSWORD
fi
