# This will create the Docker Image
createDockerImage()
{
 HOST_NAME=$HOST_NAME-$@
 echo "Generated Docker Image as " $HOST_NAME
}
GROUP_ID=$1
echo "Creating and starting docker-dip-kafka docker"
HOST_NAME=gaas-hadoop
createDockerImage $GROUP_ID
IMAGE_EXISTS=$(docker ps -a | grep "$HOST_NAME")
echo "hadoo exists: $IMAGE_EXISTS"
echo "HOST_NAME: $HOST_NAME"
if [[ -z "$IMAGE_EXISTS" ]]; then
			echo " Executing "
			docker run -h $HOST_NAME --name $HOST_NAME  -d  sequenceiq/hadoop-docker:2.7.1
	else
			echo "starting "$HOST_NAME
			#docker start docker-dip-kafka  &> /dev/null
			docker start $HOST_NAME  &> /dev/null
fi

source utils.sh
updateEtcHosts $HOST_NAME

#docker run -it sequenceiq/hadoop-docker:2.7.1 /etc/bootstrap.sh -bash
