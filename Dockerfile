FROM nodered/node-red-docker:slim-v8

LABEL maintainer="Predix Builder Relations"
LABEL org="https://hub.docker.com/u/predixadoption"
LABEL repo="predix-edge-node-red"
LABEL version="1.0.12"
LABEL support="https://forum.predix.io"
LABEL license="https://github.com/PredixDev/predix-docker-samples/blob/master/LICENSE.md"

#example of how to add more node-red nodes
#RUN npm install node-red-node-wordpos

COPY ./scripts/entry_point.sh .

USER root
RUN mkdir -p /config
RUN chown node-red:node-red /config
RUN chmod 755 /config

USER node-red
COPY ./settings.js .

ENTRYPOINT ["/usr/src/node-red/entry_point.sh"]
