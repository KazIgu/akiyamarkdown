#!/bin/bash

rm -rf AkiyaMarkDown-darwin-x64

cd dest

npm install

cd ..

electron-packager dest AkiyaMarkDown --platform=darwin --arch=x64 --version=0.29.2 --icon=amd.icns