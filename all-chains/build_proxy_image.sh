source ".env"

sudo docker build --build-arg PROXY_TAG="${PROXY_TAG}" . -t "${PROXY_IMAGE_NAME}" -f ./proxy/Dockerfile