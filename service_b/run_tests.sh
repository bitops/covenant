#!/bin/bash

# start docker
docker run -d -p 3000:8080 "$(docker build . | grep 'Successfully built' | awk '{print $3}')" > /dev/null
PID="$(docker ps | grep basic_server | awk '{print $1}')"

# run tests
ruby spec/basic_server_test.rb
UNIT_TEST_PASS="$?"

# run contract tests
bundle exec pact-provider-verifier spec/pacts/service_a-service_b.json --provider-base-url 'http://localhost:3000'
CONTRACT_TEST_PASS="$?"

# shut down test resources
docker stop "$PID" > /dev/null

# signal tests pass or fail for CI use
if [ "$UNIT_TEST_PASS" == "0" ] && [ "$CONTRACT_TEST_PASS" == "0" ]; then
  exit 0
else
  exit 1
fi
