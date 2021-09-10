## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
docker image build . -t elrondnetwork/elrond-rosetta-observer-devnet:D1.1.66.0 -f ./observer/Dockerfile
docker image build . -t elrondnetwork/elrond-rosetta-proxy-devnet:v1.1.16 -f ./proxy/Dockerfile
```