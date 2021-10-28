source ".env"

docker build --build-arg CONFIG_TAG=${CONFIG_TAG} --build-arg NETWORK=${NETWORK} . -t ${IMAGE_NAME} -f ./observer/Dockerfile --no-cache
