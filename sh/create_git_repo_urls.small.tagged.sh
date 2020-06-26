#!/bin/bash -Eeu

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
readonly TMP_FILE=$(mktemp /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
remove_tmps() { rm -rf "${TMP_DIR}" > /dev/null; rm "${TMP_FILE}" > /dev/null; }
trap remove_tmps EXIT

declare -ar URLS=(
  https://github.com/cyber-dojo-start-points/gcc-assert
  https://github.com/cyber-dojo-start-points/python-unittest
  https://github.com/cyber-dojo-start-points/ruby-minitest
)

function echo_tagged_git_repo_urls()
{
  for i in "${!URLS[@]}"; do
    local url="${URLS[$i]}"
    local dir="${TMP_DIR}/${i}"
    git clone "${url}" "${dir}" > /dev/null 2>&1
    local sha="$(cd "${dir}" && git rev-parse HEAD)"
    local tag=${sha:0:7}
    echo "${tag}@${url}" | tee -a "${TMP_FILE}"
  done
}

echo_tagged_git_repo_urls
cp "${TMP_FILE}" "${ROOT_DIR}/start-points/git_repo_urls.small.tagged"
