#!/bin/bash

echo "Starting dependencies."

docker-compose up --build --force-recreate -d

echo "Dependencies ready."

clear

echo "Testing backend."
sleep 1
curl -i http://localhost:3001/magic
echo
echo
echo
sleep 3

clear

echo "Testing frontend."
sleep 1
curl -i http://localhost:3000/magic
echo
echo

echo "Stopping dependencies."

docker-compose down
