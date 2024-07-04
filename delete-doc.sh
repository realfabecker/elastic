#!/bin/bash
f="'field1'"
declare -a data=()
for i in $(bash search.sh | jq --raw-output '.hits.hits[]._id'); do
    data+=('{ "update": { "_id": "'$i'", "_index": "my-index" }}')
    data+=('{"script": "ctx._source.remove('$f')"}')
#  echo "curl -X DELETE http://localhost:9200/my-index/_doc/$i"
#  curl -X DELETE http://localhost:9200/my-index/_doc/$i
done
ids=$(printf "%s\n" "${data[@]}")

curl -X POST \
  -H 'Content-Type: application/json' \
  "localhost:9200/my-index/_bulk?pretty" \
  --data-binary @- <<EOF
$ids
EOF

echo "done..."

 