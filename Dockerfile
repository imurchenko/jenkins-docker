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

#Git
RUN /usr/local/bin/install-plugins.sh git

#Docker pipeline
#RUN /usr/local/bin/install-plugins.sh docker-workflow
#RUN /usr/local/bin/install-plugins.sh docker-plugin
#RUN /usr/local/bin/install-plugins.sh docker-build-step

#Google Cloud Build
RUN /usr/local/bin/install-plugins.sh google-oauth-plugin
RUN /usr/local/bin/install-plugins.sh google-cloudbuild

# install Maven
#USER root
#RUN apt-get update && apt-get install -y maven
ENV KUBERNETES_VERSION=v1.10.3

#RUN rm -rf /var/lib/apt/lists/*

#install kubectl
USER root
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

USER jenkins
