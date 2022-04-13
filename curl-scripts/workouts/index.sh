#!/bin/sh

# sh curl-scripts/workouts/index.sh

API="http://localhost:4741"
URL_PATH="/workouts"
TOKEN="8ccaef355f21ce5578f85714e78ef2cf"

curl "${API}${URL_PATH}" \
  --include \
  --request GET \
  --header "Authorization: Bearer ${TOKEN}"

echo
