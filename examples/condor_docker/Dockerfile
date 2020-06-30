FROM docker.io/centos:7

RUN yum update -y
RUN yum install -y  gcc wget sudo vim bind-utils less
RUN wget -O /etc/yum.repos.d/htcondor-stable-rhel7.repo http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-HTCondor http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-HTCondor
RUN yum install -y condor
RUN yum install -y epel-release
RUN yum clean all
RUN yum update -y
RUN yum install -y condor-cream-gahp condor-all 
RUN yum install -y supervisor 
COPY condor_config.local /etc/condor/config.d/condor_config.local 
COPY supervisord.conf /etc/supervisord.conf

Entrypoint /usr/bin/supervisord -c
CMD /etc/supervisord.conf
