#!/bin/bash -e
# In order to build this you will need a few ENV variables defined
#
# * `AWS_ECR_DOMAIN`
# * `EXTRA_INDEX_URL`
#
# The base image includes all of the dependencies. It will copy
# `requirements.txt`, `MANIFEST.in`, `setup.cfg` and `setup.py` from the parent
# directory and build opon it.
#
# Once you define the ENV variables above, you can build the base docker image
#
# `./build.sh`
#

build_docker() {
  # Set default for local builds
  AWS_ECR_DOMAIN="${AWS_ECR_DOMAIN:-$(whoami).local}"
  yes | cp -f ../../MANIFEST.in ../../requirements.txt ../../setup.cfg ../../setup.py ./

  if [ "${CIRCLE_BRANCH/#feature/}" != "${CIRCLE_BRANCH}" ] || [ "${CIRCLE_BRANCH}" = "develop" ]; then
    echo $(date +%D) > cache-bust.txt
    echo "." > requirements.txt
    sha1="$( sha1sum cache-bust.txt MANIFEST.in requirements.txt setup.cfg setup.py Dockerfile.template | sha1sum | cut -d' ' -f1 )"
  else
    sha1="$( sha1sum MANIFEST.in requirements.txt setup.cfg setup.py Dockerfile.template | sha1sum | cut -d' ' -f1 )"
  fi

  depsSha1="$( sha1sum Dockerfile.deps | sha1sum | cut -d' ' -f1 )"

  imageName=${AWS_ECR_DOMAIN}/demo:base-${sha1}
  depsImageName=${AWS_ECR_DOMAIN}/demo:deps-${depsSha1}

  echo "Base image name: ${imageName}"
  echo "Deps image name: ${depsImageName}"

  set +e
  docker pull ${depsImageName}

  if [[ $? -eq 1 ]]; then
    set -e
    docker build -t ${depsImageName} --build-arg EXTRA_INDEX_URL=${EXTRA_INDEX_URL} - < Dockerfile.deps
    # Skip for local builds
    if [[ "${CIRCLE_BUILD_IMAGE}" != "" ]]; then
      docker push ${depsImageName}
    fi
  fi
  # Turn error handling back on
  set -e

  sed -e "s~<DEPSIMAGE>~$depsImageName~" < Dockerfile.template > Dockerfile
  set +e
  docker pull ${imageName}

  if [[ $? -eq 1 ]]; then
    set -e
    docker build -t ${imageName} .
    # Skip for local builds
    if [[ "${CIRCLE_BUILD_IMAGE}" != "" ]]; then
      docker push ${imageName}
    fi
  fi

  sed -e "s~<SHA1>~$sha1~; s~<REPO>~$AWS_ECR_DOMAIN~" < ../../Dockerfile.template > ../../Dockerfile
}

build_docker
