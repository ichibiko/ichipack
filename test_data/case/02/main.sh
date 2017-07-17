cat $WORKING_DIR/etc/no-lf.txt
cat $WORKING_DIR/etc/exists-lf.txt
echo

ichipack perm 59830d80-be5c-489f-a4a5-02795c2f80de $WORKING_DIR/test_perm

cd $WORKING_DIR
echo WORKING_DIR
find . | sort
echo

cd $HARD_WORKING_DIR
echo HARD_WORKING_DIR
find . | sort

