FROM jenkins/jenkins:lts

USER root

# # Install Node.js 20
# RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
#     && apt-get install -y nodejs \
#     && npm install -g npm

# Install Docker CLI & docker-compose plugin
# RUN apt-get update && apt-get install -y docker.io \
#     && mkdir -p /usr/local/lib/docker/cli-plugins \
#     && curl -SL https://github.com/docker/compose/releases/download/v2.28.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose \
#     && chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

USER jenkins
