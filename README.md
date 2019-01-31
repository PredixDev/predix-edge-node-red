# edge-node-red

see https://nodered.org/docs/platforms/docker

## Build new container using Dockerfile
Can include other nodes from npm this way.
```
docker build -t predixadoption/predix-edge-node-red:<tag> .       //where tag is latest or a version
```

or

```
docker build --build-arg HTTP_PROXY --build-arg HTTPS_PROXY -t predixadoption/predix-edge-node-red:latest .
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


## Bulding and Pushing the docker image to Docker Hub
The Jenkinsfile contains a section to build, test and deploy docker images to docker hub.

Docker needs to be launched in the predixadpotion/prediximage docker image which is in turn running in Propel's Docker container. This is because this predixadoption/prediximage is run within a top-level docker container by propel. So we need to pass in some args during the docker run to make sure the docker daemon is configured for the a specific volume in the current docker container even though the daemon is running one level higher in the propel's docker container (Docker in Docker).

These args in the agent need to be passed during running the docker command initially
```
agent {
    docker {
      image 'predixadoption/devrelprediximage:latest'
      label 'dind'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
```

Once the docker is running with our new volume chnages, we can build the predix-edge-node-red image and then push that image to Docker Hub.


```
docker build --no-cache -t predixadoption/predix-edge-node-red:latest -f Dockerfile .
docker login -u ${DOCKER_REGISTRY_CREDS_USR} -p ${DOCKER_REGISTRY_CREDS_PSW}
docker push predixadoption/predix-edge-node-red:latest
```

## Labels for Docker images

A set of labels are defined in the Dockerfile as shown below -

```
FROM nodered/node-red-docker:slim-v8

LABEL "vendor"="Predix Builder Relations"
LABEL "group"="com.ge.predix.solsvc"
LABEL "org"="predixadoption"
LABEL version="1.0.0"

#example of how to add more node-red nodes
#RUN npm install node-red-node-wordpos
```

Each of the four labels defined in the Dockerfile help the user get information about the docker image that is being built. These labels can also be inspected when a docker image is pulled from docker hub or DTR.

In order to inspect a Docker label from a Docker image we run the following command

The Generic command is as follows:
```
docker inspect -f '{{index .ContainerConfig.Labels "$LABEL_NAME"}}' $Docker_Image:$Tag
```

The Specific inspect commands for this Dockerfile are as follows:
```
docker inspect -f '{{index .ContainerConfig.Labels "vendor"}}' predixadoption/predix-edge-node-red:latest
docker inspect -f '{{index .ContainerConfig.Labels "group"}}' predixadoption/predix-edge-node-red:latest
docker inspect -f '{{index .ContainerConfig.Labels "org"}}' predixadoption/predix-edge-node-red:latest
docker inspect -f '{{index .ContainerConfig.Labels "version"}}' predixadoption/predix-edge-node-red:latest
```


[![Analytics](https://predix-beacon.appspot.com/UA-82773213-1/predix-rmd-ref-app/readme?pixel)](https://github.com/PredixDev)
