#!/bin/bash

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly TMP_DIR=$(mktemp -d ~/tmp.cyber-dojo.commander.start-point.build.XXXXXX)
remove_tmp_dir()
{
  rm -rf "${TMP_DIR}" > /dev/null
}
trap remove_tmp_dir EXIT

declare -ar GIT_REPO_URLS="($(cat "${ROOT_DIR}/start-points/git_repo_urls.all"))"

function get_latest_tags()
{
  for i in "${!GIT_REPO_URLS[@]}"; do
    local url="${GIT_REPO_URLS[$i]}"
    local dir="$(echo "${url}" | awk -F/ '{print $NF}')"
    cp -r ~/repos/cyber-dojo-languages/${dir} ${TMP_DIR}
    cd ${TMP_DIR}/${dir}
    local sha=$(git rev-parse HEAD)
    local tag=${sha:0:7}
    echo "${tag}@${url}"
  done
}

get_latest_tags > "${ROOT_DIR}/start-points/git_repo_urls.all.tagged"
