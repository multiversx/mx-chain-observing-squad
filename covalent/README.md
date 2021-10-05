## Covalent-observing-squad


### Get docker image
```
docker pull elrondnetwork/elrond-node-obs-covalent:latest
```

### Build docker image

In order to can build a Docker image have to do some setup in the `elrond-node-obs` Docker file

1. set tag version for elrond-config-mainnet (also can be changed in elrond-config-testnet or elrond-config-devnet)

2. set tag version for elrond-go

Useful links:

[elrond-config-mainnet](https://github.com/ElrondNetwork/elrond-config-mainnet)

[elrond-config-testnet](https://github.com/ElrondNetwork/elrond-config-testnet)

[elrond-config-devnet](https://github.com/ElrondNetwork/elrond-config-devnet)

[elrond-go](https://github.com/ElrondNetwork/elrond-go)

### Docker-compose setup 

Covalent squad will contain 4 observers one for every shard.

In order to can run this have to set in `.env` file what Docker image to use.
``` 
NODE_TAG=elrond-go-node-mainnet-with-covalent:latest
```

Depending on the used Docker image we can connect to the `mainnet`, `testnet` or `devnet`.

### Run script `start_stack_with_covalent.sh`

This script will start 4 observers with covalent indexer enabled that will wait for WS connections 

Docker observers will expose 4 WS ports one for every observer

```
Shard 0 observer    -> ${HOST_IP}:20000
Shard 1 observer    -> ${HOST_IP}:20001
Shard 2 observer    -> ${HOST_IP}:20002
Shard meta observer -> ${HOST_IP}:20003
```
