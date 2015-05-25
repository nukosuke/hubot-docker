[![Build Status](https://travis-ci.org/almat64/hubot-docker.svg)](https://travis-ci.org/almat64/hubot-docker)
# hubot-docker

A hubot script that manage docker container

See [`src/docker.coffee`](src/docker.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-docker --save`

Then add **hubot-docker** to your `external-scripts.json`:

```json
[
  "hubot-docker"
]
```

## Docker Interaction

```
user1>> hubot docker ps
hubot>>
CONTAINER ID  IMAGE            COMMAND                         CREATED     STATUS      PORTS                     NAMES
------------  ---------------  ------------------------------  ----------  ----------  ------------------------  ---------
2379d2c4626a  postgres:latest  /docker-entrypoint.sh postgres  1418659912  Up 2 hours  0.0.0.0:5432->5432/tcp    /postgres
844961435d71  mongo:latest     /entrypoint.sh mongod           1417354180  Up 2 hours  0.0.0.0:27017->27017/tcp  /mongo
960c07a1b23c  redis:latest     /entrypoint.sh redis-server     1416668171  Up 2 hours  0.0.0.0:6379->6379/tcp    /redis
```
