
test: test-a test-b

test-a:
	cd service_a; make; cd ..

test-b:
	cd service_b; make; cd ..
