#!/bin/bash
set -e
OWNER=instrumenta
REPO=kubeval

mkdir -p build/extracted
curl "https://api.github.com/repos/$OWNER/$REPO/releases" | \
  jq 'map(select(.prerelease != true))[0] | {tag: .tag_name, url: (.assets | map(select(.name == "kubeval-linux-amd64.tar.gz"))[0].browser_download_url)}' -r > build/release.json

TAG=$(jq -r .tag build/release.json)
DL_URL=$(jq -r .url build/release.json)

echo "TAG is $TAG"
echo "DL_URL is $DL_URL"

wget "$DL_URL" -O build/release.tar.gz
tar -xvf build/release.tar.gz -C build/extracted
mv build/extracted/kubeval .
rm -rf build/

docker build . -t nanosapp/kubeval:$TAG
docker push nanosapp/kubeval:$TAG
