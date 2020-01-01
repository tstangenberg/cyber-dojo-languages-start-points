#!/bin/bash -Ee

readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo.languages-start-points.XXXXXXXXX)
trap "rm -rf ${TMP_DIR} > /dev/null" INT EXIT
readonly ROOT_DIR="$( cd "$( dirname "${0}" )" && pwd )"

# - - - - - - - - - - - - - - - - - - - - - - - -
build_test_tag_publish()
{
  local -r scope="${1}"
  local -r image="$(image_name "${scope}")"
  local -r urls="$(cat "${ROOT_DIR}/start-points/${scope}")"
  # build
  export GIT_COMMIT_SHA="$(git_commit_sha)"
  $(script_path) start-point create "${image}" --languages "${urls}"
  unset GIT_COMMIT_SH
  # test
  local -r sha="$(image_sha "${image}")"
  assert_equal "$(git_commit_sha)" "${sha}"
  # tag
  local -r tag="${sha:0:7}"
  docker tag "${image}:latest" "${image}:${tag}"
  echo "tagged with :${tag}"
  # publish
  if ! on_ci; then
    echo 'not on CI so not publishing tagged image'
  else
    echo 'on CI so publishing tagged image'
    # DOCKER_USER, DOCKER_PASS are in ci context
    echo "${DOCKER_PASS}" | docker login --username "${DOCKER_USER}" --password-stdin
    docker push "${image}:latest"
    docker push "${image}:${tag}"
    docker logout
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - -
git_commit_sha()
{
  echo "$(cd "${ROOT_DIR}" && git rev-parse HEAD)"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
image_name()
{
  local -r scope="${1}"
  echo "cyberdojo/languages-start-points-${scope}"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
image_sha()
{
  local -r image="${1}"
  docker run --rm "${image}" sh -c 'echo ${SHA}'
}

# - - - - - - - - - - - - - - - - - - - - - - - -
assert_equal()
{
  local -r expected="${1}"
  local -r actual="${2}"
  if [ "${expected}" != "${actual}" ]; then
    echo ERROR
    echo "expected:'${expected}'"
    echo "  actual:'${actual}'"
    exit 42
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - -
curl_script()
{
  local -r raw_github_org=https://raw.githubusercontent.com/cyber-dojo
  local -r repo=commander
  local -r branch=master
  local -r url="${raw_github_org}/${repo}/${branch}/$(script_name)"
  curl -O --silent --fail "${url}"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
script_path()
{
  if on_ci; then
    echo "./$(script_name)"
  else
    echo "${ROOT_DIR}/../commander/$(script_name)"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - -
script_name()
{
  echo cyber-dojo
}

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci()
{
  [ -n "${CIRCLECI}" ]
}

# - - - - - - - - - - - - - - - - - - - - - - - -
if on_ci; then
  cd "${TMP_DIR}"
  curl_script
  chmod 700 $(script_path)
fi
build_test_tag_publish all
build_test_tag_publish common
build_test_tag_publish small
