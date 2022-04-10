FROM jenkins/jenkins:2.332.2-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN echo 2.112 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.112 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
COPY ./plugins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
COPY groovy/* /usr/share/jenkins/ref/init.groovy.d/
COPY config/*.properties ${JENKINS_HOME}/config/