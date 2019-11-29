#!/bin/bash
set -e

readonly ROOT_DIR="$( cd "$( dirname "${0}" )" && cd .. && pwd )"
readonly SHA_VALUE=$(cd "${ROOT_DIR}" && git rev-parse HEAD)

readonly GITHUB_ORG=https://raw.githubusercontent.com/cyber-dojo
readonly REPO_NAME=languages-start-points
readonly BRANCH_NAME=master
readonly LANGUAGES_LIST="${GITHUB_ORG}/${REPO_NAME}/${BRANCH_NAME}/url_list"

readonly SCRIPT_NAME=cyber-dojo
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo-languages.XXXXXXXXX)

rm_tmp_dir() { rm -rf ${TMP_DIR} > /dev/null; }
trap rm_tmp_dir EXIT

cd ${TMP_DIR}
curl -O --silent --fail "${GITHUB_ORG}/commander/master/${SCRIPT_NAME}"
chmod 700 ./${SCRIPT_NAME}

IMAGE_NAME=cyberdojo/languages-start-points-all:latest
CYBER_DOJO_LANGUAGES_PORT=4534 \
SHA="${SHA_VALUE}" \
  ./${SCRIPT_NAME} start-point create \
     ${IMAGE_NAME} \
      --languages \
        $(curl --silent --fail "${LANGUAGES_LIST}/all")

IMAGE_NAME=cyberdojo/languages-start-points-common:latest
CYBER_DOJO_LANGUAGES_PORT=4534 \
SHA="${SHA_VALUE}" \
  ./${SCRIPT_NAME} start-point create \
    ${IMAGE_NAME} \
      --languages \
        $(curl --silent --fail "${LANGUAGES_LIST}/common")

IMAGE_NAME=cyberdojo/languages-start-points-small:latest
CYBER_DOJO_LANGUAGES_PORT=4534 \
SHA="${SHA_VALUE}" \
  ./${SCRIPT_NAME} start-point create \
    ${IMAGE_NAME} \
      --languages \
        $(curl --silent --fail "${LANGUAGES_LIST}/small")
