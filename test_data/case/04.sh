
echo ./ichipack -d test_data/case/04/a.sh --no-source --no-bin-ichipack -o var/test/actual/04/a.sh
./ichipack -d test_data/case/04/a.sh --no-source --no-bin-ichipack -o var/test/actual/04/a.sh || exit $?

echo ./ichipack --exec -d test_data/case/04/a.sh -- abc def \> var/test/actual/04/a-result.txt
./ichipack --exec -d test_data/case/04/a.sh -- abc def > var/test/actual/04/a-result.txt|| exit $?

