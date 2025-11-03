
FROM jenkins/jenkins:lts-jdk17

USER root

# Copy plugin list and install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/plugins.txt

COPY jenkins-configration.yaml /usr/share/jenkins/ref/casc_configs/jenkins-configration.yaml



# Create job directory and copy job config
RUN mkdir -p /var/jenkins_home/jobs/portfolio-backend-build
COPY jobs/config.xml /var/jenkins_home/jobs/portfolio-backend-build/config.xml

COPY init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/

RUN chmod 644 /usr/share/jenkins/ref/casc_configs/jenkins-configration.yaml
RUN chown jenkins:jenkins /usr/share/jenkins/ref/casc_configs/jenkins-configration.yaml

USER jenkins
