#!/bin/bash

ES_ELASTIC_VOLUME_PATH=/home/elastic-data

echo ' Enter The Name of Client/Company:' 
read ES_CLIENT_NAME

echo ' Enter The ES Password:' $ES_CLIENT_NAME
read ES_ELASTIC_PASSWORD


echo ' Enter The ES PORT:' $ES_CLIENT_NAME
read ES_ELASTIC_PORT


echo ' Create a Volume for client:' $ES_CLIENT_NAME

sudo mkdir -p $ES_ELASTIC_VOLUME_PATH/$ES_CLIENT_NAME

echo ' Change the permissions of newly created volume for:' $ES_CLIENT_NAME

sudo chown -R 1000:1000  $ES_ELASTIC_VOLUME_PATH


cat << EOF > docker-compose-$ES_CLIENT_NAME.yaml
version: '3'
services:
  es${ES_CLIENT_NAME}:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.11.1
    container_name: ${ES_CLIENT_NAME}-es
    environment:
      - node.name=node-${ES_CLIENT_NAME}
      - cluster.name=es-${ES_CLIENT_NAME}-cluster
      - discovery.type=single-node
      - bootstrap.memory_lock=true
      - ELASTIC_PASSWORD=${ES_ELASTIC_PASSWORD}
      - "ES_JAVA_OPTS=-Xms2g -Xmx2g"
      - xpack.security.enabled=true
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ${ES_ELASTIC_VOLUME_PATH}/${ES_CLIENT_NAME}:/usr/share/elasticsearch/data
    ports:
      - ${ES_ELASTIC_PORT}:9200
    networks:
      - net-${ES_CLIENT_NAME}
networks:
  net-${ES_CLIENT_NAME}:
    driver: bridge
EOF

echo ' Deploy Elastic search Stack for ' $ES_CLIENT_NAME

docker-compose -f docker-compose-$ES_CLIENT_NAME.yaml up -d