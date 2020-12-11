FROM golang:1.14.9 as builder

RUN git clone https://github.com/ElrondNetwork/elrond-config-testnet && cd elrond-config-testnet && git fetch && git checkout --force T1.1.10.0
RUN git clone https://github.com/ElrondNetwork/elrond-go.git && cd elrond-go && git fetch && git checkout --force tags/v1.1.10

#Build node binary
WORKDIR /go/elrond-go/
RUN GO111MODULE=on go mod vendor

WORKDIR /go/elrond-go/cmd/node
RUN go build -i -v -ldflags="-X main.appVersion=$(git -C /go/elrond-config-testnet describe --tags --long --dirty)"

RUN cp /go/pkg/mod/github.com/!elrond!network/arwen-wasm-vm@$(cat /go/elrond-go/go.mod | grep arwen-wasm-vm | sed 's/.* //')/wasmer/libwasmer_linux_amd64.so /lib/libwasmer_linux_amd64.so

WORKDIR /go/elrond-go
RUN go get github.com/ElrondNetwork/arwen-wasm-vm/cmd/arwen@$(cat /go/elrond-go/go.mod | grep arwen-wasm-vm | sed 's/.* //')
RUN go build -o ./arwen github.com/ElrondNetwork/arwen-wasm-vm/cmd/arwen
RUN cp /go/elrond-go/arwen /go/elrond-go/cmd/node/

#Copy the right configs to the node folder
WORKDIR /go/elrond-config-testnet/
RUN cp -r * /go/elrond-go/cmd/node/config/

# ===== SECOND STAGE ======
FROM ubuntu:18.04
COPY --from=builder "/go/elrond-go/cmd/node" "/go/elrond-go/cmd/node/"
COPY --from=builder "/lib/libwasmer_linux_amd64.so" "/lib/libwasmer_linux_amd64.so"

#Enable "Database Lookup Extensions"
WORKDIR /go/elrond-go/cmd/node/
RUN sed -i '/\[DbLookupExtensions\]/!b;n;c\\tEnabled = true' ./config/config.toml
RUN sed -i 's+{ Name = \"\/simulate\", Open = false },+{ Name = "/simulate", Open = true },+g' ./config/api.toml

EXPOSE 8080
ENTRYPOINT ["/go/elrond-go/cmd/node/node", "--log-save", "--log-level=*:DEBUG,core/dblookupext:WARN", "--log-logger-name", "--rest-api-interface=0.0.0.0:8080"]
