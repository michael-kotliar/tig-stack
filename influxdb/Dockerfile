FROM influxdb:1.8.0
ADD influxdb.conf /etc/influxdb/influxdb.conf
ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]