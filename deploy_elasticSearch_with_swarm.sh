#!/bin/bash

ES_ELASTIC_VOLUME_PATH=/home/elastic-data/


if [[ -d $ES_ELASTIC_VOLUME_PATH ]]
then
    echo "$ES_ELASTIC_VOLUME_PATH  Directory already exists"
else
  mkdir -p $ES_ELASTIC_VOLUME_PATH
  echo "Directory $ES_ELASTIC_VOLUME_PATH created to mount your ElasticSearch Data"    
fi

echo ' Enter The Name of client:' 
read ES_CLIENT_NAME

echo ' Enter The ES Password for client:' $ES_CLIENT_NAME
read ES_ELASTIC_PASSWORD


echo ' Enter The ES PORT for client:' $ES_CLIENT_NAME
read ES_ELASTIC_PORT

echo ' Enter The Replicas in Swarm for client:' $ES_CLIENT_NAME
read ES_REPLICAS


echo ' Creating a Volume for client:' $ES_CLIENT_NAME

mkdir -p $ES_ELASTIC_VOLUME_PATH/$ES_CLIENT_NAME

echo ' Changing the permissions of newly created volume for:' $ES_CLIENT_NAME

chown -R 1000:1000  $ES_ELASTIC_VOLUME_PATH


cat << EOF > docker-compose-swarm-$ES_CLIENT_NAME.yaml
version: '3'
services:
  es${ES_CLIENT_NAME}:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.11.1
    container_name: ${ES_CLIENT_NAME}-es
    environment:
      - node.name=node-${ES_CLIENT_NAME}
      - node.max_local_storage_nodes=20
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
    deploy:
      replicas: ${ES_REPLICAS}
      update_config:
        parallelism: 1
        delay: 10s
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
        window: 120s
    # healthcheck:
    #   test: ["CMD-SHELL", "curl --silent --fail localhost:9200/_cluster/health || exit 1"]
    #   interval: 30s
    #   timeout: 30s
    #   retries: 3 

EOF

echo ' Deploy Elastic search Stack for ' $ES_CLIENT_NAME

docker stack deploy --compose-file docker-compose-swarm-$ES_CLIENT_NAME.yaml stack-$ES_CLIENT_NAME