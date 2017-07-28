cat $WORKING_DIR/etc/no-lf.txt
cat $WORKING_DIR/etc/exists-lf.txt
echo

cd $WORKING_DIR
echo WORKING_DIR
find . | sort
echo

cd $HARD_WORKING_DIR
echo HARD_WORKING_DIR
find . | sort

