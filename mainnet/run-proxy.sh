#!/bin/bash
docker run --network=elrond-squad --ip=${IP} --name proxy elrondnetwork/${PROXY_TAG}
