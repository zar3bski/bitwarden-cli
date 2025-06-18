FROM node:24.2.0-alpine3.22

ARG BW_CLI_VERSION

RUN npm install -g semver @bitwarden/cli@${BW_CLI_VERSION} 

COPY ./entrypoint.sh /

CMD ["/entrypoint.sh"]