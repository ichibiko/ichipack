
mkdir -p var/test/tmp/02

echo ./ichipack --no-source -d test_data/case/02 -o var/test/tmp/02/a.sh
./ichipack --no-source -d test_data/case/02 -o var/test/tmp/02/a.sh || exit $?

echo sh var/test/tmp/02/a.sh \> var/test/actual/02/result-a.txt
sh var/test/tmp/02/a.sh > var/test/actual/02/result-a.txt || exit $?

