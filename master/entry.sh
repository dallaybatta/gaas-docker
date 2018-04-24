# Setting the environment variable required to run the gobblin
echo 'GOBBLIN_JOB_CONFIG_DIR=/home/dip/gobblin-dist/job-config-bpu' >> ~/.bashrc 
echo 'GOBBLIN_WORK_DIR=/home/dip/gobblin-dist/working-dir' >> ~/.bashrc
echo 'JAVA_HOME=/docker-java-home' >> ~/.bashrc

touch boot.log

echo "Starting configuration" >> ./boot.log

echo "setting GOBBLIN_JOB_CONFIG_DIR=/home/dip/gobblin-dist/job-config-bpu" >> ./boot.log
export ENV GOBBLIN_JOB_CONFIG_DIR=/home/dip/gobblin-dist/job-config-bpu 
echo "setting GOBBLIN_WORK_DIR=/home/dip/gobblin-dist/working-dir" >> ./boot.log
export ENV GOBBLIN_WORK_DIR=/home/dip/gobblin-dist/working-dir
export ENV GOBBLIN_HOME=/home/dip/gobblin-dist
echo "setting GOBBLIN_HOME=/home/dip/gobblin-dist" >> ./boot.log

echo "setting JOB_CONFIG_PATH="$JOB_CONFIG_PATH >> ./boot.log

echo "setting ZOOKEEPER_CONNECT_URL="$ZOOKEEPER_CONNECT_URL >> ./boot.log
echo "setting KAFKA_TOPIC="$KAFKA_TOPIC >> ./boot.log
echo "setting KAFKA_BROKER_URL="$KAFKA_BROKER_URL >> ./boot.log
echo "setting HELIX_CLUSTER_NAME="$HELIX_CLUSTER_NAME >> ./boot.log
# Multiple Replacement, the / character in the environment variable was not working, the delimited was changed to | from \
sed -e "s|\${JOB_CONFIG_PATH}|$JOB_CONFIG_PATH|;s|\${ZOOKEEPER_CONNECT_URL}|$ZOOKEEPER_CONNECT_URL|;s|\${KAFKA_BROKER_URL}|$KAFKA_BROKER_URL|;s|\${HELIX_CLUSTER_NAME}|$HELIX_CLUSTER_NAME|;s|\${KAFKA_TOPIC}|$KAFKA_TOPIC|" ./support/templates/application.tpl > $GOBBLIN_HOME/conf/standalone/master/application.conf

sed -e "s|\${ZOOKEEPER_CONNECT_URL}|$ZOOKEEPER_CONNECT_URL|;s|\${HELIX_CLUSTER_NAME}|$HELIX_CLUSTER_NAME|;s|\${HDFS_HOST_PORT}|$HDFS_HOST_PORT|" ./support/templates/reference.tpl > $GOBBLIN_HOME/conf/standalone/master/reference.conf

# Move the logging file too
cp -f ./support/templates/log4j-cluster.properties $GOBBLIN_HOME/conf/standalone/master


chmod +x ./bin/**
sleep 1
./bin/gobblin-cluster-master.sh start

echo "Ending" >> ./boot.log

while sleep 1000; do
 echo "sleeping"  
done
