

## Build locally

```shell
sudo docker build --build-arg BW_CLI_VERSION=2025.5.0 -t bitwarden/cli ./
```


## Usage

Mount custom CA certificates in `/usr/local/share/ca-certificates`

### Variables

|              name | Description                                 | Required |
| ----------------: | :------------------------------------------ | :------: |
|         `BW_HOST` | Address or domain of the bitwarden instance |    X     |
|     `BW_CLIENTID` | (OUT) Information for Oauth                 |          |
| `BW_CLIENTSECRET` | (OUT) Information for Oauth                 |          |
|         `BW_USER` | (OUT) Information for Basic Auth            |          |
|     `BW_PASSWORD` | (OUT) Information for Basic Auth            |          |
|        `SVC_USER` | (IN) Basic auth to access **bitwarden-cli** |    X     |
|    `SVC_PASSWORD` | (IN) Basic auth to access **bitwarden-cli** |    X     |

> Depending on your **bitwarden** server configuration, you will need either to provide  `BW_CLIENTID` + `BW_CLIENTSECRET` **OR** `BW_USER` + `BW_PASSWORD`
