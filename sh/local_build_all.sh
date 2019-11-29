#!/bin/bash
set -e

readonly ROOT_DIR="$( cd "$( dirname "${0}" )" && cd .. && pwd )"
readonly SHA_VALUE=$(cd "${ROOT_DIR}" && git rev-parse HEAD)

readonly GITHUB_ORG=https://raw.githubusercontent.com/cyber-dojo
readonly LANGUAGES_LIST="${GITHUB_ORG}/languages-start-points/master/url_list"

readonly SCRIPT_NAME=${ROOT_DIR}/../commander/cyber-dojo

CYBER_DOJO_LANGUAGES_PORT=4534 \
SHA="${SHA_VALUE}" \
  ${SCRIPT_NAME} start-point create \
    cyberdojo/languages-start-points-all:latest \
      --languages \
        $(curl --silent --fail "${LANGUAGES_LIST}/all")

CYBER_DOJO_LANGUAGES_PORT=4534 \
SHA="${SHA_VALUE}" \
  ${SCRIPT_NAME} start-point create \
    cyberdojo/languages-start-points-common:latest \
      --languages \
        $(curl --silent --fail "${LANGUAGES_LIST}/common")

CYBER_DOJO_LANGUAGES_PORT=4534 \
SHA="${SHA_VALUE}" \
  ${SCRIPT_NAME} start-point create \
    cyberdojo/languages-start-points-small:latest \
      --languages \
        $(curl --silent --fail "${LANGUAGES_LIST}/small")
