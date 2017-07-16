
(
    cd test_data/case/01
    echo ../../../ichipack --no-source \> ../../../var/test/actual/01/a.sh
    ../../../ichipack --no-source > ../../../var/test/actual/01/a.sh || exit $?
) || exit $?

echo ./ichipack --no-source -d test_data/case/01 \> var/test/actual/01/b.sh
./ichipack --no-source -d test_data/case/01 > var/test/actual/01/b.sh || exit $?

(
    cd test_data/case/01
    echo ../../../ichipack --no-source -o ../../../var/test/actual/01/c.sh
    ../../../ichipack --no-source -o ../../../var/test/actual/01/c.sh || exit $?
) || exit $?

echo ./ichipack --no-source -d test_data/case/01 -o var/test/actual/01/d.sh
./ichipack --no-source -d test_data/case/01 -o var/test/actual/01/d.sh || exit $?

echo sh var/test/actual/01/a.sh \> var/test/actual/01/result-a.txt
sh var/test/actual/01/a.sh > var/test/actual/01/result-a.txt || exit $?
echo sh var/test/actual/01/b.sh \> var/test/actual/01/result-b.txt
sh var/test/actual/01/b.sh > var/test/actual/01/result-b.txt || exit $?
echo sh var/test/actual/01/c.sh \> var/test/actual/01/result-c.txt
sh var/test/actual/01/c.sh > var/test/actual/01/result-c.txt || exit $?
echo sh var/test/actual/01/d.sh \> var/test/actual/01/result-d.txt
sh var/test/actual/01/d.sh > var/test/actual/01/result-d.txt || exit $?

