#!/usr/bin/env bash

set -e

DIR=`dirname $0`
. "${DIR}/secret.sh"

TITLE="This is the title"
BODY="This is the body"

DATA='
{
    "notification": {
        "title": "'${TITLE}'",
        "body": "'${BODY}'"
    },
    "priority": "high",
    "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "foo": "bar"
    },
    "to": "'${TOKEN}'"
}'

curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "$DATA" -H "Authorization: key=${KEY}"