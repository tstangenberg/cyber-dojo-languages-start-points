#!/bin/bash
set -e

readonly ROOT_DIR="$( cd "$( dirname "${0}" )" && cd .. && pwd )"
readonly GITHUB_ORG=https://raw.githubusercontent.com/cyber-dojo
readonly LANGUAGES_START_POINTS="${GITHUB_ORG}/languages-start-points/master/start-points"
readonly SCRIPT_NAME=${ROOT_DIR}/../commander/cyber-dojo

export SHA=$(cd "${ROOT_DIR}" && git rev-parse HEAD)

IMAGE_NAME=cyberdojo/languages-start-points-all:latest
${SCRIPT_NAME} start-point create \
   ${IMAGE_NAME} \
    --languages \
      $(curl --silent --fail "${LANGUAGES_START_POINTS}/all")

IMAGE_NAME=cyberdojo/languages-start-points-common:latest
${SCRIPT_NAME} start-point create \
   ${IMAGE_NAME} \
    --languages \
      $(curl --silent --fail "${LANGUAGES_START_POINTS}/common")

IMAGE_NAME=cyberdojo/languages-start-points-small:latest
${SCRIPT_NAME} start-point create \
  ${IMAGE_NAME} \
    --languages \
      $(curl --silent --fail "${LANGUAGES_START_POINTS}/small")
