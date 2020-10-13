#!/bin/sh
source /usr/etc/sysconfig/panda_harvester
while true
do
  export HARVESTER_UNAME=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.master.uname)'`
  export HARVESTER_GNAME=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.master.gname)'`
  export HARVESTER_UID=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.master.uid)'`
  export HARVESTER_GID=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.master.gid)'`
  groupadd -g ${HARVESTER_GID} ${HARVESTER_GNAME} && \
  useradd -g ${HARVESTER_GID} -u ${HARVESTER_UID} ${HARVESTER_UNAME} && break
  id ${HARVESTER_UNAME} |grep -e ${HARVESTER_UID} -e ${HARVESTER_GNAME} -e ${HARVESTER_GID} && break
  sleep 5
done
chown -R ${HARVESTER_UID}:${HARVESTER_GID} /var/log/panda
echo ${HARVESTER_UNAME} "ALL = (root) NOPASSWD:ALL" > /etc/sudoers.d/${HARVESTER_UNAME}

while true
do
  DB_USER=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.db.user)'`
  DB_PASSWORD=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.db.password)'`
  DB_HOST=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.db.host)'`
  DB_PORT=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.db.port)'`
  mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} --password=${DB_PASSWORD} -e '\q' && break
  sleep 5
done
/usr/etc/rc.d/init.d/panda_harvester-uwsgi start
