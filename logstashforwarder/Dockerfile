FROM debian:jessie

# Suppress prompts from dpkg to resolve conffile differences
ENV DEBIAN_FRONTEND noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
      wget

# Download and install the Public Signing Key:
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -

# Add the repository definition to your /etc/apt/sources.list file:
RUN echo "deb http://packages.elasticsearch.org/logstashforwarder/debian stable main" > /etc/apt/sources.list

# Install logstash forwarder
RUN apt-get update && apt-get install -y \
      logstash-forwarder

# Copy configuration file
COPY ./logstash-forwarder.conf /etc/
RUN mkdir /certs

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Run logstash forwarder
CMD [ "/opt/logstash-forwarder/bin/logstash-forwarder", "-config", "/etc/logstash-forwarder.conf" ]
