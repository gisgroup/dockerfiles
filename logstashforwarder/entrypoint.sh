#!/bin/bash
set -e

if [ -n "$MASTER" ]; then
  sed -i "s/MASTER:5043/$MASTER:5043/g" /etc/logstash-forwarder.conf
  exec "$@"
else
  echo "LOGSTASH env var must be set."
  exit 1
fi
