#!/bin/bash

curl -X POST \
  -s \
  -H 'Content-Type: application/json' \
  "localhost:9200/my-index/_search?pretty" \
  --data-binary @- <<EOF
{
  "from": 0,
  "size": 50,
  "query": {
    "match_all": {}
  }
}
EOF