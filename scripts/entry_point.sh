#!/bin/sh

cp config/settings.js data
if [ -e config/flows.json ]; then
  cp config/flows.json data
fi
npm start -- --userDir /data
