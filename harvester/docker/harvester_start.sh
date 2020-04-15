#!/bin/sh
while true;
do
  /usr/etc/rc.d/init.d/panda_harvester-uwsgi start
  sleep ${RESTART_CYCLE}
  /usr/etc/rc.d/init.d/panda_harvester-uwsgi stop
  logrotate /usr/etc/panda/panda_logroate
done
