#!/usr/bin/env bash

Repo=$*
curl "https://registry.hub.docker.com/v2/repositories/library/$Repo/tags/?page_size=1024" 2>/dev/null|jq '."results"[]["name"]' > tag_list.txt
sed -i '' 's/\"//g' tag_list.txt
input="tag_list.txt"
while IFS= read -r var
do
  echo "Pulling image $Repo with tag $var"
  `docker pull 192.168.0.12:5005/$Repo:$var`
done < "$input"
