#!/bin/bash
set -e

readonly ROOT_DIR="$( cd "$( dirname "${0}" )" && cd .. && pwd )"
readonly GITHUB_ORG=https://raw.githubusercontent.com/cyber-dojo
readonly LANGUAGES_LIST="${GITHUB_ORG}/languages-start-points/master/url_list"
readonly SCRIPT_NAME=${ROOT_DIR}/../commander/cyber-dojo

export SHA=$(cd "${ROOT_DIR}" && git rev-parse HEAD)
export CYBER_DOJO_LANGUAGES_PORT=4524

IMAGE_NAME=cyberdojo/languages-start-points-all:latest
${SCRIPT_NAME} start-point create \
   ${IMAGE_NAME} \
    --languages \
      $(curl --silent --fail "${LANGUAGES_LIST}/all")

IMAGE_NAME=cyberdojo/languages-start-points-common:latest
${SCRIPT_NAME} start-point create \
   ${IMAGE_NAME} \
    --languages \
      $(curl --silent --fail "${LANGUAGES_LIST}/common")

IMAGE_NAME=cyberdojo/languages-start-points-small:latest
${SCRIPT_NAME} start-point create \
  ${IMAGE_NAME} \
    --languages \
      $(curl --silent --fail "${LANGUAGES_LIST}/small")
