#/bin/bash

set -eo pipefail

echo "installing ${1} @ ${2}"
NODE_VERSIONS=$(curl --silent "https://nodejs.org/dist/index.json")
NODE_VER=$( jq -M -j "[.[] | select(.lts == \"${1}\")] | .[0].version" <<< "${NODE_VERSIONS}" )
DL_URL="https://nodejs.org/download/release/${NODE_VER}/node-${NODE_VER}-linux-x64.tar.gz"
echo "url: ${DL_URL}"

curl -fsSLO ${DL_URL} \
    && tar --strip-components=1 -xvzf node-${NODE_VER}-linux-x64.tar.gz -C ${2}

rm node-${NODE_VER}-linux-x64.tar.gz


