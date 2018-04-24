# This will create the Docker Image
# createDockerImage <imagename>
createZKDockerImage()
{
 HOST_NAME=$HOST_NAME-$@
 echo "Generated Docker Image as " $HOST_NAME
}

GROUP_ID=$1
HOST_NAME=docker-dip-zookeeper
createZKDockerImage $GROUP_ID
DOCKER_PORT_MAPPING_PREFIX=7000
val=`expr $DOCKER_PORT_MAPPING_PREFIX + $GROUP_ID`
DOCKER_PORT_MAPPING=$val
echo "Docker port Mapping " $DOCKER_PORT_MAPPING

echo "Creating and starting zookeeper docker-dip-zookeeper"-$GROUP_ID
IMAGE_EXISTS=$(docker ps -a | grep "$HOST_NAME")
echo $HOST_NAME
echo "docker-dip-zookeeper exists: $IMAGE_EXISTS"
if [[ -z "$DOCKER_IMAGE_ZK" ]]; then
			# build image from docker file
			echo "build and run docker-dip-zookeeper-"$GROUP_ID           			            
			#docker run -d --name docker-dip-zookeeper jplock/zookeeper
			docker run -d -h $HOST_NAME --name $HOST_NAME jplock/zookeeper
	else
			echo "starting docker-dip-zookeeper-"$GROUP_ID
			#docker start docker-dip-zookeeper  &> /dev/null
			docker start $HOST_NAME  &> /dev/null
fi

pwd
#source ./utils.sh
source utils.sh
updateEtcHosts $HOST_NAME

