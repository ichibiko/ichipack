
ichipack: src/* main.sh
	./src/ichipack -o var/ichipack.1
	sh ./var/ichipack.1 -o var/ichipack.2
	cp var/ichipack.2 ./ichipack
	chmod 775 ichipack

test: ichipack
	sh ./var/ichipack.2 -o var/ichipack.3
	git diff --no-index var/ichipack.2 var/ichipack.3
	sh ./test_data/test.sh

