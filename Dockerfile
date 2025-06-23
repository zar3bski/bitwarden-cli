FROM alpine:3.22.0

ARG BW_CLI_VERSION

COPY ./scripts/* /

RUN apk add npm nginx apache2-utils doas && \
  npm install -g semver @bitwarden/cli@${BW_CLI_VERSION} && \
  adduser -u 28087 -g 'Nginx www user' -D wwwcbz && \
  mkdir -p /usr/local/share/ca-certificates && \
  rm /etc/nginx/http.d/default.conf && \
  sed -i 's/worker_processes auto;/worker_processes 2;/' /etc/nginx/nginx.conf && \
  echo $'server{ \n\
  listen 8087; \n\
  auth_basic "Bitwarden protected area"; \n\
  auth_basic_user_file /etc/nginx/.htpasswd; \n\
  location / { \n\
      proxy_pass "http://127.0.0.1:8088"; \n\
  } \n\
  location /sync { \n\
      auth_basic off; \n\
      proxy_pass "http://127.0.0.1:8088"; \n\
  } \n\
}' > /etc/nginx/http.d/bitwarden-cli.conf && \
  echo $'permit nopass keepenv wwwcbz cmd /set-svc-credentials.sh\n\
  permit nopass keepenv wwwcbz cmd /update-ca-certificates.sh\n\
  permit nopass keepenv wwwcbz cmd nginx' > /etc/doas.conf

USER 28087

CMD ["/entrypoint.sh"]