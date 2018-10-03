# edge-node-red

see https://nodered.org/docs/platforms/docker

## Build new container using Dockerfile
Can include other nodes from npm this way.
```
docker build -t predix-edge-node-red:<tag> .       //where tag is latest or a version
```

or

```
docker build --build-arg HTTP_PROXY --build-arg HTTPS_PROXY -t predix-edge-node-red:latest .
```

## Run container
docker run is more like docker create in concept.  It creates a container instance.
```
docker run -it -p 1880:1880 --name predix-edge-node-red predix-edge-node-red
```
In order to be on the same network as another docker stack, use docker stack to deploy the containers.
```
docker stack deploy -c docker-compose.yml predix-edge-node-red
```
For Development of Nodes: map this repo dir to /data of container.  This is why our nodes live in a folder called node_modules. e.g. see example lower-case node.  Because Node-Red looks for nodes in the /data/node_modules dir.
```
docker run -it -p 1880:1880 -v `pwd`:/data --name predix-edge-node-red predix-edge-node-red

cd node_modules/lower-case
npm install
docker stop predix-edge-node-red; docker start predix-edge-node-red
refresh node-red in browser
repeat
```

To detach:

```
ctrl-p ctrl-q
```

```
docker attach predix-edge-node-red
```

```
docker stop predix-edge-node-red; docker start predix-edge-node-red
```

```
docker start predix-edge-node-red
```

## Open a shell in the container

```
docker exec -it predix-edge-node-red /bin/bash
```

[![Analytics](https://ga-beacon.appspot.com/UA-82773213-1/predix-rmd-ref-app/readme?pixel)](https://github.com/PredixDev)
