GROUPID=$1
docker stop $(docker ps | grep -e "-$GROUPID" | cut -d " " -f 1)
./kafka/run-zk.sh $GROUPID
./kafka/run-kafka.sh $GROUPID
./service/run.sh $GROUPID
./master/run.sh $GROUPID
sleep 5
./worker/run.sh $GROUPID


