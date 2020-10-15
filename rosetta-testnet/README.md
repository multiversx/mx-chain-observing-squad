## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
docker image build . -t elrondnetwork/elrond-rosetta-observer-testnet:v1.1.3 -f ./observer/Dockerfile
docker image build . -t elrondnetwork/elrond-rosetta-proxy-testnet:v1.1.3 -f ./proxy/Dockerfile
```