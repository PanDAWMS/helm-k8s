#!/bin/sh
source /usr/etc/sysconfig/panda_harvester 
/usr/etc/rc.d/init.d/panda_harvester-uwsgi stop 
/usr/sbin/logrotate /usr/etc/panda/harvester_logroate 
/usr/etc/rc.d/init.d/panda_harvester-uwsgi start
