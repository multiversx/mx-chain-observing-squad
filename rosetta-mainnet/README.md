## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
docker image build . -t elrondnetwork/elrond-rosetta-observer-mainnet:e1.1.0.1 -f ./observer/Dockerfile
docker image build . -t elrondnetwork/elrond-rosetta-proxy-mainnet:e1.1.0.1 -f ./proxy/Dockerfile
```