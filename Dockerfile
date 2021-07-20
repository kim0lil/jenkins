FROM jenkins/jenkins

USER root
RUN apt-get -y update && \ 
    apt-get -y install sudo && \
    apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get -y update && \ 
    apt-get -y install docker-ce && \
    apt-get -y install docker-ce-cli && \
    apt-get -y install containerd.io

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN curl -L https://github.com/docker/compose/releases/download/1.4.1/\
docker-compose-`uname -s`-`uname -m` \
> /usr/local/bin/docker-compose; \
chmod +x /usr/local/bin/docker-compose
USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt