FROM jenkins:latest

EXPOSE 8080

ENV JENKINS_MIRROR http://mirrors.jenkins-ci.org

USER root

RUN curl -sSL https://get.docker.com/ | sh
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl; chmod +x ./kubectl; mv ./kubectl /usr/local/bin/kubectl

#RUN usermod -aG docker jenkins

# USER jenkins

COPY plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt

COPY createUser.sh /createUser.sh
COPY config.xml /usr/share/jenkins/ref/config.xml

#COPY config.xml /var/jenkins_home/config.xml



#RUN usermod -aG docker jenkins