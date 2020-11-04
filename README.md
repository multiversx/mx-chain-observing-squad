# observing-squad
Docker images and scripts for setting up an Elrond Observing Squad

## How to build the images

Skip this if you prefer to pull from [docker hub](https://hub.docker.com/u/elrondnetwork) instead.

```bash
cd mainnet
docker image build . -t elrondnetwork/elrond-node-obs:v1.1.6 -f ./elrond-node-obs
docker image build . -t elrondnetwork/elrond-proxy:v1.1.3 -f ./elrond-proxy
```

```bash
cd utils
docker image build . -t elrondnetwork/elrond-go-keygenerator:latest -f ./elrond-go-keygenerator
```

## How to pull the images from Docker Hub

```bash
docker pull elrondnetwork/elrond-node-obs:v1.1.6
docker pull elrondnetwork/elrond-proxy:v1.1.3
docker pull elrondnetwork/elrond-go-keygenerator:latest
```

## How to run the images

**Generate PEM files**

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

```bash
docker network create --subnet=10.0.0.0/24 elrond-squad
```

**Clone repository**

Clone this repository in order to get a copy of the files `run-observer.sh` and `run-proxy.sh`, which are needed below.

```bash
git clone https://github.com/ElrondNetwork/observing-squad.git && cd observing-squad
```

**Start Observer of Shard 0:**

```bash
export SHARD=0
export DISPLAY_NAME="MyObservingSquad-0"
export OBSERVER_DIR=~/MyObservingSquad/node-0
export P2P_PORT=10000
export IP=10.0.0.6
./run-observer.sh
```

**Start Observer of Shard 1:**

```bash
export SHARD=1
export DISPLAY_NAME="MyObservingSquad-1"
export OBSERVER_DIR=~/MyObservingSquad/node-1
export P2P_PORT=10001
export IP=10.0.0.5
./run-observer.sh
```

**Start Observer of Shard 2:**

```bash
export SHARD=2
export DISPLAY_NAME="MyObservingSquad-2"
export OBSERVER_DIR=~/MyObservingSquad/node-2
export P2P_PORT=10002
export IP=10.0.0.4
./run-observer.sh
```

**Start Observer of Metachain:**

```bash
export SHARD=metachain
export DISPLAY_NAME="MyObservingSquad-metachain"
export OBSERVER_DIR=~/MyObservingSquad/node-metachain
export P2P_PORT=10003
export IP=10.0.0.3
./run-observer.sh
```

**Start Proxy:**

```bash
export IP=10.0.0.2
./run-proxy.sh
```

## Verify the running containers:

Do a smoke test by running some queries against the Elrond Proxy.

```bash
curl http://10.0.0.2:8079/network/config | jq
curl http://10.0.0.2:8079/network/status/0 | jq
curl http://10.0.0.2:8079/network/status/1 | jq
curl http://10.0.0.2:8079/network/status/2 | jq
curl http://10.0.0.2:8079/network/status/4294967295 | jq
```
