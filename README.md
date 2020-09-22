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

**Prepare folder structure:**

In a folder of your choice (e.g. `MyObservingSquad`), create the following structure, and copy the observer PEM files in the `node-n/config` subfolders:

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

**Create a docker network:**

```
docker network create --subnet=172.16.0.0/24 elrond-squad
```

**Shard 0:**

```
export SHARD=0
export DISPLAY_NAME="MyObservingSquad-0"
export OBSERVER_DIR=~/MyObservingSquad/node-0
export P2P_PORT=10000
export IP=172.16.0.6
./run-observer.sh
```

**Shard 1:**

```
export SHARD=1
export DISPLAY_NAME="MyObservingSquad-1"
export OBSERVER_DIR=~/MyObservingSquad/node-1
export P2P_PORT=10001
export IP=172.16.0.5
./run-observer.sh
```

**Shard 2:**

```
export SHARD=2
export DISPLAY_NAME="MyObservingSquad-2"
export OBSERVER_DIR=~/MyObservingSquad/node-2
export P2P_PORT=10002
export IP=172.16.0.4
./run-observer.sh
```

**Metachain:**

```
export SHARD=metachain
export DISPLAY_NAME="MyObservingSquad-metachain"
export OBSERVER_DIR=~/MyObservingSquad/node-metachain
export P2P_PORT=10003
export IP=172.16.0.3
./run-observer.sh
```

**Proxy:**

```
export IP=172.16.0.2
./run-proxy.sh
```

## Verify the running containers:

```
curl http://172.16.0.2:8079/network/config | jq
curl http://172.16.0.2:8079/network/status/0 | jq
curl http://172.16.0.2:8079/network/status/1 | jq
curl http://172.16.0.2:8079/network/status/2 | jq
curl http://172.16.0.2:8079/network/status/4294967295 | jq
```