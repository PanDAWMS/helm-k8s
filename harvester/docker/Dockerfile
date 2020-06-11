FROM docker.io/centos:7

RUN yum update -y
RUN yum install -y git procps logrotate mariadb mariadb-* gcc wget sudo vim
RUN wget -O /etc/yum.repos.d/htcondor-stable-rhel7.repo http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo
RUN wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-HTCondor http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-HTCondor
RUN yum install -y condor
RUN echo 'SEC_CLIENT_AUTHENTICATION_METHODS = FS, GSI, CLAIMTOBE' > /etc/condor/config.d/condor_config.local
RUN sed -i '1 s/\#\!\/usr\/bin\/python/\#\!\/usr\/bin\/python2/' /usr/bin/*
RUN sed -i '1 s/\/usr\/bin\/python/\/usr\/bin\/python2/' /usr/libexec/urlgrabber-ext-down
RUN yum install -y python3 python3-devel

#RUN sudo mysql_install_db --user=mysql --ldata=/var/lib/mysql
#RUN chown -R mysql:mysql /var/lib/mysql
#COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN rm /usr/bin/python
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip3 install pip --upgrade
RUN pip install --upgrade setuptools>=39.0.1
RUN python3 -m pip install git+git://github.com/HSF/harvester.git
RUN python3 -m pip install kubernetes uwsgi
RUN python3 -m pip install mysql-connector mysqlclient htcondor
COPY CERN-bundle.pem /etc/pki/tls/certs/CERN-bundle.pem
RUN mkdir /var/log/panda
RUN mkdir /harvester_wdirs
RUN mkdir -p /var/log/harvester/k8slog
RUN mkdir -p /var/log/harvester/condor_logs

WORKDIR /usr
COPY panda_harvester etc/sysconfig/panda_harvester
COPY panda_harvester-uwsgi.ini etc/panda/panda_harvester-uwsgi.ini
COPY panda_harvester-uwsgi etc/rc.d/init.d/panda_harvester-uwsgi
COPY panda_common.cfg etc/panda/panda_common.cfg
COPY harvester-admin local/bin/harvester-admin

RUN ln -s /mnt/panda_harvester.cfg /usr/etc/panda/panda_harvester.cfg
RUN ln -s /mnt/panda_queueconfig /usr/etc/panda/panda_queueconfig


COPY harvester_start.sh /usr/harvester_start.sh
#Entrypoint /usr/etc/rc.d/init.d/panda_harvester-uwsgi 
#CMD runfg
