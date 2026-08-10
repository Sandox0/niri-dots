#!/bin/sh

echo "Uninstalling prior version"
cd $(dirname $1) 2>&1 > /dev/null

# run uninstall w/o any MOJOSETUP vars getting in the way
unset MOJOSETUP_BASE
unset MOJOSETUP_GUIPATH
unset MOJOSETUP_MARKER

if [ -x "$(which script)" ]; then
    echo "Using script to fake tty"
    script --command "$@ --force --noprompt --silent --ui stdio" /dev/null
    sleep 1
else
    $@ --force --noprompt --silent
fi

RET=$?

echo "Uninstall complete: $RET"

exit $RET

