#!/bin/bash

echo "Starting dependencies."

docker-compose up --build --force-recreate -d

echo "Dependencies ready, running tests."
sleep 1

ruby server_test.rb
TEST_PASS="$?"
echo "Tests pass? $TEST_PASS"

echo "Stopping dependencies."
docker-compose down

echo "All done."
exit $TEST_PASS
