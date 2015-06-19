sudo docker run -it --rm \
       -v /var/log/apache2:/var/log/apache \
       -v ./certs:/etc/pki/tls/certs/logstash-forwader \
       gc2logstashforwader
