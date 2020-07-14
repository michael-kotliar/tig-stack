FROM telegraf:1.14.5

USER root
ADD telegraf.template.conf /telegraf.template.conf
RUN apt-get update && apt-get -y install build-essential hddtemp
ADD run.sh /run.sh
RUN chmod +x /*.sh

CMD ["/run.sh"]

