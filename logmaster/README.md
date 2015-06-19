sudo docker run --name logstash -it --rm -p 9200:9200 -p 5601:5601 -p 5043:5043 -e IP=YOURIP gc2logstash
docker cp logstash:/etc/pki/tls/certs/logstash.crt /tmp/
