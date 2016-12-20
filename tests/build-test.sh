#! /bin/sh

PROJECTDIR="`dirname "$PWD"`"
PROJECTNAME="`basename "${PROJECTDIR}"`"
LIBRARY_SHORTNAME="MulleObjCExpatFoundation"

. "mulle-tests/test-m-common.sh"
. "mulle-tests/test-tools-common.sh"
. "mulle-tests/test-sharedlib-common.sh"
. "mulle-tests/build-test-common.sh"
