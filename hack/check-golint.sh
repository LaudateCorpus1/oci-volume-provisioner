#!/bin/bash

# Copyright (c) 2018 Oracle and/or its affiliates. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ./hack/check-golint.sh checks the coding style of our Go code.

set -o errexit
set -o nounset
set -o pipefail

TARGETS=$(for d in "$@"; do echo ./$d/...; done)
echo -n "Checking golint: "
ERRS=$(golint ${TARGETS} 2>&1 | grep -v mock_interfaces.go || true)
if [ -n "${ERRS}" ]; then
    echo "FAIL"
    echo "${ERRS}"
    echo
    exit 1
fi
echo "PASS"
