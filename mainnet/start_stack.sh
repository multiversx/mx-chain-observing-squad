#!/bin/bash
set -e

#Color to the people
CYAN='\x1B[0;36m'
GREEN='\x1B[0;32m'
NC='\x1B[0m'

declare -a NODES=("0" "1" "2" "metachain")

STACK_FOLDER=~/MyObservingSquad
KEYS_FOLDER=${STACK_FOLDER}/keys

#Create the folder structure for the observer stack
mkdir -p ${STACK_FOLDER}/{proxy,node-0,node-1,node-2,node-metachain}/{config,logs}
mkdir -p ${STACK_FOLDER}/{node-0,node-1,node-2,node-metachain}/db
mkdir -p ${KEYS_FOLDER}

#Generate Keys and place them in their respective folders

for OBSERVER in "${NODES[@]}"
do
   echo -e "${GREEN}--> Generating key for observer ${CYAN}$OBSERVER${GREEN}...${NC}"
   docker run --rm --mount type=bind,source=${KEYS_FOLDER},destination=/keys --workdir /keys multiversx/chain-keygenerator:latest && sudo chown $(whoami) ${KEYS_FOLDER}/validatorKey.pem && mv ${KEYS_FOLDER}/validatorKey.pem ${STACK_FOLDER}/node-$OBSERVER/config/observerKey_$OBSERVER.pem
done

#Start the stack
echo -e
echo -e "${GREEN}--> Starting the Observer+Proxy Stack...${NC}"
echo -e
docker-compose --env-file .env up -d
