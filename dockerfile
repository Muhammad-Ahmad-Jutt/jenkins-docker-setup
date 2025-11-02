

# FROM jenkins/jenkins:lts

# # Switch to root to copy files and fix permissions
# USER root

# # Copy plugin list and install plugins
# COPY plugins.txt /usr/share/jenkins/plugins.txt
# RUN echo "Checking plugin list:" && cat /usr/share/jenkins/plugins.txt
# RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/plugins.txt

# # Copy JCasC YAML file outside of the home volume
# COPY casc/jenkins.yaml /usr/share/jenkins/ref/casc_configs/jenkins.yaml

# # Verify file exists and has correct permissions
# RUN ls -l /usr/share/jenkins/ref/casc_configs/jenkins.yaml
# RUN chmod 644 /usr/share/jenkins/ref/casc_configs/jenkins.yaml
# RUN chown jenkins:jenkins /usr/share/jenkins/ref/casc_configs/jenkins.yaml

# # Set JCasC environment variable
# ENV CASC_JENKINS_CONFIG=/usr/share/jenkins/ref/casc_configs/jenkins.yaml
# ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

# # Switch back to Jenkins user
# USER jenkins

FROM jenkins/jenkins:lts-jdk17

USER root

# Copy plugin list and install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/plugins.txt

COPY casc/jenkins.yaml /usr/share/jenkins/ref/casc_configs/jenkins.yaml


RUN chmod 644 /usr/share/jenkins/ref/casc_configs/jenkins.yaml
RUN chown jenkins:jenkins /usr/share/jenkins/ref/casc_configs/jenkins.yaml

# Set environment for JCasC and disable setup wizard
ENV CASC_JENKINS_CONFIG=/usr/share/jenkins/ref/casc_configs/jenkins.yaml
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

USER jenkins
