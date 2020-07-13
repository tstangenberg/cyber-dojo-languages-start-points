
function echo_tagged_git_repo_urls()
{
  local -r tmp_dir="${1}"
  local -r tmp_file="${2}"
  shift; shift;
  local urls=("$@")
  for i in "${!urls[@]}"
  do
    local url="${urls[$i]}"
    local dir="${tmp_dir}/${i}"
    git clone "${url}" "${dir}" > /dev/null 2>&1
    local sha="$(cd "${dir}" && git rev-parse HEAD)"
    local tag=${sha:0:7}
    echo "${tag}@${url}" | tee -a "${tmp_file}"
  done
}
