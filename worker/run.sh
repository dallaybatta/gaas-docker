createDockerContainer()
{
 DOCKER_CONTAINER_NAME=$DOCKER_CONTAINER_NAME-$@
}

GROUP_ID=$1
DOCKER_IMAGE_TAG_NAME=dallaybatta/gaas-cluster-worker
DOCKER_CONTAINER_NAME=docker-gobblin-cluster-worker
createDockerContainer $GROUP_ID
echo "DOCKER_SERVICE_PORT_MAPPING" $DOCKER_SERVICE_PORT_MAPPING

GOBBLIN_HOME=/home/dip/gobblin-dist/
DOCKER_LINKINGS=""

JOB_CONFIG_PATH=$2
if [ "$2" == "" ]; then
    echo "No arguments(JOB_CONFIG_PATH) provided, setting to default "
    JOB_CONFIG_PATH="/home/dip/gobblin-dist/cluster-job-config-bpu1"
fi
echo "JOB_CONFIG_PATH " $JOB_CONFIG_PATH

ZOOKEEPER_CONNECT_URL=$3
if [ "$3" == "" ]; then
    echo "No arguments(ZOOKEEPER_CONNECT_URL) provided, setting to default "
    ZOOKEEPER_CONNECT_URL="docker-dip-zookeeper-"$GROUP_ID":2181"
    DOCKER_LINKINGS+=" --link docker-dip-zookeeper-"$GROUP_ID":docker-dip-zookeeper-"$GROUP_ID
    echo "DOCKER_LINKINGS "$DOCKER_LINKINGS
fi
echo "ZOOKEEPER_CONNECT_URL " $ZOOKEEPER_CONNECT_URL

KAFKA_BROKER_URL=$4
if [ "$4" == "" ]; then
    echo "No arguments(KAFKA_BROKER_URL) provided, setting to default "
    KAFKA_BROKER_URL="docker-dip-kafka-"$GROUP_ID":9092"
    DOCKER_LINKINGS+=" --link docker-dip-kafka-"$GROUP_ID":docker-dip-kafka-"$GROUP_ID
    echo "DOCKER_LINKINGS "$DOCKER_LINKINGS
fi
echo "KAFKA_BROKER_URL " $KAFKA_BROKER_URL

HELIX_CLUSTER_NAME=$5
if [ "$5" == "" ]; then
    echo "No arguments(HELIX_CLUSTER_NAME) provided, setting to default "
    HELIX_CLUSTER_NAME="GobblinStandaloneCluster"
fi
echo "HELIX_CLUSTER_NAME " $HELIX_CLUSTER_NAME

KAFKA_TOPIC=$6
if [ "$6" == "" ]; then
    echo "No arguments(KAFKA_TOPIC) provided, setting to default "
    KAFKA_TOPIC="SimpleKafkaSpecExecutorInstanceTest"
fi
echo "KAFKA_TOPIC " $KAFKA_TOPIC

#HDFS_HOST_PORT=$7
#if [ "$7" == "" ]; then
#    echo "No arguments(HDFS_HOST_PORT) provided, setting to default "
#    HDFS_HOST_PORT="gaas-hadoop-"$GROUP_ID":9000"
#fi
#echo "HDFS_HOST_PORT " $HDFS_HOST_PORT

CONTAINER_EXISTS=$(docker ps -a | grep $DOCKER_CONTAINER_NAME)

# This needs refactoring.
if [ ! "$CONTAINER_EXISTS" ]; then
		docker run -h $DOCKER_CONTAINER_NAME  --name  $DOCKER_CONTAINER_NAME  $DOCKER_LINKINGS -v /opt/dip_docker_data/gobblin-service-worker-$GROUP_ID/templates:/home/dip/gobblin-dist/templates -e GOBBLIN_SERVICE_WORK_DIRECTORY=$GOBBLIN_SERVICE_WORK_DIRECTORY -e JOB_CONFIG_PATH=$JOB_CONFIG_PATH -e ZOOKEEPER_CONNECT_URL=$ZOOKEEPER_CONNECT_URL -e KAFKA_BROKER_URL=$KAFKA_BROKER_URL -e HELIX_CLUSTER_NAME=$HELIX_CLUSTER_NAME -e GOBBLIN_HOME=$GOBBLIN_HOME -e KAFKA_TOPIC=$KAFKA_TOPIC -d $DOCKER_IMAGE_TAG_NAME
else
		echo "restarting " $DOCKER_CONTAINER_NAME
        	docker restart  $DOCKER_CONTAINER_NAME 
fi

source utils.sh
updateEtcHosts $DOCKER_CONTAINER_NAME










