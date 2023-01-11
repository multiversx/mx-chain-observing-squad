## Covalent-observing-squad

### Build docker image

In order to build a Docker image one has to setup in the `build_docker_image.sh` file

1. set docker image name (IMAGE_NAME variable)

2. set config tag that will be used (CONFIG_TAG variable)

3. set network (NETWORK variable: can be "mainnet", "devnet", or "testnet")

Run script for build 

```
./build_docker_image.sh
```

Useful links to:

[mx-chain-mainnet-config](https://github.com/multiversx/mx-chain-mainnet-config) - can find tag for mainnet config here

[mx-chain-testnet-config](https://github.com/multiversx/mx-chain-testnet-config)

[mx-chain-devnet-config](https://github.com/multiversx/mx-chain-devnet-config)

[mx-chain-go](https://github.com/multiversx/mx-chain-go)

### Docker-compose setup 

Covalent squad will contain 4 observers, one for every shard.

In order to run this one has to set in `.env` file what Docker image to use. (the name that was set on the build step)
``` 
NODE_TAG=multiversx-node-mainnet-with-covalent:latest
```

Depending on the used Docker image we can connect to the `mainnet`, `testnet` or `devnet`.

### Run script `start_stack_with_covalent.sh`

This script will start 4 observers, each with covalent indexer enabled that will wait for WS connections. 

Docker observers will expose 4 WS ports, one for every observer

```
Shard 0 observer    -> ${HOST_IP}:20000
Shard 1 observer    -> ${HOST_IP}:20001
Shard 2 observer    -> ${HOST_IP}:20002
Shard meta observer -> ${HOST_IP}:20003
```
