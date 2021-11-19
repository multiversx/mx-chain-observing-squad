## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
docker image build . -t elrondnetwork/elrond-rosetta-observer-devnet:D1.2.30.0 -f ./observer/Dockerfile
docker image build . -t elrondnetwork/elrond-rosetta-proxy-devnet:v1.1.17 -f ./proxy/Dockerfile
```