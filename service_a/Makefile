
all: test contracts

test:
	./run_tests.sh

contracts: generate-contracts copy-contracts

generate-contracts:
	bundle exec rake

copy-contracts:
	cp consumer/spec/pacts/* ../service_b/pacts/
