#!/bin/bash

set -ex 

## Build the custom plugin
cd plugin
./gradlew jar
./gradlew --stop
cd ..

## Set up the directory to hold the init script and the plugin jar
rm -fr zip-adds
mkdir -p zip-adds/gradle-8.1.1/lib/plugins zip-adds/gradle-8.1.1/init.d
cp -v plugin/build/libs/*jar zip-adds/gradle-8.1.1/lib/plugins/my-plugin.jar
cp -v plugin/initscript.gradle zip-adds/gradle-8.1.1/init.d/

## Get vanilla gradle 8.1.1 and install our bits
curl -o gradle-8.1.1-1a1-bin.zip https\://services.gradle.org/distributions/gradle-8.1.1-bin.zip -sSL
cd zip-adds
zip -rv ../gradle-8.1.1-1a1-bin.zip *
cd ..
mv -v gradle-8.1.1-1a1-bin.zip g811-1a1/

## This will start a daemon on vanilla gradle 8.1.1.
cd g811
echo '|||||||||||| PASSES:'
./gradlew clean
cd ..

cd g811-1a1

## The first pass will fail because the init script comes from 8.1.1-1a1 but the plugin isn't on the daemon classpath
echo '|||||||||||| FAILS:'
set +e
./gradlew clean
set -e

## The second pass will work because the daemon is started from the 8.1.1-1a1 expansion (with the plugin) and so it works.
echo '|||||||||||| PASSES:'
./gradlew --stop
./gradlew clean

cd ..

