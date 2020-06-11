# harvester example
This example need csi-cvmfs driver and NFS.

The example will create harvester and condor container.

csi-cvmfs:https://clouddocs.web.cern.ch/containers/tutorials/cvmfs.html

NFS should mount on all node of Kubernetes cluster at the same path "/var/sharedfs"

And set the uid/gid of the directory of NFS the same with "value.yaml" parameter.

