#!/bin/bash

# sh curl-scripts/workouts/create.sh

API="http://localhost:4741"
URL_PATH="/workouts"
NAME="Upper Body Push"
DATE="4/12/22"
TYPE="Strength"
EXERCISES="['bench press', 'military press', 'tricep pulldown']"

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
      "exercises": "'"${EXERCISES}"'"
    }
  }'

echo
