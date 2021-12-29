#!/bin/bash
app_name=$1
env_name=$2

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
ENV_WEBEX_HOOK="https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svODI2ZmMxN2UtM2Y1My00YThlLWJlN2EtM2RlMTEzZTQ4OGU5"
ENV_WEBEX_CHANNEL=#perf_notifications
NEWFOLDER=$timestamp
JMETER_VERSION=5.4.2
NEWFILE=$NEWFOLDER.jtl

CONFIG_DIRECTORY=$PWD/service-config
FILE=$CONFIG_DIRECTORY/${app_name}.txt
echo $FILE
source $FILE
#! testing
ENVIRONMENT_URL=$environment_url
TOTAL_THREADS=$threads
THREADS_INITIAL_DELAY=$threadsinitialdelay
THREADS_STARTTIME=$threadsstarttime
THREADS_HOLDTIME=$threadsholdtime
THREADS_SHUTDOWNTIME=$threadsishutdowntime
TPS0=$tps0
TPS1=$tps1
TPSDURATION1=$tpsdur1
TPS2=$tps2
TPS3=$tps3
TPSDURATION2=$tpsdur2
TPS4=$tps4
TPS5=$tps5
TPSDURATION3=$tpsdur3
TPS6=$tps6
TPS7=$tps7
TPSDURATION4=$tpsdur4
INPUT_FILE1=data/$data_file1
INPUT_FILE2=data/$data_file2
INPUT_FILE3=data/$data_file3
INPUT_FILE4=data/$data_file4
JMX_SCRIPT=$jmx_file
PODS_REQUIRED=$podsrequired
#echo $JMX_SCRIPT $ENVIRONMENT_URL $INPUT_FILE1 $INPUT_FILE2 $INPUT_FILE3 $TOTAL_THREADS $THREADS_INITIAL_DELAY $THREADS_STARTTIME $THREADS_HOLDTIME $threadsishutdowntime $TPS0 $TPS1 $TPSDURATION1 $TPS2 $TPS3 $TPSDURATION2 $TPS4 $TPS5 $TPSDURATION3 $TPS6 $TPS7 $TPSDURATION4 
#Tidy up the old container if one is running
docker rm -f ${app_name}masterjmeter
if [[ $PODS_REQUIRED = "0" ]] ; then

    echo "No argument supplied for number of slaves, continuing with just master"
    timestamp_earlier=$(date +"%s")
    #curl -X POST -H "Content-Type: application/json" -d '{"text" : "Jmeter Test for "'${app_name}'" (Starting) - Use SplunkLink to trace logs ---> https://charter.splunkcloud.com/en-US/app/search/spectrumngprod_containerized_performance_dashboard"}' "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svODI2ZmMxN2UtM2Y1My00YThlLWJlN2EtM2RlMTEzZTQ4OGU5"
    #curl -X POST -H "Content-Type: application/json" -d '{"text" : "Jmeter Test for '${app_name}' (Starting) - Use SplunkLink to trace logs ---> https://charter.splunkcloud.com/en-US/app/search/Overall_Lineup_Dashboard?form.field1.earliest='${timestamp_earlier}'&form.field3=Production_Hits&form.field2='${app_name}'&form.environment='${env_name}'"}' "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svODI2ZmMxN2UtM2Y1My00YThlLWJlN2EtM2RlMTEzZTQ4OGU5"
    curl -X POST -H "Content-Type: application/json" -d '{"text" : "Jmeter Test for '${app_name}' (Starting) - Use SplunkLink to trace logs ---> https://charter.splunkcloud.com/en-US/app/search/Overall_Lineup_Dashboard?form.field1.earliest='${timestamp_earlier}'&form.field3=Production_Hits&form.field2='${app_name}'&form.environment='${env_name}'"}' "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svODI2ZmMxN2UtM2Y1My00YThlLWJlN2EtM2RlMTEzZTQ4OGU5"
    curl -X POST -H "Content-Type: application/json" -d '{"text" : "Datadog Jmeter Link for '${app_name}' (Starting) - Use Datadog Dashboard for Live Jmeter Monitoring ---> https://app.datadoghq.com/dashboard/kmj-2ak-cwg/ptjmeteroverview?tpl_var_deployment=lineupproxyservice&tpl_var_env='${env_name}'&tpl_var_kube_service='${app_name}'&tpl_var_namespace='${env_name}'&tpl_var_service='${app_name}'&tpl_var_thread_group='${app_name}'%2A&live=true"}' "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svODI2ZmMxN2UtM2Y1My00YThlLWJlN2EtM2RlMTEzZTQ4OGU5"
    curl -X POST -H "Content-Type: application/json" -d '{"text" : "Datadog Capacity Metrics Link for '${app_name}' (Starting) - Use Datadog Dashboard for Live Capacity Monitoring ---> https://app.datadoghq.com/dashboard/ah9-pd4-nqg/lineup-services-dashboard?from_ts=1639646857232&to_ts=1639647757232&live=true"}' "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svODI2ZmMxN2UtM2Y1My00YThlLWJlN2EtM2RlMTEzZTQ4OGU5"
    #If not running slaves you can just use the arguments originally passed in to run on master
 

    #docker run --name=masterjmeter -v $(pwd)/jmeterresults:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmeterresults -v $(pwd)/jmetertests/:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests jmetermaster bash /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter -n -t /opt/apache-jmeter-${JMETER_VERSION}/bin/$1 -l /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeterresults/$NEWFOLDER/$NEWFILE > $(pwd)/jmeterresults/$NEWFOLDER/output.txt 2> $(pwd)/jmeterresults/$NEWFOLDER/errors.txt
	
    #docker run -dit --name=${app_name}masterjmeter -v $(pwd)/data:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/data -v $(pwd)/jmetertests/:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests ${app_name}jmetermaster bash
    docker run --memory="5g" --name=${app_name}masterjmeter -v $(pwd)/data:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/data -v $(pwd)/jmetertests/:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests ${app_name}jmetermaster /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter -n -t /opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$JMX_SCRIPT -f -l /opt/apache-jmeter-${JMETER_VERSION}/bin/$NEWFOLDER/$NEWFILE -j /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter_error.log
	
	
    #docker exec ${app_name}masterjmeter sh /opt/apache-jmeter-${JMETER_VERSION}/bin/PluginsManagerCMD.sh install-for-jmx /opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$JMX_SCRIPT
    #docker run -dit --name=masterjmeter -v $(pwd)/jmeterresults:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmeterresults -v $(pwd)/jmeter-scripts/:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter-scripts jmetermaster bash
    #docker exec ${app_name}masterjmeter /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter -n -t /opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$JMX_SCRIPT -f -l /opt/apache-jmeter-${JMETER_VERSION}/bin/$NEWFOLDER/$NEWFILE -j /opt/apache-jmeter-${JMETER_VERSION}/bin/$NEWFOLDER/jmeter_error.log
    #docker exec ${app_name}masterjmeter /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter_error.log
    #curl -X POST -H "Content-Type: application/json" -d '{"text" : "Compiling Results (In Progress)"}' "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svODI2ZmMxN2UtM2Y1My00YThlLWJlN2EtM2RlMTEzZTQ4OGU5"
    
	#docker exec -i ${app_name}masterjmeter cat /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter_error.log
	
    #docker ps -a | grep 'masterjmeter'
    #Remove the container so that we can start another to create the reports & graphs
    docker rm -f ${app_name}masterjmeter
    
    #Run the graph & report generator test on the results file from the first test
    #docker run  --name=masterjmeter -v $(pwd)/jmeterresults:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmeterresults -v $(pwd)/jmetertests/:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests jmetermaster bash /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter -n -t /opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/Graph_Report_Generator.jmx
    docker rmi -f ${app_name}jmeterbase
    docker rmi -f ${app_name}jmetermaster
    docker rmi -f ${app_name}jmeterslave   
    timestamp_latest=$(date +"%s")   
    #curl -X POST -H "Content-Type: application/json" -d '{"text" : "Jmeter Test Result for "'${app_name}'" will be sent in email (Completed)"}' "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svODI2ZmMxN2UtM2Y1My00YThlLWJlN2EtM2RlMTEzZTQ4OGU5"
    curl -X POST -H "Content-Type: application/json" -d '{"text" : "Test Completed - Test Results for '${app_name}' will be sent in email."}' "https://api.ciscospark.com/v1/webhooks/incoming/Y2lzY29zcGFyazovL3VzL1dFQkhPT0svODI2ZmMxN2UtM2Y1My00YThlLWJlN2EtM2RlMTEzZTQ4OGU5"
elif [[ $PODS_REQUIRED > "0" ]] ; then

  #get the number of slaves currently running in docker.
 
  slaves=`docker ps | grep ${app_name}slave | wc -l`
  echo ${slaves}
  #Pass the amount of slaves to for loop so that can incrementally stop and remove them
  for (( i = 1; i <= $slaves; i++ )); do
    #remove the old slave containers if there are any
    echo "removing any running slave containers"
    echo ${app_name}slave0$i
    docker stop ${app_name}slave0$i && docker rm ${app_name}slave0$i
  done
  amount=$PODS_REQUIRED

#Set the variable to grab all the ip addresses of the slaves to pass into the docker run command to master
SLAVEIP=""
SLAVEIPS=""

  #Loop through the count of slaves and create them as well as store their ipaddresses in one variable
  for (( i = 1; i <= $amount; i++ )); do
    #build the slave images
    docker run -dit --name=${app_name}slave0$i  -v $(pwd)/data:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/data -v $(pwd)/jmetertests/:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests ${app_name}jmeterslave /bin/bash
    #build up the comma separated list of ip's to feed into the command to run on master
    SLAVEIP+=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${app_name}slave0$i),
  done
  docker ps
  #Ensure the last comma is taken from the list of ip addresses when passing into the command.
  SLAVEIPS=${SLAVEIP%?}
  echo $SLAVEIPS
  #Run the docker command to master to run the test and pass in the ipaddresses of the slaves to ensure a distributed test is run.
  #docker run --name=masterjmeter -v $(pwd)/jmeterresults:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmeterresults -v $(pwd)/jmetertests/:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests jmetermaster bash /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter -n -t /opt/apache-jmeter-${JMETER_VERSION}/bin/$1 -R$SLAVEIPS -l /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeterresults/$NEWFOLDER/$NEWFILE > $(pwd)/jmeterresults/$NEWFOLDER/output.txt 2> $(pwd)/jmeterresults/$NEWFOLDER/errors.txt
  #docker run --name=masterjmeter -v $(pwd)/jmeterresults:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmeterresults -v $(pwd)/jmetertests/:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests jmetermaster bash /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter -n -t /opt/apache-jmeter-${JMETER_VERSION}/bin/$1 -Jserver.rmi.ssl.disable=true -R$SLAVEIPS -l /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeterresults/$NEWFOLDER/$NEWFILE
  #sleep 10s
  echo $JMX_SCRIPT $ENVIRONMENT_URL $INPUT_FILE1 $INPUT_FILE2 $INPUT_FILE3 $INPUT_FILE4 $TOTAL_THREADS $THREADS_INITIAL_DELAY $THREADS_STARTTIME $THREADS_HOLDTIME $threadsishutdowntime $TPS0 $TPS1 $TPSDURATION1 $TPS2 $TPS3 $TPSDURATION2 $TPS4 $TPS5 $TPSDURATION3 $TPS6 $TPS7 $TPSDURATION4 
  docker run -dit --name=${app_name}masterjmeter -v $(pwd)/data:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/data -v $(pwd)/jmetertests/:/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests ${app_name}jmetermaster /bin/bash
  #docker exec ${app_name}masterjmeter sh /opt/apache-jmeter-${JMETER_VERSION}/bin/PluginsManagerCMD.sh install-for-jmx /opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$JMX_SCRIPT
  #docker exec ${app_name}masterjmeter /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter -n -t /opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$JMX_SCRIPT -R$SLAVEIPS -JenvironmentUrl=$ENVIRONMENT_URL -Jserver.rmi.ssl.disable=true -Jinputfile1=/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$INPUT_FILE1 -Jinputfile2=/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$INPUT_FILE2 -Jinputfile3=/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$INPUT_FILE3 -Jinputfile4=/opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$INPUT_FILE4 -Jthreads=$TOTAL_THREADS -Jthreadsinitialdelay=$THREADS_INITIAL_DELAY -Jthreadsstarttime=$THREADS_STARTTIME -Jthreadsholdtime=$THREADS_HOLDTIME -Jthreadsishutdowntime=$THREADS_SHUTDOWNTIME -Jtps0=$TPS0 -Jtps1=$TPS1 -Jtpsdur1=$TPSDURATION1 -Jtps2=$TPS2 -Jtps3=$TPS3 -Jtpsdur2=$TPSDURATION2 -Jtps4=$TPS4 -Jtps5=$TPS5 -Jtpsdur3=$TPSDURATION3 -Jtps6=$TPS6 -Jtps7=$TPS7 -Jtpsdur4=$TPSDURATION4 -f -l /opt/apache-jmeter-${JMETER_VERSION}/bin/$NEWFOLDER/$NEWFILE -j /opt/apache-jmeter-${JMETER_VERSION}/bin/$NEWFOLDER/jmeter_error.log
  docker exec ${app_name}masterjmeter /opt/apache-jmeter-${JMETER_VERSION}/bin/jmeter -n -t /opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/$JMX_SCRIPT -R$SLAVEIPS -JenvironmentUrl=$ENVIRONMENT_URL -Jserver.rmi.ssl.disable=true  -f -l /opt/apache-jmeter-${JMETER_VERSION}/bin/$NEWFOLDER/$NEWFILE -j /opt/apache-jmeter-${JMETER_VERSION}/bin/$NEWFOLDER/jmeter_error.log
  echo "the master jmeter log"
  docker exec -i ${app_name}masterjmeter cat /opt/apache-jmeter-${JMETER_VERSION}/bin/$NEWFOLDER/jmeter_error.log
  echo "the slave jmeter log"
  docker exec -i ${app_name}slave01 cat jmeter-server.log
  
  slaves=`docker ps | grep ${app_name}slave | wc -l`
  echo $slaves
  for (( i = 1; i <= $slaves; i++ )); do
    #remove the old slave containers if there are any
    echo "removing any running slave containers"
    docker stop ${app_name}slave0$i && docker rm ${app_name}slave0$i
  done
    #Remove the container
    
      docker rm -f ${app_name}masterjmeter
      docker rmi -f ${app_name}jmeterbase
      docker rmi -f ${app_name}jmetermaster
      docker rmi -f ${app_name}jmeterslave
      docker rmi -f phusion/baseimage:bionic-1.0.0
fi
