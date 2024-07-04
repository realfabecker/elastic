#!/bin/bash
curl -X POST \
  -H 'Content-Type: application/json' \
  "http://localhost:9200/my-index/_update/l1frepABNgDlKXAdSfX3" \
  -d @- <<EOF 
  { 
    "script": "ctx._source.remove('field1')"
  }
EOF