#!/bin/bash

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -ar NAMES="($(cat "${MY_DIR}/names.all"))"

function create_git_repo_urls_all()
{
  for i in "${!NAMES[@]}"; do
    local name="${NAMES[$i]}"
    echo "https://github.com/cyber-dojo-start-points/${name}"
  done
}

create_git_repo_urls_all > "${MY_DIR}/../start-points/git_repo_urls.all"
