## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
docker image build . -t elrondnetwork/elrond-rosetta-observer-mainnet:v1.1.6 -f ./observer/Dockerfile
docker image build . -t elrondnetwork/elrond-rosetta-proxy-mainnet:v1.1.3 -f ./proxy/Dockerfile
```