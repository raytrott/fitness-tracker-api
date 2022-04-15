#!/bin/bash

# sh curl-scripts/auth/change-password.sh

API="http://localhost:4741"
URL_PATH="/change-password"
TOKEN=""
OLDPW=""
NEWPW=""

curl "${API}${URL_PATH}/" \
  --include \
  --request PATCH \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${OLDPW}"'",
      "new": "'"${NEWPW}"'"
    }
  }'

echo
