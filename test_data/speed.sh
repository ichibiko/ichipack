
# Makefile から参照されているファイル
# 
# $ make speed

echo "pattern 1"
time sh -c "for i in \$(seq 10); do sh ./var/ichipack.2 --no-source -d test_data/case/03 >/dev/null; done"
echo

echo "pattern 2"
time sh -c "for i in \$(seq 10); do sh ./var/ichipack.2.with-sources --no-source -d test_data/case/03 >/dev/null; done"
echo

echo "pattern 3"
time sh -c "for i in \$(seq 10); do sh ./var/ichipack.2 -d test_data/case/03 >/dev/null; done"
echo

echo "pattern 4"
time sh -c "for i in \$(seq 10); do sh ./var/ichipack.2.with-sources -d test_data/case/03 >/dev/null; done"
echo

