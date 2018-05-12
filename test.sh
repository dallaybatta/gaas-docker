GROUP_ID=$1
RANDOM_ID=$(date +%y%m%d%H%M%s)
echo $RANDOM_ID

# Trigger the Job.
curl http://docker-gobblin-service-"$GROUP_ID":9099/flowconfigs -X POST -H 'X-RestLi-Method: create' -H "Content-Type: application/json" -H 'X-RestLi-Protocol-Version: 2.0.0' --data '{"id": {"flowName":"wikipedia-'$RANDOM_ID'", "flowGroup":"test"},"templateUris" : "FS:///wikipedia.template", "properties" : {"gobblin.flow.sourceIdentifier" : "externalSource", "gobblin.flow.destinationIdentifier" : "InternalSink", "titles" : "rudra,shiva,mahesh"}}'

# Chech the Flow status.
curl "http://docker-gobblin-service-"$GROUP_ID":9099/flowstatuses/\(flowGroup:test,flowName:wikipedia-"$RANDOM_ID"\)  -X GET -H 'X-RestLi-Protocol-Version: 2.0.0'"

#curl http://docker-gobblin-service-1:9099/flowstatuses/\(flowGroup:test,flowName:wikipedia-1\)  -X GET -H 'X-RestLi-Protocol-Version: 2.0.0'

## Finally Deletion should happen after Flow is completed.
#curl "http://docker-gobblin-service-"$GROUP_ID":9099/flowconfigs/(flowGroup:test,flowName:wikipedia-1)" -X DELETE -H 'X-RestLi-Protocol-Version: 2.0.0'

#bin/kafka-topics.sh --list --zookeeper docker-dip-zookeeper-1:2181
#bin/kafka-console-consumer.sh --zookeeper docker-dip-zookeeper-1:2181 --topic SimpleKafkaSpecExecutorInstanceTest --from-beginning

