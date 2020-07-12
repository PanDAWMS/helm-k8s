#!/bin/sh
if [ $1 ];then
  OUTFILE=$1
else
  OUTFILE="/mnt/init/SCHEDD_CLUSTER_INITIAL_VALUE"
fi
HOSTNAME=`hostname -f`
mysql -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} --password=${DB_PASSWORD} -e "SELECT MAX(batchid) batchid FROM ${DB_SCHEMA}.work_table WHERE submissionHost='${HOSTNAME},${HOSTNAME}:19618';" > /tmp/MAXID
exitcode=$?
if [ ${exitcode} -ne 0 ]; then
   exit 2
fi
MAXID=`tail -n1 /tmp/MAXID`
if test ${MAXID} == "NULL" ; then
   echo "Not found match submissionHost before. Set SCHEDD_CLUSTER_INITIAL_VALUE to 1."
   echo 1 > ${OUTFILE}
else
   echo "The max batchid remained is "${MAXID}
   let init_value=`echo ${MAXID} | awk '{print $0 +1}'`
   echo "Set SCHEDD_CLUSTER_INITIAL_VALUE to "${init_value}
   echo ${init_value} > ${OUTFILE}
fi
exit 0
