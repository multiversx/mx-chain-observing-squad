FROM golang:1.13.6 as builder

# TODO: git clone https://github.com/ElrondNetwork/elrond-proxy-go/releases/tag/v1.1.1
# TODO: Sed config.toml:
#  [[Observers]]
#     ShardId = 0
#     Address = "http://127.0.0.1:8080"
#
#  [[Observers]]
#     ShardId = 1
#     Address = "http://127.0.0.1:8081"
#
#  [[Observers]]
#     ShardId = 2
#     Address = "http://127.0.0.1:8082"
#
#  [[Observers]]
#     ShardId = 4294967295
#     Address = "http://127.0.0.1:8083"

WORKDIR /elrond
COPY . .
# Proxy
WORKDIR /elrond/cmd/proxy
RUN go build

# ===== SECOND STAGE ======
FROM ubuntu:18.04
COPY --from=builder /elrond/cmd/proxy /elrond/cmd/proxy
##Config the proxy config.toml file
#Mount /data/config/

WORKDIR /elrond/cmd/proxy/
EXPOSE 8079
ENTRYPOINT ["./proxy"]
