
ichipack: src/main.sh
	cp src/main.sh ichipack
	chmod 775 ichipack

test: ichipack
	sh ./test_data/test.sh

