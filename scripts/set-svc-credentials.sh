#!/bin/sh
set -e
LOG_LEVEL="${LOG_LEVEL:-warn}"

if [[ -z "${SVC_USER}" || -z "${SVC_PASSWORD}" ]]; then
    echo "[ERROR] Inbound credentials missing (SVC_USER, SVC_PASSWORD)"
    exit 1
else
    echo "[INFO] Setting credentials for $SVC_USER"
    htpasswd -cbB -C 5 /etc/nginx/.htpasswd $SVC_USER $SVC_PASSWORD
fi

echo "[INFO] Nginx log level to $LOG_LEVEL"
sed -r -i "s/^(error_log \/var\/log\/nginx\/error.log ).*/\1${LOG_LEVEL};/" /etc/nginx/nginx.conf
