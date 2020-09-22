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

## How to run the images

In a folder of your choice (e.g. `MyObservingSquad`), create the structure as below, and copy the observer PEM files in the `node-n/config` subfolders:

```
.
├── node-0
│   ├── config
│   │   └── observerKey_0.pem
│   ├── db
│   │   └──
│   └── logs
├── node-1
│   ├── config
│   │   └── observerKey_1.pem
│   ├── db
│   └── logs
├── node-2
│   ├── config
│   │   └── observerKey_2.pem
│   ├── db
│   └── logs
├── node-metachain
│   ├── config
│   │   └── observerKey_metachain.pem
│   ├── db
│   └── logs
└── proxy
    └── config
```

First, create a docker network:
```
docker network create --subnet=172.16.0.0/24 elrond-squad
```

```
export DISPLAY_NAME_PREFIX="MyObservingSquad"
export OBSERVER_DIR_PREFIX=~/MyObservingSquad/node
```

**Shard 0:**

```
export SHARD=0
export P2P_PORT=10000
export IP=172.16.0.6
./run-observer.sh
```

**Shard 1:**

```
export SHARD=1
export P2P_PORT=10001
export IP=172.16.0.5
./run-observer.sh
```

**Shard 2:**

```
export SHARD=2
export P2P_PORT=10002
export IP=172.16.0.4
./run-observer.sh
```

**Metachain:
**
```
export SHARD=metachain
export P2P_PORT=10003
export IP=172.16.0.3
./run-observer.sh
```

**Proxy:**

```
export IP=172.16.0.2
./run-proxy.sh
```
