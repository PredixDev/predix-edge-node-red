#!/bin/sh

if [ -e /config/settings.js ]; then
  cp /config/settings.js /data
elif [ -e config/settings.js ]; then
  cp config/settings.js /data
fi
if [ -e /config ]; then
  ls -l /config
else
  echo "/config not found"
fi
if [ -e /config/flows.json ]; then
  cp /config/flows.json /data
elif [ -e config/flows.json ]; then
  cp config/flows.json /data
fi
if [ -e /config/env ]; then
  #env file contents expected in bash format export aaa=bbb
  source /config/env
elif [ -e config/env ]; then
  #env file contents expected in bash format export aaa=bbb
  source config/env
fi
npm start -- --userDir /data
