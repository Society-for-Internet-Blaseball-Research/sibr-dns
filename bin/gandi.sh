#!/usr/bin/env bash
output="$(mktemp)"
http_code="$(curl -o "$output" --include --silent --show-error --write-out '%{http_code}' \
    -X PUT "https://api.gandi.net/v5/livedns/domains/$1/records" \
    --data-binary "@$1.zone" \
    --header "Authorization: Apikey $GANDI_API_KEY" \
    --header "Content-Type: text/plain")"
cat "$output"
if [[ $http_code -ne 201 ]]; then
    exit 1
fi
