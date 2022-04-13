#!/bin/bash

# sh curl-scripts/workouts/update.sh

API="http://localhost:4741"
URL_PATH="/workouts"
ID="62560439d580af31cb483848"
TOKEN="8ccaef355f21ce5578f85714e78ef2cf"
NAME="Upper Body Pull"
DATE="4/12/22"
TYPE="Strength"
EXERCISE1="deadlift"
EXERCISE2="lat pulldown"

curl "${API}${URL_PATH}/${ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
--header "Authorization: Bearer ${TOKEN}" \
--data '{
    "workout": {
      "name": "'"${NAME}"'",
      "date": "'"${DATE}"'",
      "type": "'"${TYPE}"'",
      "exercises": [
        "'"${EXERCISE1}"'",
        "'"${EXERCISE2}"'"
      ]
    }
  }'

echo
