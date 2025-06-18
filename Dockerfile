FROM alpine:3.22.0

ARG BW_CLI_VERSION

RUN apk add npm nginx apache2-utils && \
  npm install -g semver @bitwarden/cli@${BW_CLI_VERSION} && \
  adduser -g 'Nginx www user' -DH wwwcbz && \
  echo $'server{ \n\
  listen 8087; \n\
  auth_basic "Bitwarden protected area"; \n\
  auth_basic_user_file /etc/nginx/.htpasswd; \n\
  location / { \n\
      proxy_pass "http://127.0.0.1:8088"; \n\
  } \n\
}' > /etc/nginx/http.d/bitwarden-cli.conf
  

COPY ./entrypoint.sh /

CMD ["/entrypoint.sh"]