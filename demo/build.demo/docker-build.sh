#!/bin/bash -e

build_docker() {
  docker build --rm=false -t demo:${CIRCLE_SHA1} --build-arg BUILD_NUM=${CIRCLE_BUILD_NUM} --build-arg SHA1=${CIRCLE_SHA1} .
  docker tag demo:${CIRCLE_SHA1} ${AWS_ECR_DOMAIN}/demo:${CIRCLE_SHA1}
}

build_docker_local() {
  local_sha1=$(echo "local" | sha1sum | cut -d' ' -f1)
  docker build --rm=false -t $(whoami).local/demo:code-${local_sha1} .
}

if [[ "${CIRCLE_BUILD_IMAGE}" != "" ]]; then
  build_docker
else
  build_docker_local
fi

