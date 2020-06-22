#!/bin/bash

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -ar NAMES="($(cat "${MY_DIR}/names.all"))"

function create_git_repo_urls_all_tagged()
{
  for i in "${!NAMES[@]}"; do
    local name="${NAMES[$i]}"
    #echo "https://github.com/cyber-dojo-languages/${name}"
    local dir="${MY_DIR}/../../../cyber-dojo-start-points/${name}"
    local sha="$(cd "${dir}" && git rev-parse HEAD)"
    local tag=${sha:0:7}
    echo "${tag}@https://github.com/cyber-dojo-start-points/${name}"
  done
}

create_git_repo_urls_all_tagged > "${MY_DIR}/../start-points/git_repo_urls.all.tagged"
