#!/bin/bash
set -e

readonly ROOT_DIR="$( cd "$( dirname "${0}" )" && cd .. && pwd )"
readonly SHA_VALUE=$(cd "${ROOT_DIR}" && git rev-parse HEAD)

readonly GITHUB_ORG=https://raw.githubusercontent.com/cyber-dojo
readonly REPO_NAME=languages-start-points
readonly BRANCH_NAME=master
readonly LANGUAGES_LIST="${GITHUB_ORG}/${REPO_NAME}/${MASTER}/url_list"

readonly SCRIPT_NAME=cyber-dojo
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo-languages.XXXXXXXXX)

rm_tmp_dir() { rm -rf ${TMP_DIR} > /dev/null; }
trap rm_tmp_dir EXIT

cd ${TMP_DIR}
curl -O --silent --fail "${GITHUB_ORG}/commander/master/${SCRIPT_NAME}"
chmod 700 ./${SCRIPT_NAME}

SHA="${SHA_VALUE}" \
  ./${SCRIPT_NAME} start-point create \
    cyberdojo/languages-start-points-all:latest \
      --languages \
        $(curl --silent --fail "${LANGUAGES_LIST}/all")

SHA="${SHA_VALUE}" \
  ./${SCRIPT_NAME} start-point create \
    cyberdojo/languages-start-points-common:latest \
      --languages \
        $(curl --silent --fail "${LANGUAGES_LIST}/common")

SHA="${SHA_VALUE}" \
  ./${SCRIPT_NAME} start-point create \
    cyberdojo/languages-start-points-small:latest \
      --languages \
        $(curl --silent --fail "${LANGUAGES_LIST}/small")
