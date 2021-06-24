
![alt text](https://media-exp1.licdn.com/dms/image/C4E0BAQGHz5tVcY2sig/company-logo_200_200/0/1614025520839?e=2159024400&v=beta&t=aRrXcdgxt8I_A6bwCSro-Il6czD2MEZFAnNbfpcYdqQ)

# Elasic Search Setup for Curriki

### 1. Minimum Requirements

* Centos 7  
* 4GB RAM  
* 2 VCPUs  

### 2. Install Docker

https://docs.docker.com/engine/install/centos/

### 3. Install Docker Compose

https://docs.docker.com/compose/install/

### 4. Install git

```bash
sudo yum update -y  
sudo yum install git -y  
git --version    
``` 
### 5. Clone the repository

```bash
git clone https://github.com/ActiveLearningStudio/ActiveLearningStudio-curriki-elastic.git
```
### 6. Make a directory to mount Elastic Data

```bash
sudo mkdir -p /home/elastic-data
``` 

```diff
- You have to choose one option either the 7-A or 7-B
```

### 7-A. Run the follwing commands to install Elastic Search with Docker-compose  

```bash
cd ActiveLearningStudio-curriki-elastic
```
When you run the below command this will read the following three values from the terminal.  
  
Enter The Name of Client/Company: (this could be any name)  
Enter The ES Password: (Password you want to setup for ElastciSeach)  
Enter The ES PORT: (Port you want to setup for ElastciSeach)  

```bash
./deploy_elasticSearch_with_compose.sh
```

### 7-B. Run the follwing commands to install Elastic Search  with Docker Swarm

```bash
cd ActiveLearningStudio-curriki-elastic
```

Intilizae Docker Swarm  

```bash
docker swarm init --advertise-addr (ip_address)
```
When you run the below command this will read the following three values from the terminal.  
   
Enter The Name of Client/Company: (this could be any name)  
Enter The ES Password: (Password you want to setup for ElastciSeach)  
Enter The ES PORT: (Port you want to setup for ElastciSeach)  

```bash
./deploy_elasticSearch_with_swarm.sh
```


### 8. Test Elastic Search with curl

Wait for 2 minutes, Let's the container goes healthy then run the follwing command to test that Elastic Search is working or not.

```bash
curl --user elastic:<ES_PASSWORD> http://<ES_MACHINE_IP_ADDRESS>:<ES_PORT>
```