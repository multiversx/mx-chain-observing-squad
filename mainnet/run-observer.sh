#!/bin/bash
docker run --mount type=bind,source=${OBSERVER_DIR}/db,destination=/go/mx-chain-go/cmd/node/db --mount type=bind,source=${OBSERVER_DIR}/logs,destination=/go/mx-chain-go/cmd/node/logs --mount type=bind,source=${OBSERVER_DIR}/config,destination=/config --publish ${P2P_PORT}:37373 --network=multiversx-squad --ip=${IP} --name squad-${SHARD} multiversx/chain-observer:v1.8.9.0 \
--destination-shard-as-observer=${SHARD} --validator-key-pem-file=/config/observerKey_${SHARD}.pem --display-name="${DISPLAY_NAME}"

