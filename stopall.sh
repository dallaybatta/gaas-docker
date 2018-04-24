GROUPID=$1

#https://serverfault.com/questions/704373/shell-script-for-docker-ps-a-grep-to-find-number-of-certain-containers-runnin
matchingStarted=$(docker ps | grep -e "-"$GROUPID | cut -d " " -f 1)
[[ -n $matchingStarted ]] && docker stop $matchingStarted

matching=$(docker ps -a --filter="name=$GROUPID" -q | xargs)
[[ -n $matching ]] && docker rm $matching

docker ps -a -q
source utils.sh
removehost docker-gobblin-service-$GROUPID
removehost docker-gobblin-cluster-master-$GROUPID
removehost docker-gobblin-cluster-worker-$GROUPID
#docker rm -f $(docker ps -a | grep "$name")
#docker stop $(docker ps | grep -e "-$GROUPID" | cut -d " " -f 1)
#docker rm $(docker ps | grep -e "-$GROUPID"  | cut -d " " -f 1)
#docker rm $(docker ps -a -q)

