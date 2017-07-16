
mkdir -p var/test/tmp/03

mkdir -p test_data/case/03/.git
echo c > test_data/case/03/etc/c.txt
echo d > test_data/case/03/etc/d.txt

echo ./ichipack -d test_data/case/03 -o var/test/tmp/03/a.sh
./ichipack -d test_data/case/03 -o var/test/tmp/03/a.sh || exit $?

echo sh var/test/tmp/03/a.sh \> var/test/actual/03/result-a.txt
sh var/test/tmp/03/a.sh > var/test/actual/03/result-a.txt || exit $?

echo sh var/test/tmp/03/a.sh --ichipack-write-sources var/test/tmp/03/sources
sh var/test/tmp/03/a.sh --ichipack-write-sources var/test/tmp/03/sources || exit $?

echo diff -ru test_data/case/03 var/test/tmp/03/sources \> var/test/actual/03/sources.diff
diff -ru test_data/case/03 var/test/tmp/03/sources > var/test/actual/03/sources.diff || true


