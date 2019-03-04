# edge-node-red

see https://nodered.org/docs/platforms/docker

Predix Edge node-red projects require a config/settings.js
Your existing flows.json may also be in /config and will get picked up when running in Predix Edge

The entry_point.sh script launches the app.  

When using this container in multi-module project, each project can have different settings.js or flows.json simply by creating different Predix Edge config.zip files and deploying via Edge Manager or PETC.  See the [Predix Edge Reference App](https://www.predix.io/resources/tutorials/journey.html#2593) for details.


## Build new container using Dockerfile
Can include other nodes from npm this way.
```
docker build -t predixedge/predix-edge-node-red:<tag> .       //where tag is latest or a version
```

or when behind a proxy server

```
docker build --build-arg HTTP_PROXY --build-arg HTTPS_PROXY -t predixedge/predix-edge-node-red:<tag> .
```

## Run container locally
docker run is more like docker create in concept.  It creates a container instance.
```
docker run -it -p 1880:1880 --name predix-edge-node-red predixedge/predix-edge-node-red
```
## Run container locally like Predix Edge

In order to be on the same network as another docker stack, use docker stack to deploy the containers.
```
docker stack deploy -c docker-compose-local.yml predix-edge-node-red
```

## Node-Red Node Development

For Development of Nodes: map this repo dir to /config of container.  This is why our nodes live in a folder called node_modules. e.g. see example lower-case node.  Because Node-Red looks for nodes in the /config/node_modules dir.
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

## Adding Node Red Nodes

#example of how to add more node-red nodes
#RUN npm install node-red-node-wordpos
```

## Inspecting Labels 

The Specific inspect commands for this Dockerfile are as follows:
```
docker inspect -f '{{index .ContainerConfig.Labels "vendor"}}' predixedge/predix-edge-node-red:latest
docker inspect -f '{{index .ContainerConfig.Labels "group"}}' predixedge/predix-edge-node-red:latest
docker inspect -f '{{index .ContainerConfig.Labels "org"}}' predixedge/predix-edge-node-red:latest
docker inspect -f '{{index .ContainerConfig.Labels "version"}}' predixedge/predix-edge-node-red:latest
```


[![Analytics](https://predix-beacon.appspot.com/UA-82773213-1/predix-edge-node-red/readme?pixel)](https://github.com/PredixDev)
