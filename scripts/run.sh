#!/usr/bin/env bash

set -e

DIR=`dirname $0`

FLAVOR="dev"
#FLAVOR="prod"

if [ "$(uname)" == "Darwin" ]; then
    . "${DIR}/run_ios.sh" "${FLAVOR}"
else
    . "${DIR}/run_android.sh" "${FLAVOR}"
fi