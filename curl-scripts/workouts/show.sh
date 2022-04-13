#!/bin/sh

# sh curl-scripts/workouts/show.sh

API="http://localhost:4741"
URL_PATH="/workouts"
ID="62560439d580af31cb483848"
TOKEN="8ccaef355f21ce5578f85714e78ef2cf"

curl "${API}${URL_PATH}/${ID}" \
  --include \
  --request GET \
  --header "Authorization: Bearer ${TOKEN}"

echo
