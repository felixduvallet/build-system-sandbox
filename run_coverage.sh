#!/usr/bin/env bash

set -x
set -e

rm -f coverage.html
rm -f coverage.txt
bazel coverage //source/cpp_native/...


# llvm-cov show -instr-profile=bazel-out/k8-fastbuild/testlogs/source/cpp_native/multiply/tests/multiply_tests/coverage.dat bazel-out/k8-fastbuild/bin/source/cpp_native/multiply/tests/multiply_tests -path-equivalence -use-color --format html > coverage.html
# llvm-cov show -instr-profile=bazel-out/k8-fastbuild/testlogs/source/cpp_native/multiply/tests/multiply_tests/coverage.dat bazel-out/k8-fastbuild/bin/source/cpp_native/multiply/tests/multiply_tests -path-equivalence -use-color > coverage.txt

# Compatible with codecov

# llvm-profdata merge -sparse /tmp/llvm_profile/profile-*.profraw -o coverage.profdata

# llvm-cov show ./hello -instr-profile=coverage.profdata > coverage.txt


## Merge then parse

#-sparse \
llvm-profdata merge \
              bazel-out/k8-fastbuild/testlogs/source/cpp_native/add/tests/add_tests/coverage.dat \
              bazel-out/k8-fastbuild/testlogs/source/cpp_native/multiply/tests/multiply_tests/coverage.dat \
              -o aggregate.dat

llvm-cov show -instr-profile=aggregate.dat \
         -object=bazel-out/k8-fastbuild/bin/source/cpp_native/add/tests/add_tests \
         -object=bazel-out/k8-fastbuild/bin/source/cpp_native/multiply/tests/multiply_tests \
         -path-equivalence -use-color > coverage.txt

llvm-cov report -instr-profile=aggregate.dat \
         -object=bazel-out/k8-fastbuild/bin/source/cpp_native/add/tests/add_tests \
         -object=bazel-out/k8-fastbuild/bin/source/cpp_native/multiply/tests/multiply_tests

echo 'Finished'

# cat coverage.txt