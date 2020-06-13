#!/bin/bash

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly TMP_FILE=$(mktemp ~/tmp.cyber-dojo.commander.start-point.build.XXXXXX)
remove_tmp_file()
{
  rm "${TMP_FILE}" > /dev/null
}
trap remove_tmp_file EXIT

declare -ar urls=(
  https://github.com/cyber-dojo-languages/clangplusplus-googletest
  https://github.com/cyber-dojo-languages/csharp-nunit
  https://github.com/cyber-dojo-languages/csharp-specflow
  https://github.com/cyber-dojo-languages/gcc-googletest
  https://github.com/cyber-dojo-languages/gplusplus-boosttest
  https://github.com/cyber-dojo-languages/gplusplus-catch
  https://github.com/cyber-dojo-languages/gplusplus-googletest
  https://github.com/cyber-dojo-languages/java-cucumberpico
  https://github.com/cyber-dojo-languages/java-cucumberspring
  https://github.com/cyber-dojo-languages/java-junit
  https://github.com/cyber-dojo-languages/java-mockito
  https://github.com/cyber-dojo-languages/java-powermockito
  https://github.com/cyber-dojo-languages/javascript-assert
  https://github.com/cyber-dojo-languages/javascript-assert-jquery
  https://github.com/cyber-dojo-languages/javascript-cucumber
  https://github.com/cyber-dojo-languages/javascript-jasmine
  https://github.com/cyber-dojo-languages/javascript-qunit-sinon
  https://github.com/cyber-dojo-languages/javascript-mocha-chai-sinon
  https://github.com/cyber-dojo-languages/python-behave
  https://github.com/cyber-dojo-languages/python-pytest
  https://github.com/cyber-dojo-languages/python-unittest
  https://github.com/cyber-dojo-languages/ruby-minitest
  https://github.com/cyber-dojo-languages/ruby-rspec
  https://github.com/cyber-dojo-languages/ruby-testunit
)

for i in "${!urls[@]}"; do
  url="${urls[$i]}"
  cat "${ROOT_DIR}/start-points/git_repo_urls.all.tagged" | grep "${url}$" >> "${TMP_FILE}"
done

cp "${TMP_FILE}" "${ROOT_DIR}/start-points/git_repo_urls.common.tagged"
