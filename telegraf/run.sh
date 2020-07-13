#!/bin/bash

set -m
CONFIG_FILE="/telegraf.template.conf"
hddtemp -d --listen localhost --port 7634 /dev/sd*
mount --bind /hostfs/proc/ /proc/
echo "=> Starting Telegraf ..."
exec telegraf -config $CONFIG_FILE
