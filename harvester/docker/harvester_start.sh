#!/bin/sh
source /usr/etc/sysconfig/panda_harvester
DB_USER=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.db.user)'`
DB_PASSWORD=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.db.password)'`
DB_HOST=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.db.host)'`
HARVESTER_UID=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.master.uname)'`
HARVESTER_GID=`python -c 'from pandaharvester.harvesterconfig import harvester_config;print(harvester_config.master.gname)'`
#/usr/bin/mysqld_safe --datadir='/var/lib/mysql' --port=3306 --nowatch
groupadd ${HARVESTER_GID}
useradd -g ${HARVESTER_GID} ${HARVESTER_UID}
chown -R ${HARVESTER_UID}:${HARVESTER_GID} /var/log/panda
chown -R ${HARVESTER_UID}:${HARVESTER_GID} /var/log/harvester
chown -R ${HARVESTER_UID}:${HARVESTER_GID} /harvester_wdirs
echo ${HARVESTER_UID} "ALL = (root) NOPASSWD:ALL" > /etc/sudoers.d/${HARVESTER_UID}
while true
do
  mysql -h ${DB_HOST} -u ${DB_USER} --password=${DB_PASSWORD} -e '\q' && break
  sleep 5
done
#mysql -e "create database ${DB_SCHEMA};" && \
#mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}'" && \
#mysql -e "GRANT ALL PRIVILEGES ON ${DB_SCHEMA}.* TO '${DB_USER}'@'localhost';"
while true;
do
  /usr/etc/rc.d/init.d/panda_harvester-uwsgi start
  sleep ${RESTART_CYCLE}
  /usr/etc/rc.d/init.d/panda_harvester-uwsgi stop
  logrotate /usr/etc/panda/panda_logroate
done
