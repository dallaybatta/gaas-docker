# Sample configuration properties with default values

# Cluster configuration properties
gobblin.cluster.app.name=GobblinStandaloneCluster
gobblin.cluster.email.notification.on.shutdown=false
gobblin.cluster.helix.instance.max.retries=2
#gobblin.cluster.work.dir=/tmp/gobblin-cluster
gobblin.cluster.work.dir=/tmp/gobblin-cluster
# Helix/Zookeeper configuration properties
gobblin.cluster.helix.cluster.name=${HELIX_CLUSTER_NAME}
gobblin.cluster.zk.connection.string="${ZOOKEEPER_CONNECT_URL}"

fs.uri="file:///"
#fs.uri="hdfs://${HDFS_HOST_PORT}"
job.execinfo.server.enabled=false
