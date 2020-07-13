#!/bin/bash

set -m
CONFIG_TEMPLATE="/influxdb.template.conf"
CONFIG_FILE="/etc/influxdb/influxdb.conf"
CURR_TIMESTAMP=`date +%s`

mv -v $CONFIG_FILE $CONFIG_FILE.$CURR_TIMESTAMP
cp -v $CONFIG_TEMPLATE $CONFIG_FILE

exec influxd -config=$CONFIG_FILE 1>>/var/log/influxdb/influxdb.log 2>&1 &
sleep 5

USER_EXISTS=`influx -host=localhost -port=8086 -execute="SHOW USERS" | awk '{print $1}' | grep grafana | wc -l`

if [ -n ${USER_EXISTS} ]
then
  influx -host=localhost -port=8086 -execute="CREATE USER grafana WITH PASSWORD 'grafana' WITH ALL PRIVILEGES"
  influx -host=localhost -port=8086 -username=grafana -password=grafana -execute="create database metrics"
  influx -host=localhost -port=8086 -username=grafana -password=grafana -execute="grant all PRIVILEGES on metrics to grafana"
fi 

tail -f /var/log/influxdb/influxdb.log
