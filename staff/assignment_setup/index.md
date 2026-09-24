---
parent: Staff
layout: default
title: "Assignment Setup"
description:  "Information about Setting up Assignments"
---

# {{page.title}} - {{page.description}}

## Copying an assignment from a previous quarter

The following script, which you might call `copy_starter.sh`, can be useful for setting up new assignments.

I suggest putting this inside the directory where you work on starter code repos, for example: `~/github/ucsb-cs156-qxx` where `qxx`is the current quarter.

```
#!/usr/bin/env bash
# copy_starter.sh

set -euo pipefail

usage() {
    cat <<EOF
Usage:
  $0 OLDQTR NEWQTR ASN
  $0 -h
  $0 --help

Creates a new public starter repository for NEWQTR by copying the
corresponding starter repository from OLDQTR.

Example:
  $0 f26 s26 jpa02

This creates:
  ucsb-cs156-s26/STARTER-jpa02
EOF
}

die() {
    echo "Error: $*" >&2
    usage >&2
    exit 1
}

if [[ $# -eq 1 && ( "$1" == "-h" || "$1" == "--help" ) ]]; then
    usage
    exit 0
fi

[[ $# -eq 3 ]] || die "expected OLDQTR, NEWQTR, and ASN"

oldqtr="$1"
newqtr="$2"
asn="$3"

[[ "$oldqtr" =~ ^[A-Za-z0-9._-]+$ ]] || die "invalid old quarter: $oldqtr"
[[ "$newqtr" =~ ^[A-Za-z0-9._-]+$ ]] || die "invalid new quarter: $newqtr"
[[ "$asn" =~ ^[A-Za-z0-9._-]+$ ]] || die "invalid assignment name: $asn"
[[ "$oldqtr" != "$newqtr" ]] || die "old and new quarters must differ"

command -v gh >/dev/null 2>&1 || die "gh is not installed"
command -v git >/dev/null 2>&1 || die "git is not installed"

repo_name="STARTER-${asn}"
old_owner="ucsb-cs156-${oldqtr}"
new_owner="ucsb-cs156-${newqtr}"

old_url="git@github.com:${old_owner}/${repo_name}.git"
new_url="git@github.com:${new_owner}/${repo_name}.git"

[[ ! -e "$repo_name" ]] || die "directory already exists: $repo_name"

gh repo create "${new_owner}/${repo_name}" --public

git clone "$old_url" "$repo_name"

cd "$repo_name"

git remote rename origin "$oldqtr"
git remote add "$newqtr" "$new_url"

git pull "$oldqtr" main
git push "$newqtr" main

echo "Created and pushed ${new_owner}/${repo_name}"
```

## Next steps

* Check for the old quarter in the repo (e.g. s/s26/f26/)
* Check that the autograder, if any, is up to date (see: <https://ucsb-cs156.github.io/staff/autograders/#updating-an-assignment-with-claude>)
