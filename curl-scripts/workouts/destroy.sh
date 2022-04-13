#!/bin/bash

# sh curl-scripts/workouts/destroy.sh

API="http://localhost:4741"
URL_PATH="/workouts"
ID="6256059dd580af31cb48384a"
TOKEN="8ccaef355f21ce5578f85714e78ef2cf"

curl "${API}${URL_PATH}/${ID}" \
  --include \
  --request DELETE \
  --header "Authorization: Bearer ${TOKEN}"

echo
