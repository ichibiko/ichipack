#!/bin/sh

exec ./ichipack --exec --instant -d "$0" -- "$@"

echo "TEST '$1' '$2'"

