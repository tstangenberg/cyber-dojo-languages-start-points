#!/bin/bash -Eeu

readonly ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly SH_DIR="${ROOT_DIR}/sha"
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo.languages-start-points.XXXXXXXXX)
trap "rm -rf ${TMP_DIR} > /dev/null" INT EXIT
source "${SH_DIR}/echo_versioner_env_vars.sh"
export $(echo_versioner_env_vars)
source "${SH_DIR}/merkely.sh"

# - - - - - - - - - - - - - - - - - - - - - - - -
build_test_tag()
{
  local -r image=cyberdojo/languages-start-points
  local -r names="$(cat "${ROOT_DIR}/git_repo_urls.tagged" | tr '\n' ' ')"

  # build
  export GIT_COMMIT_SHA="$(git_commit_sha)"
  $(cyber_dojo) start-point create "$(image_name)" --languages "${names}"
  unset GIT_COMMIT_SH

  # test
  local -r sha="$(image_sha)"
  assert_equal "$(git_commit_sha)" "${sha}"

  # tag
  local -r tag="${sha:0:7}"
  docker tag "$(image_name):latest" "$(image_name):${tag}"
  echo "tagged with :${tag}"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
image_name()
{
  echo "${CYBER_DOJO_LANGUAGES_START_POINTS_IMAGE}"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
git_commit_sha()
{
  echo "$(cd "${ROOT_DIR}" && git rev-parse HEAD)"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
image_sha()
{
  docker run --entrypoint='' --rm "$(image_name)" sh -c 'echo ${SHA}'
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
if on_ci; then
  merkely_declare_pipeline https://staging.app.merkely.com
  merkely_declare_pipeline https://app.merkely.com
fi

build_test_tag

if on_ci; then
  sha="$(image_sha)"
  tag="${sha:0:7}"
  docker push "$(image_name):latest"
  docker push "$(image_name):${tag}"
  merkely_log_artifact https://staging.app.merkely.com
  merkely_log_artifact https://app.merkely.com
fi

