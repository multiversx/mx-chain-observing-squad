# observing-squad
Docker images and scripts for setting up an Elrond Observing Squad

## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```
docker image build . -t elrondnetwork/elrond-node-obs:e1.1.0.1 -f ./elrond-node-obs 
docker image build . -t elrondnetwork/elrond-proxy:v1.1.1 -f ./elrond-proxy 
```

## How to pull the images from Docker Hub

```
docker pull elrondnetwork/elrond-node-obs:e1.1.0.1
docker pull elrondnetwork/elrond-proxy:v1.1.1
```

