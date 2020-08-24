FROM docker.io/centos:7

RUN yum update -y
RUN yum install -y  gcc wget sudo vim bind-utils less git
RUN wget -O /etc/yum.repos.d/htcondor-stable-rhel7.repo http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-HTCondor http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-HTCondor
RUN yum install -y condor
RUN yum install -y epel-release
RUN yum clean all
RUN yum update -y
RUN yum install -y condor-cream-gahp condor-all 
RUN yum install -y supervisor 
RUN yum install -y fuse-sshfs
RUN echo "user_allow_other" > /etc/fuse.conf  
RUN yum install -y python3
WORKDIR /opt
RUN git clone https://github.com/PanDAWMS/HGCS.git
RUN pip3 install --upgrade pip htcondor
RUN cp /opt/HGCS/temp/hgcs.cfg.template /opt/hgcs.cfg
#COPY condor_config.local /etc/condor/config.d/condor_config.local 
COPY supervisord.conf /etc/supervisord.conf
RUN mv /sbin/cream_gahp /sbin/cream_gahp.bak
COPY cream_gahp /sbin/cream_gahp
COPY libclassad.so.8 /usr/lib64/libclassad.so.8

Entrypoint /usr/bin/supervisord -c
CMD /etc/supervisord.conf
