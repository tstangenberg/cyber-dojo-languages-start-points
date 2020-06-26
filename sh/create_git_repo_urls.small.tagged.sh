#!/bin/bash -Eeu

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
readonly TMP_FILE=$(mktemp /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
remove_tmps() { rm -rf "${TMP_DIR}" > /dev/null; rm "${TMP_FILE}" > /dev/null; }
trap remove_tmps EXIT
source "${MY_DIR}/echo_tagged_repo_urls.sh"

declare -ar URLS=(
  https://github.com/cyber-dojo-start-points/gcc-assert
  https://github.com/cyber-dojo-start-points/python-unittest
  https://github.com/cyber-dojo-start-points/ruby-minitest
)

echo_tagged_git_repo_urls "${TMP_DIR}" "${TMP_FILE}" "${URLS[@]}"
cp "${TMP_FILE}" "${MY_DIR}/../start-points/git_repo_urls.small.tagged"
