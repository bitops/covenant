
# Covenant

A repo to do some simple contract testing with [Pact](https://pact.io/).

## Overview

This repo has two services, `service_a` and `service_b`. Service A depends on Service B: it expects there to exist an HTTP get endpoint at `/magic` that returns a payload with certain fields present.

The tests for `service_a` demonstrate all the setup that is needed to run a true end-to-end integration test. Both services are started with docker compose and then the tests are run.

Next, we want to make sure that we maintain this contract between Service A and Service B with pact contract testing.
