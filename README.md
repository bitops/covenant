
# Covenant

A repo to do some simple contract testing with [Pact](https://pact.io/).

## Overview

This repo has two services, `service_a` and `service_b`. Service A depends on Service B: it expects there to exist an HTTP get endpoint at `/magic` that returns a payload with certain fields present.

The tests for `service_a` demonstrate all the setup that is needed to run a true end-to-end integration test. Both services are started with docker compose and then the tests are run.

Next, we want to make sure that we maintain this contract between Service A and Service B with pact contract testing.

## Contract tests

If you look in `service_a`, you can see the server code in `service_a/basic_server.rb`. The `Rakefile` in `service_a` is responsible for generating the the consumer side of the Pact.

If you look in `service_b`, you can see the server code for the backend in `service_b/basic_server.rb`. The contract generated by Service A has been copied into `service_b/pacts` -- the run `run_tests.sh` script shows how the contract is verified.

### Notes

Because these are simply Ruby apps which are not Rack-based, all the contracts are simple. It is easy to generate the contracts on the consumer side using existing Ruby pact libraries. For provider side verification, since this was also a non-Rack Ruby application, we are using the standalone `pact-provider-verifier` utility.
