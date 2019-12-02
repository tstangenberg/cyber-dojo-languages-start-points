#!/bin/bash
set -e

readonly ROOT_DIR="$( cd "$( dirname "${0}" )" && cd .. && pwd )"

readonly GITHUB_ORG=https://raw.githubusercontent.com/cyber-dojo
readonly REPO_NAME=languages-start-points
readonly BRANCH_NAME=master
readonly LANGUAGES_START_POINTS="${GITHUB_ORG}/${REPO_NAME}/${BRANCH_NAME}/start-points"

readonly SCRIPT_NAME=cyber-dojo
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo-languages.XXXXXXXXX)

rm_tmp_dir() { rm -rf ${TMP_DIR} > /dev/null; }
trap rm_tmp_dir EXIT

cd ${TMP_DIR}
curl -O --silent --fail "${GITHUB_ORG}/commander/master/${SCRIPT_NAME}"
chmod 700 ./${SCRIPT_NAME}

export SHA=$(cd "${ROOT_DIR}" && git rev-parse HEAD)

IMAGE_NAME=cyberdojo/languages-start-points-all:latest
./${SCRIPT_NAME} start-point create \
   ${IMAGE_NAME} \
    --languages \
      $(curl --silent --fail "${LANGUAGES_START_POINTS}/all")

IMAGE_NAME=cyberdojo/languages-start-points-common:latest
./${SCRIPT_NAME} start-point create \
  ${IMAGE_NAME} \
    --languages \
      $(curl --silent --fail "${LANGUAGES_START_POINTS}/common")

IMAGE_NAME=cyberdojo/languages-start-points-small:latest
./${SCRIPT_NAME} start-point create \
  ${IMAGE_NAME} \
    --languages \
      $(curl --silent --fail "${LANGUAGES_START_POINTS}/small")
