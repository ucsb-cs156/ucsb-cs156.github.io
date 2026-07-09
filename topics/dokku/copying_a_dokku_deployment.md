---
parent: Dokku
grand_parent: Topics
layout: default
title: "Copying a dokku deployment"
description:  "How to create one deployment from another"
nav_order: 2
---

Once you have one dokku deployment configured, if you are using the same Google OAuth Credentials and 
other config vars, you can create a new deployment with the following script.

Note that after running this script:
* You'll still have to add the new app's url to the callback urls for Google OAuth on the Google Developer Console or OAuth will not work.
* For `proj-frontiers`, you have to define separate `GITHUB_CLIENT_ID`, `GITHUB_CLIENT_SECRET` and `app_private_key` values for each deployment.

```bash
#!/usr/bin/env bash
#
# migrate-dokku-app.sh
#
# Creates a new Dokku app, copies configuration over from an existing app
# (skipping DATABASE_URL/MONGO_URL, which get fresh datastores instead),
# deploys the given repo/branch, and enables Let's Encrypt.
#
# Usage:
#   ./migrate-dokku-app.sh <oldDokku> <newDokku> <repo> <branch> <email>
#
# All five arguments are required.

set -euo pipefail

usage() {
  echo "Usage: $0 <oldDokku> <newDokku> <repo> <branch> <email>" >&2
  exit 1
}

if [ "$#" -ne 5 ]; then
  echo "Error: expected 5 arguments, got $#." >&2
  usage
fi

oldDokku="$1"
newDokku="$2"
repo="$3"
branch="$4"
email="$5"

if [ -z "$oldDokku" ]; then
  echo "Error: oldDokku must not be empty." >&2
  usage
fi
if [ -z "$newDokku" ]; then
  echo "Error: newDokku must not be empty." >&2
  usage
fi
if [ -z "$repo" ]; then
  echo "Error: repo must not be empty." >&2
  usage
fi
if [ -z "$branch" ]; then
  echo "Error: branch must not be empty." >&2
  usage
fi
if [ -z "$email" ]; then
  echo "Error: email must not be empty." >&2
  usage
fi

echo "==> Creating app ${newDokku}"
dokku apps:create "${newDokku}"

echo "==> Setting keep-git-dir on ${newDokku}"
dokku git:set "${newDokku}" keep-git-dir true

echo "==> Checking ${oldDokku} for DATABASE_URL"
if dbUrl=$(dokku config:get "${oldDokku}" DATABASE_URL 2>/dev/null) && [ -n "$dbUrl" ]; then
  echo "    DATABASE_URL is set on ${oldDokku} -- provisioning postgres for ${newDokku}"
  dokku postgres:create "${newDokku}-db"
  dokku postgres:link "${newDokku}-db" "${newDokku}"
else
  echo "    DATABASE_URL not set on ${oldDokku} -- skipping postgres provisioning"
fi

echo "==> Checking ${oldDokku} for MONGO_URL"
if mongoUrl=$(dokku config:get "${oldDokku}" MONGO_URL 2>/dev/null) && [ -n "$mongoUrl" ]; then
  echo "    MONGO_URL is set on ${oldDokku} -- provisioning mongo for ${newDokku}"
  dokku mongo:create "${newDokku}-mongo"
  dokku mongo:link "${newDokku}-mongo" "${newDokku}"
else
  echo "    MONGO_URL not set on ${oldDokku} -- skipping mongo provisioning"
fi

echo "==> Copying non-DATABASE/non-MONGO config vars from ${oldDokku} to ${newDokku}"
copyArgs=()
while IFS= read -r line; do
  [ -z "$line" ] && continue
  # lines from `config:export` look like: export KEY='value'
  line="${line#export }"
  key="${line%%=*}"
  val="${line#*=}"
  # strip one layer of surrounding single quotes and unescape '\'' -> '
  val="${val#\'}"
  val="${val%\'}"
  val="${val//\'\\\'\'/\'}"

  case "$key" in
    *DATABASE*|*MONGO*)
      echo "    skipping ${key} (matches DATABASE/MONGO)"
      continue
      ;;
  esac

  copyArgs+=("${key}=${val}")
done < <(dokku config:export "${oldDokku}")

if [ "${#copyArgs[@]}" -gt 0 ]; then
  dokku config:set --no-restart "${newDokku}" "${copyArgs[@]}"
else
  echo "    no config vars to copy"
fi

echo "==> Syncing ${repo} (branch: ${branch}) to ${newDokku} and building"
dokku git:sync "${newDokku}" "${repo}" "${branch}" --build

echo "==> Configuring Let's Encrypt for ${newDokku}"
dokku letsencrypt:set "${newDokku}" email "${email}"
dokku letsencrypt:enable "${newDokku}"

echo "==> Done. ${newDokku} has been created from ${oldDokku}."
```
