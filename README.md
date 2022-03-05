# observing-squad

Docker images and scripts for setting up an Elrond Observing Squad. Rosetta images (and `docker-compose` definitions) are also included.

## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
cd mainnet
docker image build . -t elrondnetwork/elrond-node-obs:v1.2.38-rc2 -f ./elrond-node-obs
docker image build . -t elrondnetwork/elrond-proxy:v1.1.16 -f ./elrond-proxy
```

```bash
cd utils
docker image build . -t elrondnetwork/elrond-go-keygenerator:latest -f ./elrond-go-keygenerator
```

## How to pull the images from Docker Hub

```bash
docker pull elrondnetwork/elrond-node-obs:v1.2.38-rc2
docker pull elrondnetwork/elrond-proxy:v1.1.16
docker pull elrondnetwork/elrond-go-keygenerator:latest
```

## How to setup the Docker-based Observing Squad

### Generate PEM files

First, generate 4 PEM files, one for each Observer by running the keygenerator 4 times:

```bash
export KEYS_FOLDER=~/keys
docker run --rm --mount type=bind,source=${KEYS_FOLDER},destination=/keys --workdir /keys elrondnetwork/elrond-go-keygenerator:latest
```

After running the command 4 times, rename the resulted files to:

- `observerKey_0.pem`
- `observerKey_1.pem`
- `observerKey_2.pem`
- `observerKey_metachain.pem`

**Note:** the files will be owned by the `root` user. In order to `chown` them, do as follows:

```bash
sudo chown $(whoami) *
```

### Prepare folder structure

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

### Create a docker network

```bash
docker network create --subnet=10.0.0.0/24 elrond-squad
```

### Clone repository

Clone this repository in order to get a copy of the files `run-observer.sh` and `run-proxy.sh`, which are needed below.

```bash
git clone https://github.com/ElrondNetwork/observing-squad.git && cd observing-squad
```

### Start Observers 0, 1, 2, Metachain

**Start Observer of Shard 0:**

```bash
export SHARD=0
export DISPLAY_NAME="MyObservingSquad-0"
export OBSERVER_DIR=~/MyObservingSquad/node-0
export P2P_PORT=10000
export IP=10.0.0.6
./mainnet/run-observer.sh
```

**Start Observer of Shard 1:**

```bash
export SHARD=1
export DISPLAY_NAME="MyObservingSquad-1"
export OBSERVER_DIR=~/MyObservingSquad/node-1
export P2P_PORT=10001
export IP=10.0.0.5
./mainnet/run-observer.sh
```

**Start Observer of Shard 2:**

```bash
export SHARD=2
export DISPLAY_NAME="MyObservingSquad-2"
export OBSERVER_DIR=~/MyObservingSquad/node-2
export P2P_PORT=10002
export IP=10.0.0.4
./mainnet/run-observer.sh
```

**Start Observer of Metachain:**

```bash
export SHARD=metachain
export DISPLAY_NAME="MyObservingSquad-metachain"
export OBSERVER_DIR=~/MyObservingSquad/node-metachain
export P2P_PORT=10003
export IP=10.0.0.3
./mainnet/run-observer.sh
```

### Start Proxy

```bash
export IP=10.0.0.2
./mainnet/run-proxy.sh
```

### How to upgrade the Docker-based Observing Squad

1. Pull the new images:
```
docker pull elrondnetwork/elrond-node-obs:v1.2.38-rc2
docker pull elrondnetwork/elrond-proxy:v1.1.16
```
2. Get the latest version of this repository.
```
cd observing-squad
git pull origin
```
3. Stop the 5 containers (Proxy and Observers).
4. Optionally, remove the old Docker images (not needed anymore).
5. Remove the existing Docker network: 
```
docker network rm elrond-squad
```
6. [Create a Docker network](#create-a-docker-network)
7. [Start Observers 0, 1, 2, Metachain](#start-observers-0-1-2-metachain). Make sure you set `OBSERVER_DIR` environment variables accordingly, **in advance, with respect to your current setup**.
8. [Start Proxy](#start-proxy).
9. [Verify the running containers](#verify-the-running-containers).
10. Wait until the nodes are synchronized with the Netwtork. Then [verify the running containers](#verify-the-running-containers) again.

### Verify the running containers

Do a smoke test by running some queries against the Elrond Proxy.

```bash
PROXY=http://10.0.0.2:8079
curl ${PROXY}/network/config | jq
curl ${PROXY}/network/status/0 | jq
curl ${PROXY}/network/status/1 | jq
curl ${PROXY}/network/status/2 | jq
curl ${PROXY}/network/status/4294967295 | jq
```

Extra smoke test - fetch a hyperblock:
```
SMOKE_TEST_HYPERBLOCK_NONCE=$(curl http://10.0.0.2:8079/network/status/4294967295 | jq '.data["status"]["erd_highest_final_nonce"]')
curl http://10.0.0.2:8079/hyperblock/by-nonce/${SMOKE_TEST_HYPERBLOCK_NONCE} | jq
```

Extra smoke test - fetch a transaction, and inspect its `status` and `hyperblockNonce` fields (which must be set):
```
PROXY=http://10.0.0.2:8079
TRANSACTION_HASH=a7264ecf00ad4e760d6a6bfdb3dcd1f8fb2acacb8d53577e74c09b6148812bd8
curl ${PROXY}/transaction/${TRANSACTION_HASH} | jq
curl ${PROXY}/transaction/${TRANSACTION_HASH} | jq '.data["transaction"]["status"]'
curl ${PROXY}/transaction/${TRANSACTION_HASH} | jq '.data["transaction"]["hyperblockNonce"]'
```

### Check versions of running Nodes (containers)

```
curl 10.0.0.6:8080/node/status | jq '.data["metrics"]["erd_latest_tag_software_version"]'
curl 10.0.0.5:8080/node/status | jq '.data["metrics"]["erd_latest_tag_software_version"]'
curl 10.0.0.4:8080/node/status | jq '.data["metrics"]["erd_latest_tag_software_version"]'
curl 10.0.0.3:8080/node/status | jq '.data["metrics"]["erd_latest_tag_software_version"]'
```

### Check public keys of Observers

```
curl 10.0.0.6:8080/node/status | jq '.data["metrics"]["erd_public_key_block_sign"]'
curl 10.0.0.5:8080/node/status | jq '.data["metrics"]["erd_public_key_block_sign"]'
curl 10.0.0.4:8080/node/status | jq '.data["metrics"]["erd_public_key_block_sign"]'
curl 10.0.0.3:8080/node/status | jq '.data["metrics"]["erd_public_key_block_sign"]'
```
