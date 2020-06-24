#!/bin/bash -Eeu

readonly ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo.languages-start-points.XXXXXXXXX)
trap "rm -rf ${TMP_DIR} > /dev/null" INT EXIT

# - - - - - - - - - - - - - - - - - - - - - - - -
build_test_tag_on_ci_publish()
{
  local -r scope="${1}"
  local -r image="$(image_name "${scope}")"
  local -r names="$(cat "${ROOT_DIR}/start-points/git_repo_urls.${scope}.tagged")"
  # build
  export GIT_COMMIT_SHA="$(git_commit_sha)"
  $(cyber_dojo) start-point create "${image}" --languages "${names}"
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
cyber_dojo()
{
  local -r name=cyber-dojo
  if [ -x "$(command -v ${name})" ]; then
    >&2 echo "Found executable ${name} on the PATH"
    echo "${name}"
  else
    local -r url="https://raw.githubusercontent.com/cyber-dojo/commander/master/${name}"
    >&2 echo "Did not find executable ${name} on the PATH"
    >&2 echo "Curling it from ${url}"
    curl --fail --output "${TMP_DIR}/${name}" --silent "${url}"
    chmod 700 "${TMP_DIR}/${name}"
    echo "${TMP_DIR}/${name}"
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci()
{
  [ -n "${CIRCLECI:-}" ]
}

# - - - - - - - - - - - - - - - - - - - - - - - -
build_test_tag_on_ci_publish small
build_test_tag_on_ci_publish common
build_test_tag_on_ci_publish all
