
# Makefile から参照されているファイル
# 
# $ make test

rm -rf var/test

ls test_data/case/*.sh | perl -nle '/^test_data\/case\/([^.]+)\.sh$/ and print "mkdir -p var/test/$1; echo sh ./test_data/case/$1.sh; sh ./test_data/case/$1.sh || exit \$?"' | sh || exit $?

git diff --no-index test_data/expected var/test

