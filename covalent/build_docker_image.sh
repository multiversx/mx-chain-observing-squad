IMAGE_NAME="elrond-node-obs:local"
CONFIG_TAG="D1.2.24.0-covalent1.0.3"

# network can we "mainnet", "testnet" or "devnet"
NETWORK="devnet"

docker build --build-arg CONFIG_TAG=${CONFIG_TAG} --build-arg NETWORK=${NETWORK} . -t ${IMAGE_NAME} -f ./elrond-node-obs
