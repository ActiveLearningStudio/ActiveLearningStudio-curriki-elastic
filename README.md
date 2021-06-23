# Elasic Seach Setup 

![alt text](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.linkedin.com%2Fcompany%2Fcurriki&psig=AOvVaw2LQU3GTQGSUQkl8Y6wGJYV&ust=1624561218536000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCPjUqKe4rvECFQAAAAAdAAAAABAW)

# Prerequisite 

## 1. Minimum Requirements

Centos 7
4GB RAM
2 VCPUs

## 2. Install Docker

https://docs.docker.com/engine/install/centos/

## 2. Install Docker Compose

https://docs.docker.com/compose/install/

# Run the follwing commands to install Elastic Search with Docker-compose


```bash
cd ActiveLearningStudio-curriki-elastic
```
When you run the below command this will read the following three values from the terminal.
Enter The Name of Client/Company: <this could be any name>
Enter The ES Password: <Password you want to setup for ElastciSeach>
Enter The ES PORT: <Password you want to setup for ElastciSeach>

```bash
./deploy_elasticSearch_with_compose.sh
```

# Run the follwing to install Elastic Search with Docker Swarm

```bash
cd ActiveLearningStudio-curriki-elastic
```
When you run the below command this will read the following three values from the terminal.
Enter The Name of Client/Company: <this could be any name>
Enter The ES Password: <Password you want to setup for ElastciSeach>
Enter The ES PORT: <Password you want to setup for ElastciSeach>

```bash
./deploy_elasticSearch_with_swarm.sh
```


# Test Elastci Search Stack

Wait for 2 minutes, Let's the container goes healthy then Run the follwing command to test that elastic Search is working or not.

```bash
curl --user elastic:<ES_PASSWORD> http://localhost:<ES_PORT>
```