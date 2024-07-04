#!/bin/bash

curl -X POST \
  -H 'Content-Type: application/json' \
  "localhost:9200/my-index/_bulk?pretty" \
  --data-binary @- <<EOF
{ "update": { "_id": "oVcOe5ABNgDlKXAdUfVj", "_index": "my-index" }}
{ "script" : {"source": "ctx._source.remove('field')"} }
{ "doc": {"field1": "field1"}}
EOF

#curl -X POST \
#  -H 'Content-Type: application/json' \
#  "http://localhost:9200/_bulk?pretty" \
#  --data-binary @bulk.json