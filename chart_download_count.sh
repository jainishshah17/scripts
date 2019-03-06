#!/usr/bin/env bash

curl -s https://oss.jfrog.org/artifactory/api/storage/helm-local/ | jq .children[].uri >> list.txt
sed -i '' 's/\"//g' list.txt

input="list.txt"
totalCount=0
while IFS= read -r var
do
  count=$(curl -s https://oss.jfrog.org/artifactory/api/storage/helm-local$var?stats | jq .downloadCount)
  totalCount=$((totalCount+count))
  echo "Download Count for $var is $count"
done < "$input"
echo "Total Download count is $totalCount"

rm list.txt
