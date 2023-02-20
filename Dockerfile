FROM cassandra:latest

USER root

# change root password to `qwerty`
RUN echo 'root:qwerty' | chpasswd

# install ssh server and other
RUN apt update && apt install -y openssh-server sudo nano curl openjdk-11-jre-headless
RUN mkdir /var/run/sshd

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# allow root to login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# set PermitUserEnvironment to yes
RUN sed -i 's/#PermitUserEnvironment no/PermitUserEnvironment yes/g' /etc/ssh/sshd_config

# generate an SSH key
RUN /usr/bin/ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''
# add its ssh keys to authorized_keys
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN sed -i 's/Dcom.sun.management.jmxremote.authenticate=true/Dcom.sun.management.jmxremote.authenticate=false/g' /etc/cassandra/cassandra-env.sh

RUN echo 'PATH="/opt/cassandra/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"' >> /etc/environment

## Start SSH server
#ENTRYPOINT["/usr/sbin/sshd", "-D"]
