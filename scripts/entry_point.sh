#!/bin/sh

cp /config/settings.js data
if [ -e config/flows.json ]; then
  cp config/flows.json data
fi
#env file contents expected in bash format export aaa=bbb
source /config/env
npm start -- --userDir /data
