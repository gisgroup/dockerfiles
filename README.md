# dockerfiles

## Test med docker-compose
Opsætningen kan testes på en enkelt server (fx gc2 vm billdet), ved hjælp af docker-compose (kan installeres med pythons pip).

Bare start en terminal og cd til dockerfiles git-arkiv mappen, og kør

    docker-compose up

Når det skal sættes op med forwarder på én server og logstash på en anden skal det selvfølgelig gøres manuelt:

## Logstash forwarder
Indtil billederne kommer på docker hub skal de lige bygges lokalt først:

    sudo docker build -t gc2logstashmaster logstashmaster
    sudo docker build -t gc2logstashforwarder logstashforwarder

Så skal master logstash serveren startes med info om dennes hostnavn på internettet (til oprettelse af ssl certifikat).

Certifikatet kan oprettes med en IP som hostname med

    sudo docker run --name logstashmaster -p 9200:9200 -p 5601:5601 -p 5043:5043 -e LOGSTASH_IP=INDSÆTDINSERVERIPADDRESSEHER gc2logstashmaster

Eller med et domænenavn ved at bruge (bemærk at det er forskellige miljøvariable som sættes!)

    sudo docker run --name logstashmaster -p 9200:9200 -p 5601:5601 -p 5043:5043 -e LOGSTASH_DOMAIN=INDSÆTDINSERVERIPADDRESSEHER gc2logstashmaster

Så skal certifikattet hentes ud af containeren

    docker cp logstashmaster:/certs/logstash.crt /certs/

Og endelig skal logstash forwarder instansen startes et sted

    sudo docker run \
       -v /certs:/certs \
       -v /var/log/apache2:/var/log/apache \
       -e LOGSTASH=INDSÆTDINSERVERIPADDRESSEHER \
       gc2logstashforwader

Her skal mountes mindst to mapper, en med ssl certifikater, samt en eller flere mapper med log filer.
Nødvendig er også miljøvariablen LOGSTASH som skal pege på IP eller hostnavn på logstash serveren.
