# This will create the Docker Image
createDockerImage()
{
 HOST_NAME=$HOST_NAME-$@
 echo "Generated Docker Image as " $HOST_NAME
}
GROUP_ID=$1
echo "Creating and starting docker-dip-kafka docker"
HOST_NAME=docker-dip-kafka
DOCKER_HOST_ZK=docker-dip-zookeeper-$GROUP_ID
createDockerImage $GROUP_ID
DOCKER_PORT_MAPPING_PREFIX=6500
val=`expr $DOCKER_PORT_MAPPING_PREFIX + $GROUP_ID`
DOCKER_PORT_MAPPING=$val
IMAGE_EXISTS=$(docker ps -a | grep "$HOST_NAME")
echo "kafka exists: $dockerIMAGE_EXISTS"
echo "HOST_NAME: $HOST_NAME"
if [[ -z "$IMAGE_EXISTS" ]]; then
			# build image from docker file
			#docker run --name docker-dip-kafka --link docker-dip-zookeeper:zookeeper -p 9092:9092 -d  ches/kafka
			# IMPORTANT, keep the linking alias name to zookeeper only!!!
			#--volume /opt/dip_docker_data/kafka/data:/data --volume /opt/dip_docker_data/kafka/logs:/logs
			echo " Executing "
			docker run -h $HOST_NAME --name $HOST_NAME  --link $DOCKER_HOST_ZK:zookeeper -p $DOCKER_PORT_MAPPING:9092 -d  ches/kafka
	else
			echo "starting "$HOST_NAME
			#docker start docker-dip-kafka  &> /dev/null
			docker start $HOST_NAME  &> /dev/null
fi

source utils.sh
updateEtcHosts $HOST_NAME

