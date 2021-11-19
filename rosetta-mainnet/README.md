## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
docker image build . -t elrondnetwork/elrond-rosetta-observer-mainnet:v1.2.30 -f ./observer/Dockerfile
docker image build . -t elrondnetwork/elrond-rosetta-proxy-mainnet:v1.1.17 -f ./proxy/Dockerfile
```