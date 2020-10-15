FROM golang:1.14.9 as builder

RUN mkdir /root/.ssh && chmod 700 /root/.ssh
	
# Clone the elrond-proxy-go repo 
RUN git clone https://github.com/ElrondNetwork/elrond-proxy-go.git && cd elrond-proxy-go && git fetch && git checkout --force development

# Proxy
WORKDIR /go/elrond-proxy-go/cmd/proxy
RUN go build

# ===== SECOND STAGE ======
FROM ubuntu:18.04

#Copy the built app to the container

COPY --from=builder /go/elrond-proxy-go/cmd/proxy /go/elrond-proxy-go/cmd/proxy
#Copy the proxy config.toml file
COPY configs/config.toml /go/elrond-proxy-go/cmd/proxy/config/

WORKDIR /go/elrond-proxy-go/cmd/proxy/
EXPOSE 8079
CMD ["./proxy", "--rosetta"]
