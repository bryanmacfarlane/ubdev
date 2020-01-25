#/bin/bash

set -e

imagename=ubdev
mappath=/projects

projdir=$(pwd)/..
if [ ! -z "$2" ]; then
    projdir=$2
fi

function failed()
{
   echo "error: $1" >&2
   exit 1
}

echo 'ensuring docker'
which docker || failed "docker not in path"

function build() {
    echo 'building ${imagename} ...'
    docker build -t ${imagename} .
}

function start() {
    echo 'starting dev shell'
    echo "mapping ${projdir}:${mappath}"
    docker run --network host -it -h ${imagename} \
        -v ${projdir}:${mappath} \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -w /projects -it ${imagename} bash
}

"$@"
