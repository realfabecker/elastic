#!/bin/bash

curl -X PUT -H 'Content-Type: application/json' \
  http://localhost:9200/my-index --data '
  {
   "mappings": {
     "properties": {
        "field1": {"type": "text"}
      }
    }
  }'