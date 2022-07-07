#!/bin/bash
docker run --mount type=bind,source=${OBSERVER_DIR}/db,destination=/go/elrond-go/cmd/node/db --mount type=bind,source=${OBSERVER_DIR}/logs,destination=/go/elrond-go/cmd/node/logs --mount type=bind,source=${OBSERVER_DIR}/config,destination=/config --publish ${P2P_PORT}:37373 --network=elrond-squad --ip=${IP} --name squad-${SHARD} elrondnetwork/elrond-node-obs:v1.3.35 \
--destination-shard-as-observer=${SHARD} --validator-key-pem-file=/config/observerKey_${SHARD}.pem --display-name="${DISPLAY_NAME}"

