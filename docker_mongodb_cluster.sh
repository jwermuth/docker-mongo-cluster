docker build -t thb1/mongodb mongod

docker build -t thb1/mongos mongos

docker run -P --name=rs1_srv1 -d thb1/mongodb --replSet rs1 --noprealloc --smallfiles

docker run -P --name=rs1_srv2 -d thb1/mongodb --replSet rs1 --noprealloc --smallfiles

docker run -P --name=rs1_srv3 -d thb1/mongodb --replSet rs1 --noprealloc --smallfiles

docker run -P --name=rs2_srv1 -d thb1/mongodb --replSet rs2 --noprealloc --smallfiles

docker run -P --name=rs2_srv2 -d thb1/mongodb --replSet rs2 --noprealloc --smallfiles

docker run -P --name=rs2_srv3 -d thb1/mongodb --replSet rs2 --noprealloc --smallfiles

docker inspect rs1_srv1 | grep IPAddress
docker inspect rs1_srv2 | grep IPAddress
docker inspect rs1_srv3 | grep IPAddress
docker inspect rs2_srv1 | grep IPAddress
docker inspect rs2_srv2 | grep IPAddress
docker inspect rs2_srv3 | grep IPAddress

docker ps -a

Thomass-MBP:docker_mongodb_cluster thomasbentsen$ docker inspect rs1_srv1 | grep IPAddress
        "SecondaryIPAddresses": null,
        "IPAddress": "172.17.0.2",
                "IPAddress": "172.17.0.2",
Thomass-MBP:docker_mongodb_cluster thomasbentsen$ docker inspect rs1_srv2 | grep IPAddress
        "SecondaryIPAddresses": null,
        "IPAddress": "172.17.0.3",
                "IPAddress": "172.17.0.3",
Thomass-MBP:docker_mongodb_cluster thomasbentsen$ docker inspect rs1_srv3 | grep IPAddress
        "SecondaryIPAddresses": null,
        "IPAddress": "172.17.0.4",
                "IPAddress": "172.17.0.4",
Thomass-MBP:docker_mongodb_cluster thomasbentsen$ docker inspect rs2_srv1 | grep IPAddress
        "SecondaryIPAddresses": null,
        "IPAddress": "172.17.0.5",
                "IPAddress": "172.17.0.5",
Thomass-MBP:docker_mongodb_cluster thomasbentsen$ docker inspect rs2_srv2 | grep IPAddress
        "SecondaryIPAddresses": null,
        "IPAddress": "172.17.0.6",
                "IPAddress": "172.17.0.6",
Thomass-MBP:docker_mongodb_cluster thomasbentsen$ docker inspect rs2_srv3 | grep IPAddress
        "SecondaryIPAddresses": null,
        "IPAddress": "172.17.0.7",
                "IPAddress": "172.17.0.7",
Thomass-MBP:docker_mongodb_cluster thomasbentsen$ 
Thomass-MBP:docker_mongodb_cluster thomasbentsen$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                      NAMES
8dfa752696d2        thb1/mongodb        "usr/bin/mongod --rep"   27 seconds ago      Up 26 seconds       0.0.0.0:32780->27017/tcp   rs2_srv3
4b92c004aaa8        thb1/mongodb        "usr/bin/mongod --rep"   28 seconds ago      Up 28 seconds       0.0.0.0:32779->27017/tcp   rs2_srv2
03a5a40e3b93        thb1/mongodb        "usr/bin/mongod --rep"   28 seconds ago      Up 28 seconds       0.0.0.0:32778->27017/tcp   rs2_srv1
fa960dbd18e5        thb1/mongodb        "usr/bin/mongod --rep"   29 seconds ago      Up 28 seconds       0.0.0.0:32777->27017/tcp   rs1_srv3
0e3793a3320b        thb1/mongodb        "usr/bin/mongod --rep"   29 seconds ago      Up 29 seconds       0.0.0.0:32776->27017/tcp   rs1_srv2
d788f68235d7        thb1/mongodb        "usr/bin/mongod --rep"   29 seconds ago      Up 29 seconds       0.0.0.0:32775->27017/tcp   rs1_srv1
Thomass-MBP:docker_mongodb_cluster thomasbentsen$ 

docker run -it --link rs1_srv1:mongo --rm mongo sh -c 'exec mongo "172.17.0.2:32775/test"'






docker run --name my-mongo-instance -d mongo

docker run -it --link my-mongo-instance:mongo --rm mongo sh -c 'exec mongo "$MONGO_PORT_27017_TCP_ADDR:$MONGO_PORT_27017_TCP_PORT/test"'

docker run -v ~/sample-data:/sample-data -it --link my-mongo-instance:mongo --rm mongo sh -c 'exec mongoimport --host $MONGO_PORT_27017_TCP_ADDR:$MONGO_PORT_27017_TCP_PORT --db test --collection restaurants --drop --file sample-data/restaurants.json'
docker run -v ~/sample-data:/sample-data -it --link my-mongo-instance:mongo --rm mongo sh -c 'exec ls -al'

docker run -P --name=cfg1 -d thb1/mongodb --noprealloc --smallfiles --configsvr --dbpath /data/db --port 27017
docker run -P --name=cfg2 -d thb1/mongodb --noprealloc --smallfiles --configsvr --dbpath /data/db --port 27017
docker run -P --name=cfg3 -d thb1/mongodb --noprealloc --smallfiles --configsvr --dbpath /data/db --port 27017

docker inspect cfg1 | grep IPAddress
docker inspect cfg2 | grep IPAddress
docker inspect cfg3 | grep IPAddress

docker run -P --name=mongos1 -d thb1/mongos --port 27017 --configdb 172.17.0.9:27017,172.17.0.9:27017,172.17.0.10:27017

docker inspect mongos1 | grep IPAddress



docker run -it --link rs1_srv1:mongo --rm mongo sh -c 'exec mongo "172.17.0.11/test"'

sh.addShard("rs1/172.17.0.2:27017")
sh.addShard("rs1/172.17.0.5:27017")