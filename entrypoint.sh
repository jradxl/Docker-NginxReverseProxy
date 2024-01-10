#!/bin/sh

set -eu

LC_ALL=C
ME=$(basename "$0")
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

echo "ME: <$ME>"
echo "THISISANENVIRONMENTVARIABLE: <$THISISANENVIRONMENTVARIABLE>"
touch /thisfilewascreatedby-entrypoint-dot-sh.txt
echo "INFO: entrypoint.sh script has run."

