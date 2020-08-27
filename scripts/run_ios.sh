#!/usr/bin/env bash

set -e

FLAVOR=$1

flutter run -t lib/main/main_${FLAVOR}.dart