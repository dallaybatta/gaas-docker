# PATH TO YOUR HOSTS FILE
ETC_HOSTS=/etc/hosts

 dockerimageinfo() {
    DOCKER_IMAGE=$1
    docker inspect $DOCKER_IMAGE > config.json
    docker_hostname=`python -c 'import json; c=json.load(open("config.json")); print(c[0]["Config"]["Hostname"])'`
    docker_ip=`python -c 'import json; c=json.load(open("config.json")); print(c[0]["NetworkSettings"]["IPAddress"])'`
    rm -f config.json
    echo $docker_hostname $docker_ip
}
 
 removehost() {
    HOSTNAME=$1
    #echo "calling removehost " $HOSTNAME
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME Found in your $ETC_HOSTS, Removing now...";
        sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS
    else
        echo "$HOSTNAME was not found in your $ETC_HOSTS";
    fi
}

 addhost() {
    HOSTNAME=$1
    IP=$2
    HOSTS_LINE="$IP\t$HOSTNAME"
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
        then
            echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Adding $HOSTNAME to your $ETC_HOSTS";
            sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";

            if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
                then
                    echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME /etc/hosts)";
                else
                    echo "Failed to Add $HOSTNAME, Try again!";
            fi
    fi
}

 updateEtcHosts() {
   RES=$( dockerimageinfo $1 )
   #https://www.geeksforgeeks.org/cut-command-linux-examples/
   dockerhost=$( echo $RES | cut -d " " -f 1 )
   docker_ip=$( echo $RES | cut -d " " -f 2 )
   #read dockerhost dockerip < <(docker_info $1)
   #echo "dockerhost='$dockerhost', docker_ip='$docker_ip'"
   echo "dockerhost :" $dockerhost
   echo "docker_ip :" $docker_ip
   removehost $dockerhost
   addhost $dockerhost $docker_ip
}

#updateEtcHosts $1
