
ichipack: var/ichipack.2.with-sources
	cp var/ichipack.2.with-sources ./ichipack
	chmod 775 ichipack

var/ichipack.1: src/* main.sh .ichipackignore
	./src/ichipack --no-source -o var/ichipack.1

var/ichipack.2.with-sources: src/* main.sh .ichipackignore var/ichipack.1
	sh ./var/ichipack.1 -o var/ichipack.2.with-sources

var/ichipack.2: src/* main.sh .ichipackignore var/ichipack.1
	sh ./var/ichipack.1 --no-source -o var/ichipack.2

var/ichipack.3: src/* main.sh .ichipackignore var/ichipack.2
	sh ./var/ichipack.2 --no-source -o var/ichipack.3

test: var/ichipack.2 var/ichipack.3 ichipack
	git diff --no-index var/ichipack.2 var/ichipack.3
	sh ./test_data/test.sh

speed: var/ichipack.2 var/ichipack.2.with-sources
	sh ./test_data/speed.sh

