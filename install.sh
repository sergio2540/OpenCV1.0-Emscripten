#!/usr/bin/env bash

sudo npm install -g https://github.com/CrowdProcess/program-editor/archive/master.tar.gz
sudo npm install -g crowdprocess-cli
sudo npm install -g
wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/1.0/opencv-1.0.0.tar.gz
tar -xvf opencv-1.0.0.tar.gz
cd opencv-1.0.0  
./configure
make
make install
cd ..
