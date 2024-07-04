#!/bin/bash
curl -X POST \
  -H 'Content-Type: application/json' \
  "http://localhost:9200/my-index/_doc" \
  --data '{ "field1": "teste"}'