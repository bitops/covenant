
all: test contracts

test:
	./run_tests.sh

contracts: clean-contracts generate-contracts copy-contracts

clean-contracts:
	rm -f consumer/spec/pacts/*

generate-contracts:
	bundle exec rake

copy-contracts:
	cp consumer/spec/pacts/* ../service_b/pacts/
