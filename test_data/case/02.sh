
echo ./ichipack -d test_data/case/02 -o var/test/02/a.sh
./ichipack -d test_data/case/02 -o var/test/02/a.sh || exit $?

echo sh var/test/02/a.sh \> var/test/02/result-a.txt
sh var/test/02/a.sh > var/test/02/result-a.txt || exit $?

