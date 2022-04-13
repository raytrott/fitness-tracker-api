#!/bin/bash

# sh curl-scripts/workouts/create.sh

API="http://localhost:4741"
URL_PATH="/workouts"
TOKEN="8ccaef355f21ce5578f85714e78ef2cf"
NAME="Upper Body Push"
DATE="4/12/22"
TYPE="Strength"
EXERCISE1="bench press"
EXERCISE2="military press"

curl "${API}${URL_PATH}" \
  --include \
  --request POST \
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
