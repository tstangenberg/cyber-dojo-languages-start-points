#!/bin/bash -Eeu

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
readonly TMP_FILE=$(mktemp /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
remove_tmps() { rm -rf "${TMP_DIR}" > /dev/null; rm "${TMP_FILE}" > /dev/null; }
trap remove_tmps EXIT
source "${MY_DIR}/echo_tagged_repo_urls.sh"
source "${MY_DIR}/all_urls.sh"

echo_tagged_git_repo_urls "${TMP_DIR}" "${TMP_FILE}" "${ALL_URLS[@]}"
cp "${TMP_FILE}" "${MY_DIR}/../git_repo_urls.tagged"
