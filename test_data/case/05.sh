
echo ./ichipack -d test_data/case/05/a.sh --no-source --no-bin-ichipack --instant -o var/test/actual/05/a.sh
./ichipack -d test_data/case/05/a.sh --no-source --no-bin-ichipack --instant -o var/test/actual/05/a.sh || exit $?

echo sh test_data/case/05/a.sh abc def \> var/test/actual/05/a-result.txt
sh test_data/case/05/a.sh abc def > var/test/actual/05/a-result.txt || exit $?

