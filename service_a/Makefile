
all: test contracts

test:
	./run_tests.sh

contracts: clean-contracts generate-contracts copy-contracts

clean-contracts:
	rm -f spec/pacts/*

generate-contracts:
	bundle exec rspec spec/magic_spec.rb

copy-contracts:
	cp spec/pacts/* ../service_b/spec/pacts/
