#!/bin/bash

cd webui/src
npm install .
hem watch &

cd ..
node webui.js
