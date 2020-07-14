#!/bin/bash

influxd -config=/etc/influxdb/influxdb.conf & sleep 5

USER_EXISTS=`influx -host=localhost -port=8086 -execute="SHOW USERS" | awk '{print $1}' | grep grafana | wc -l`

if [ -n ${USER_EXISTS} ]
then
  influx -host=localhost -port=8086 -execute="CREATE USER grafana WITH PASSWORD 'grafana' WITH ALL PRIVILEGES"
  influx -host=localhost -port=8086 -username=grafana -password=grafana -execute="create database metrics"
  influx -host=localhost -port=8086 -username=grafana -password=grafana -execute="grant all PRIVILEGES on metrics to grafana"
fi 

while true; do sleep 1; done
