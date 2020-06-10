
contracts: generate-contracts copy-contracts

generate-contracts:
	bundle exec rake

copy-contracts:
	cp consumer/spec/pacts/* ../service_b/provider/pacts/

test:
	./run_tests.sh
