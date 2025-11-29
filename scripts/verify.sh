#!/usr/bin/env bash

set -euo pipefail

version=${1:-}

if [[ -z "$version" ]]; then
    echo "::error::An input 'version' must be specified"
    exit 1
fi

if [[ ! "${version}" =~ ^[0-9]+.[0-9]+.[0-9]+$ ]]; then
    echo "::error::The Release version '${version}' must match '\d+.\d+.\d+'."
    exit 1
fi

if grep -Fq -- "${version}" "CHANGELOG.md" ; then
    echo "::notice::Release version is: ${version}"
    echo "release-version=${version}" >> $GITHUB_OUTPUT
else
    echo "::error::The Release version '${version}' must in the CHANGELOG."
    exit 1
fi
