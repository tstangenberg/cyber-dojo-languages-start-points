#!/bin/bash -Eeu

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
readonly TMP_FILE=$(mktemp /tmp/cyber-dojo.languages-start-points.build.XXXXXX)
remove_tmps() { rm -rf "${TMP_DIR}" > /dev/null; rm "${TMP_FILE}" > /dev/null; }
trap remove_tmps EXIT
source "${MY_DIR}/echo_tagged_repo_urls.sh"

declare -ar URLS=(
  https://github.com/cyber-dojo-start-points/bash-bats
  https://github.com/cyber-dojo-start-points/bash-shunit2
  https://github.com/cyber-dojo-start-points/bash-unit
  https://github.com/cyber-dojo-start-points/bcpl-alltestspassed
  https://github.com/cyber-dojo-start-points/chapel-assert
  https://github.com/cyber-dojo-start-points/clang-assert
  https://github.com/cyber-dojo-start-points/clang-cgreen
  https://github.com/cyber-dojo-start-points/clangplusplus-assert
  https://github.com/cyber-dojo-start-points/clangplusplus-catch
  https://github.com/cyber-dojo-start-points/clangplusplus-cgreen
  https://github.com/cyber-dojo-start-points/clangplusplus-googlemock
  https://github.com/cyber-dojo-start-points/clangplusplus-googletest
  https://github.com/cyber-dojo-start-points/clangplusplus-igloo
  https://github.com/cyber-dojo-start-points/clojure-midje
  https://github.com/cyber-dojo-start-points/clojure-test
  https://github.com/cyber-dojo-start-points/coffeescript-jasmine
  https://github.com/cyber-dojo-start-points/csharp-moq
  https://github.com/cyber-dojo-start-points/csharp-nunit
  https://github.com/cyber-dojo-start-points/csharp-specflow
  https://github.com/cyber-dojo-start-points/dee-unittest
  https://github.com/cyber-dojo-start-points/elixir-exunit
  https://github.com/cyber-dojo-start-points/erlang-eunit
  https://github.com/cyber-dojo-start-points/fortran-funit
  https://github.com/cyber-dojo-start-points/fsharp-nunit
  https://github.com/cyber-dojo-start-points/gcc-assert
  https://github.com/cyber-dojo-start-points/gcc-cgreen
  https://github.com/cyber-dojo-start-points/gcc-cpputest
  https://github.com/cyber-dojo-start-points/gcc-googletest
  https://github.com/cyber-dojo-start-points/go-convey
  https://github.com/cyber-dojo-start-points/go-testify
  https://github.com/cyber-dojo-start-points/go-testing
  https://github.com/cyber-dojo-start-points/gplusplus-assert
  https://github.com/cyber-dojo-start-points/gplusplus-boosttest
  https://github.com/cyber-dojo-start-points/gplusplus-catch
  https://github.com/cyber-dojo-start-points/gplusplus-cgreen
  https://github.com/cyber-dojo-start-points/gplusplus-cpputest
  https://github.com/cyber-dojo-start-points/gplusplus-cucumber
  https://github.com/cyber-dojo-start-points/gplusplus-googlemock
  https://github.com/cyber-dojo-start-points/gplusplus-googletest
  https://github.com/cyber-dojo-start-points/gplusplus-igloo
  https://github.com/cyber-dojo-start-points/groovy-junit
  https://github.com/cyber-dojo-start-points/groovy-spock
  https://github.com/cyber-dojo-start-points/haskell-hunit
  https://github.com/cyber-dojo-start-points/java-approval
  https://github.com/cyber-dojo-start-points/java-cucumberpico
  https://github.com/cyber-dojo-start-points/java-cucumberspring
  https://github.com/cyber-dojo-start-points/java-jmock
  https://github.com/cyber-dojo-start-points/java-junit
  https://github.com/cyber-dojo-start-points/java-mockito
  https://github.com/cyber-dojo-start-points/java-powermockito
  https://github.com/cyber-dojo-start-points/java-sqlite
  https://github.com/cyber-dojo-start-points/javascript-assert
  https://github.com/cyber-dojo-start-points/javascript-assert-jquery
  https://github.com/cyber-dojo-start-points/javascript-cucumber
  https://github.com/cyber-dojo-start-points/javascript-cucumber-jasmine
  https://github.com/cyber-dojo-start-points/javascript-jasmine
  https://github.com/cyber-dojo-start-points/javascript-mocha-chai-sinon
  https://github.com/cyber-dojo-start-points/javascript-qunit-sinon
  https://github.com/cyber-dojo-start-points/kotlin-test
  https://github.com/cyber-dojo-start-points/nasm-assert
  https://github.com/cyber-dojo-start-points/pascal-assert
  https://github.com/cyber-dojo-start-points/perl-testsimple
  https://github.com/cyber-dojo-start-points/php-unit
  https://github.com/cyber-dojo-start-points/prolog-plunit
  https://github.com/cyber-dojo-start-points/python-approval-pytest
  https://github.com/cyber-dojo-start-points/python-approval-unittest
  https://github.com/cyber-dojo-start-points/python-assert
  https://github.com/cyber-dojo-start-points/python-behave
  https://github.com/cyber-dojo-start-points/python-pytest
  https://github.com/cyber-dojo-start-points/python-unittest
  https://github.com/cyber-dojo-start-points/r-runit
  https://github.com/cyber-dojo-start-points/ruby-approval
  https://github.com/cyber-dojo-start-points/ruby-cucumber
  https://github.com/cyber-dojo-start-points/ruby-minitest
  https://github.com/cyber-dojo-start-points/ruby-rspec
  https://github.com/cyber-dojo-start-points/ruby-testunit
  https://github.com/cyber-dojo-start-points/rust-test
  https://github.com/cyber-dojo-start-points/swift-swordfish
  https://github.com/cyber-dojo-start-points/swift-xctest
  https://github.com/cyber-dojo-start-points/vhdl-assert
  https://github.com/cyber-dojo-start-points/visual-basic-nunit
  https://github.com/cyber-dojo-start-points/zig-test
)

echo_tagged_git_repo_urls "${TMP_DIR}" "${TMP_FILE}" "${URLS[@]}"
cp "${TMP_FILE}" "${MY_DIR}/../start-points/git_repo_urls.all.tagged"
