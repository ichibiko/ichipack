
ichipack: src/main.sh
	cp src/main.sh ichipack
	chmod 775 ichipack

test: ichipack
	rm -rf var/test/01
	mkdir -p var/test/01
	sh test_data/case/01.sh
	git diff --no-index test_data/expected var/test
