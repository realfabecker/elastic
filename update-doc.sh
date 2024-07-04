#!/bin/bash
curl -X POST \
  -H 'Content-Type: application/json' \
  "http://localhost:9200/my-index/_update/l1frepABNgDlKXAdSfX3" \
  --data '{  "doc":{"field1": "teste-242"}}'