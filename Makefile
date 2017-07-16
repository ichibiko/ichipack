
ichipack: src/* main.sh .ichipackignore
	./src/ichipack --no-source -o var/ichipack.1
	sh ./var/ichipack.1 -o var/ichipack.2.with-sources
	cp var/ichipack.2.with-sources ./ichipack
	chmod 775 ichipack

test: ichipack
	sh ./var/ichipack.1 --no-source -o var/ichipack.2
	sh ./var/ichipack.2 --no-source -o var/ichipack.3
	git diff --no-index var/ichipack.2 var/ichipack.3
	sh ./test_data/test.sh

