# observing-squad

Docker images and scripts for setting up an Elrond Observing Squad. Squad can be connect to the Elrond `mainnet`, `testnet`, or `devnet`

## Build docker images for observers and proxy


### Pre-requests

Open file `.env` and set some variables
- Set `CONFIG_TAG` variable with config-tag (tags can be found here for [mainnet](https://github.com/ElrondNetwork/elrond-config-mainnet), [testnet](https://github.com/ElrondNetwork/elrond-config-testnet) or [devnet](https://github.com/ElrondNetwork/elrond-config-devnet))

    Example: `CONFIG_TAG="T1.2.30.0"` ([tag](https://github.com/ElrondNetwork/elrond-config-testnet/tree/T1.2.30.0) used)


- Set `NETWORK` variable (can be `mainnet`, `devnet`, or `testnet`)
  
    Example: `NETWORK="testnet"`


- Set `IMAGE_NAME` variable for observer

    Example: `IMAGE_NAME=elrond-node-testnet:local`


- Set `IMAGE_NAME` variable for proxy

  Example: `PROXY_IMAGE_NAME=elrond-proxy:local`

### Build docker images 

In order to build a Docker images one has to run scripts:

- For observer:
```
./build_observer_image.sh
```

- For proxy:
```
./build_proxy_image.sh
```

## Start observing-squad

Depending on the used or built Docker image we can connect to the `mainnet`, `testnet` or `devnet` chain.

### Run script `start_stack.sh`

This script will start 4 observers and a proxy that will sync blocks from chain.