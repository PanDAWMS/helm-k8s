#!/bin/sh
pgrep -x 'sshfs' 1>/dev/null
case $? in
"0")
  echo `date` "sshfs running"
  ;;
"1")
  echo `date` "sshfs is dead. try to start it"
  sshfs -o reconnect,ServerAliveInterval=15 -o ServerAliveCountMax=3 -o allow_other -o StrictHostKeyChecking=no -o IdentityFile=/home/atlpan/atlpan_k8s_sharedfs_id_ecdsa atlpan@aipanda028:/data2/atlpan/sharedvolume/ /sharedfs/
  ;;
*)
  echo `date` "check failed. ERROR!"
esac
