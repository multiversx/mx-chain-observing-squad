## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
docker image build . -t elrondnetwork/elrond-rosetta-node-testnet-obs:v1.1.2 -f ./elrond-node-obs
docker image build . -t elrondnetwork/elrond-rosetta-testnet-proxy:v1.1.2 -f ./elrond-proxy
```