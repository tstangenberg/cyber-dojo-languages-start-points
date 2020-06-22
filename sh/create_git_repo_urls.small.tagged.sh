#!/bin/bash

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly TMP_FILE=$(mktemp ~/tmp.cyber-dojo.languages-start-points.build.XXXXXX)
remove_tmp_file()
{
  rm "${TMP_FILE}" > /dev/null
}
trap remove_tmp_file EXIT

declare -ar urls=(
  https://github.com/cyber-dojo-start-points/gcc-assert
  https://github.com/cyber-dojo-start-points/python-unittest
  https://github.com/cyber-dojo-start-points/ruby-minitest
)

for i in "${!urls[@]}"; do
  url="${urls[$i]}"
  cat "${ROOT_DIR}/start-points/git_repo_urls.all.tagged" | grep "${url}" >> "${TMP_FILE}"
done

cp "${TMP_FILE}" "${ROOT_DIR}/start-points/git_repo_urls.small.tagged"
