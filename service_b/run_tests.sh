#!/bin/bash

# start docker
docker run -d -p 3000:8080 "$(docker build . | grep 'Successfully built' | awk '{print $3}')"
PID="$(docker ps | grep basic_server | awk '{print $1}')"

# run tests
ruby basic_server_test.rb
TEST_PASS="$?"

# shut down test resources
docker stop "$PID"

# signal tests pass or fail for CI use
exit $TEST_PASS
