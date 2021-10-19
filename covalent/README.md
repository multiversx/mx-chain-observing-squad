## Covalent-observing-squad

### Build docker image

In order to can build a Docker image have to do some setup in the `build_docker_image.sh` file

1. set docker image name (IMAGE_NAME variable)

2. set config tag that will be used (CONFIG_TAG variable)

3. set network (can be "mainnet", "devnet", or "testnet", NETWORK variable)

Run script for build 

```
./build_docker_image.sh
```

Useful links:

[elrond-config-mainnet](https://github.com/ElrondNetwork/elrond-config-mainnet) - can find tag for mainnet config here

[elrond-config-testnet](https://github.com/ElrondNetwork/elrond-config-testnet)

[elrond-config-devnet](https://github.com/ElrondNetwork/elrond-config-devnet)

[elrond-go](https://github.com/ElrondNetwork/elrond-go)

### Docker-compose setup 

Covalent squad will contain 4 observers one for every shard.

In order to can run this have to set in `.env` file what Docker image to use. (the name that was set on the build step)
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
