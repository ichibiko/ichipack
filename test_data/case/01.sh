
(
    cd test_data/case/01
    echo ../../../ichipack \> ../../../var/test/01/a.sh
    ../../../ichipack > ../../../var/test/01/a.sh || exit $?
) || exit $?

echo ./ichipack -d test_data/case/01 \> var/test/01/b.sh
./ichipack -d test_data/case/01 > var/test/01/b.sh || exit $?

(
    cd test_data/case/01
    echo ../../../ichipack -o ../../../var/test/01/c.sh
    ../../../ichipack -o ../../../var/test/01/c.sh || exit $?
) || exit $?

echo ./ichipack -d test_data/case/01 -o var/test/01/d.sh
./ichipack -d test_data/case/01 -o var/test/01/d.sh || exit $?

