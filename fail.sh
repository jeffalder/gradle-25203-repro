#!/bin/bash

set -ex 

cd plugin
./gradlew jar
./gradlew --stop
cd ..

rm -fr zip-adds
mkdir -p zip-adds/gradle-8.1.1/lib/plugins zip-adds/gradle-8.1.1/init.d
cp -v plugin/build/libs/*jar zip-adds/gradle-8.1.1/lib/plugins/my-plugin.jar
cp -v plugin/initscript.gradle zip-adds/gradle-8.1.1/init.d/

curl -o gradle-8.1.1-1a1-bin.zip https\://services.gradle.org/distributions/gradle-8.1.1-bin.zip -sSL
cd zip-adds
zip -rv ../gradle-8.1.1-1a1-bin.zip *
cd ..
mv -v gradle-8.1.1-1a1-bin.zip g811-1a1/

cd g811
echo '|||||||||||| PASSES:'
./gradlew clean
cd ..

cd g811-1a1
echo '|||||||||||| FAILS:'
set +e
./gradlew clean
set -e
echo '|||||||||||| PASSES:'
./gradlew --stop
./gradlew clean

cd ..

