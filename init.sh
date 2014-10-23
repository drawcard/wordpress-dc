#!/bin/bash
echo "Creating development branch..."
git checkout -b 'dev'

echo "Adding submodules..."
git submodule add https://github.com/BrunoDeBarros/git-deploy-php deploy/git-deploy-php
git submodule add https://github.com/jplew/SyncDB deploy/SyncDB

#Tracking branch 7.0.0 - update for each new roots release
git submodule add -b 7.0.0 https://github.com/roots/roots-sass content/themes/build 

echo "Pull from repo and fetch latest submodules..."
git pull origin master && git submodule update --init --recursive
git submodule status
sleep 1

echo "Copy git-deploy-php to root folder..."
cp deploy/git-deploy-php/git-deploy .
cp deploy/git-deploy-php/deploy.ini .
echo "Copy complete. Read deploy/git-deploy-php/README.md for further setup & usage instructions."
sleep 1

echo "Copy db-sync to root folder..."
cp deploy/SyncDB/syncdb .
cp deploy/SyncDB/syncdb-config .
echo "Copy complete. Read deploy/SyncDB/README.md for further setup & usage instructions."
sleep 1