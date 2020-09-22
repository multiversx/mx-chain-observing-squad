# observing-squad
Docker images and scripts for setting up an Elrond Observing Squad

## How to build the images

```
docker image build . -t elrondnetwork/elrond-node-obs:e1.1.0.1 -f ./elrond-node-obs 
docker image build . -t elrondnetwork/elrond-proxy:v1.1.1 -f ./elrond-proxy 
```
