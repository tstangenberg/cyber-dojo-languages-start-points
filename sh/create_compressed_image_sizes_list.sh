#!/bin/bash -Eeu

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
readonly TMP_FILE=$(mktemp /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
readonly DOCKERHUB=https://hub.docker.com/v2/repositories

remove_tmps() { rm -rf "${TMP_DIR}" > /dev/null; rm "${TMP_FILE}" > /dev/null; }
trap remove_tmps EXIT

source "${MY_DIR}/all_urls.sh"

function image_sizes()
{
  local -r tmp_dir="${1}"
  local -r tmp_file="${2}"
  shift; shift;
  local urls=("$@")
  for i in "${!urls[@]}"
  do
    local url="${urls[$i]}"            # https://github.com/cyber-dojo-start-points/csharp-nunit
    local dir="${tmp_dir}/${i}"
    git clone "${url}" "${dir}" > /dev/null 2>&1

    local image_name=$(cat "${dir}/start_point/manifest.json" | jq --raw-output '.image_name') # cyberdojofoundation/csharp_nunit:32503c4
    local untagged="$(echo ${image_name} | awk -F: '{print $(NF-1)}')" # cyberdojofoundation/csharp_nunit
    local tag="$(echo ${image_name} | awk -F: '{print $(NF)}')"        # 32503c4

    local size=$(curl --silent ${DOCKERHUB}/${untagged}/tags/${tag} | jq '.full_size') # 227987976
    local human=$(human_size "${size}")                                                # 217.42 MiB
    echo "${size} ${image_name} ${human}" | tee -a "${tmp_file}"
  done
}

function human_size()
{
    local i=${1:-0}
    local d=""
    local s=0
    local S=("Bytes" "KiB" "MiB" "GiB" "TiB" "PiB" "EiB" "YiB" "ZiB")
    while ((i > 1024 && s < ${#S[@]}-1)); do
        printf -v d ".%02d" $((i % 1024 * 100 / 1024))
        i=$((i / 1024))
        s=$((s + 1))
    done
    echo "$i$d ${S[$s]}"
}

image_sizes "${TMP_DIR}" "${TMP_FILE}" "${ALL_URLS[@]}"
sort -n -r "${TMP_FILE}" > "${MY_DIR}/../compressed.image_sizes.sorted"
