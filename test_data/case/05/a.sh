#!/bin/sh

exec ./ichipack --exec --instant --multi -d "$0" -- "$@"

echo "TEST '$1' '$2'"

cat $WORKING_DIR/data.txt

##file data.txt
test
