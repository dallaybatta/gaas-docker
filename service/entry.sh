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

echo "setting GOBBLIN_SERVICE_WORK_DIRECTORY="$GOBBLIN_SERVICE_WORK_DIRECTORY >> ./boot.log
# We may validate it before setting, if the path exists?
sed -e "s|\${GOBBLIN_SERVICE_WORK_DIRECTORY}|$GOBBLIN_SERVICE_WORK_DIRECTORY|" ./support/templates/reference.tpl >> $GOBBLIN_HOME/conf/service/reference.conf

echo "setting GOBBLIN_SERVICE_PORT="$GOBBLIN_SERVICE_PORT >> ./boot.log
echo "setting KAFKA_BOOTSTRAP_SERVER="$KAFKA_BOOTSTRAP_SERVER >> ./boot.log
echo "setting GOBBLIN_SERVICE_TEMPLATE_PATH="$GOBBLIN_SERVICE_TEMPLATE_PATH >> ./boot.log
# Multiple Replacement, the / character in the environment variable was not working, the delimited was changed to | from \
sed -e "s|\${GOBBLIN_SERVICE_PORT}|$GOBBLIN_SERVICE_PORT|;s|\${KAFKA_BOOTSTRAP_SERVER}|$KAFKA_BOOTSTRAP_SERVER|;s|\${GOBBLIN_SERVICE_TEMPLATE_PATH}|$GOBBLIN_SERVICE_TEMPLATE_PATH|" ./support/templates/application.tpl >> $GOBBLIN_HOME/conf/service/application.conf

# Move the logging file too
cp -f ./support/templates/log4j-service.properties $GOBBLIN_HOME/conf/service
echo "copying files" >> boot.log

chmod +x ./bin/**
sleep 1
./bin/gobblin-service.sh start

echo "Ending" >> ./boot.log

while sleep 1000; do
 echo "sleeping"  
done

