# Build the Docker Image.
DOCKER_IMAGE_TAG_NAME=dallaybatta/gaas-cluster-master

docker images | grep "$DOCKER_IMAGE_TAG_NAME" | awk '{print $3}'
IMAGES=$(docker images | grep "$DOCKER_IMAGE_TAG_NAME" | awk '{print $3}')
docker rmi $IMAGES

docker build -t $DOCKER_IMAGE_TAG_NAME .

echo "Build Created Successfully as " $DOCKER_IMAGE_TAG_NAME
