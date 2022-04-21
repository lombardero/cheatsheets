# Architecture


# 1 - MongoDB's `ReplicaSet`

Replicasets allow us to run several MongoDB instances that work as a cluster. To set up a replica set, we need to:
- Run several MongoDB instances
- Connect them together

> Note: this is a built-in feature, that is in the core of the produce and very
> easy to use. Doing the same in other databases such as `MySQL` or Oracle ones
> is much more complicated.

## Creating MongoDB instances

Running a ReplicaSet with Docker (could be done with `docker-compose`)
```sh
docker network create my-mongo-cluster

docker run --name mongo_rs1 -d --net my-mongo-cluster -p 27021:27021 mongo --port 27021 --replSet replica

docker run --name mongo_rs2 -d --net my-mongo-cluster -p 27022:27022 mongo --port 27022 --replSet replica
```
- Creates a mongoDB network with two replica set mongoDB containers running
- MongoDB arguments:
  - `--replSet`: the name to the given replica set
  - `--port`: the port where the replica will run inside of the container

## Connecting them together

Access one of the replica set instances shell.
```sh
mongosh --port 27021
```

Create the replica set and initiate it:
```sh
> rsconf = {
    _id: "replica",
    members: [
        {
            _id: 0,
            host: "mongo_rs1:27021"
        }
    ]
};
> rs.initiate( rsconf );
```

Adding another node into the replica set
```sh
> rs.add("mongo_rs2:27022")
```

Checking the replica set members:
```sh
> rs.status().members
```

# 2 - Governance algorithm

The primary node is the only one accepting read writes. Writing data will add it to the
primary, which will then write it in the secondary, which are read-only replicas.

Governance of nodes works by voting, to avoid the split brain problem (when connectivity is
lost with other nodes).
- All nodes know the number of nodes in the replica set, there is one primary
- The primary checks that it still can connect to the secondary ones, if it cannot,
  it will lose its primary status and become secondary
- Secondary nodes that cannot reach the primary one will decide with the nodes that can
  be reached, which one becomes the primary

> Note: this all works out-of-the-box and is a built-in feature

> Note 2: MongoDB replicas keep count of the other ones though heartbeats

> Note 3: Primary nodes switch often, so we need to use a MongoDB driver, which route

## Arbiter

An arbiter is a process that breaks even-number MongoDB instances and votes for new
primary nodes. This helps with keeping the distributed system algorithm working.

> Note: arbiters should be added manually (MongoDB does not add them automatically)

# 3 - MongoDB Atlas

MongoDB Atlas is the deployment service provided by MongoDB. It is a pay-as-you-go model.

Abstract-out all the hurdles of deploying the database itself
- No need to care of the underlying service
- Built-in backup
- Built-in high availability


> Note: for mongo, any query that runs for more than 100ms is considered too much

## Additional features

- Profiler: The profiler shows a cloud of datapoints of queries done with query times so that we can do analysis
- Built-in dashboards:
  - IOPS, Scan and Order, Operations, Connections to DB, Memory & CPU, etc.
- Performance Advisories: recommendations to create/delete indexes, optimise queries

