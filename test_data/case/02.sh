
echo ./ichipack --no-source -d test_data/case/02 -o var/test/actual/02/a.sh
./ichipack --no-source -d test_data/case/02 -o var/test/actual/02/a.sh || exit $?

echo sh var/test/actual/02/a.sh \> var/test/actual/02/result-a.txt
sh var/test/actual/02/a.sh > var/test/actual/02/result-a.txt || exit $?

