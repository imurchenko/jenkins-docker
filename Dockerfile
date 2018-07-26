FROM jenkins/jenkins:lts

# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-slaves

# install Notifications and Publishing plugins
RUN /usr/local/bin/install-plugins.sh email-ext
RUN /usr/local/bin/install-plugins.sh mailer
RUN /usr/local/bin/install-plugins.sh slack

# Artifacts
RUN /usr/local/bin/install-plugins.sh htmlpublisher

# UI
RUN /usr/local/bin/install-plugins.sh greenballs
RUN /usr/local/bin/install-plugins.sh simple-theme-plugin

# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes

#Pipeline
#RUN /usr/local/bin/install-plugins.sh pipeline

# install Maven
USER root
RUN apt-get update && apt-get install -y maven
ENV KUBERNETES_VERSION=v1.10.3

#install docker
RUN apt-get -y install apt-transport-https ca-certificates gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey
RUN apt-key add /tmp/dkey 
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt-get update && apt-get -y install docker-ce

#install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

USER jenkins
