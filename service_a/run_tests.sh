#!/bin/bash

echo "Starting dependencies."

docker-compose up --build --force-recreate -d

echo "Dependencies ready, running tests."
sleep 1

# integration test
ruby basic_server_test.rb
BASIC_TEST_PASS="$?"

echo "Stopping dependencies."
docker-compose down

# liveness probe test
docker run -d -p 3000:8080 "$(docker build . | grep 'Successfully built' | awk '{print $3}')" > /dev/null
PID="$(docker ps | grep basic_server | awk '{print $1}')"
ruby readiness_probe_server_test.rb
LIVENESS_TEST_PASS="$?"

echo "Basic tests pass? $BASIC_TEST_PASS"
echo "Liveness probe test pass? $LIVENESS_TEST_PASS"

docker stop "$PID" > /dev/null

echo "All done."

if [ "$BASIC_TEST_PASS" == "0" ] && [ "$LIVENESS_TEST_PASS" == "0" ]; then
  exit 0
else
  exit 1
fi
