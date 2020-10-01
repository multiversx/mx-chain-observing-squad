## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
docker image build . -t elrondnetwork/elrond-rosetta-node-mainnet-obs:e1.1.0.1 -f ./elrond-node-obs
docker image build . -t elrondnetwork/elrond-rosetta--mainnet-proxy:e1.1.0.1 -f ./elrond-proxy
```