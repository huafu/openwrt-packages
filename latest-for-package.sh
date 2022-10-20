#!/usr/bin/env bash

pkg="$1"; shift
version="$1"; shift


[ -z "$pkg" ] && {
    echo "First argument must be the existing package name or repository URL"
    exit 1
}

if [ -f "$pkg/Makefile" ]; then
    repo_url="$( grep -E '^PKG_SOURCE_URL=' "$pkg/Makefile" | cut -d'=' -f2- | sed -E $'s/\\.git$//' )"
else
    repo_url="$( echo "$repo_url" | sed -E $'s/\\.git$//' )"
    pkg="$( echo "$repo_url" | rev | cut -d'/' -f1 | rev )"
fi

local_path="$( mktemp -d -u )"
git_clone() {
    [ -d "$local_path" ] || git clone --no-checkout --depth 20 "$repo_url" "$local_path" >/dev/null 2>&1
    echo "$local_path"
}
git_rm_clone() {
    [ -d "$local_path" ] && rm -rf "$local_path"
}

get_last_version() {
    ( cd "$( git_clone )" && git log --pretty=format:'%H' -n 1 )
}

get_version_date() {
    ( cd "$( git_clone )" && git show -s --format=%cd --date=short "$1" )
}



[ -z "$version" ] && version="$( get_last_version )"

hash="$( curl -L  "${repo_url}/tarball/${version}" 2>/dev/null | sha256sum | cut -d' ' -f 1 )"

echo "PKG_SOURCE_URL:=${repo_url}"
echo "PKG_SOURCE_DATE:=$( get_version_date "${version}" )"
echo "PKG_SOURCE_VERSION:=${version}"
echo "PKG_MIRROR_HASH:=${hash}"

git_rm_clone
