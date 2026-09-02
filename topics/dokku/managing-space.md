---
parent: Dokku
grand_parent: Topics
layout: default
title: "Managing Space"
description:  "When your dokku host is misbehaving due to running low on disk space"
nav_order: 1
---

# {{page.title}} - {{page.description}}

There are several things you can try if/when your dokku host starts to misbehave due to lack of disk space.

## How do you know if it's disk space?

This command shows the free disk space:

```
df -h
```

Here is some sample output.  Notice the `93%` on `/`.   That's not good.

```
pconrad@dokku-00:~$ df -h
Filesystem                              Size  Used Avail Use% Mounted on
ripve3-zfs/subvol-3227-disk-0           8.0G  7.5G  607M  93% /
ripve3-zfs/dokku                        5.0T  864G  4.2T  17% /home/dokku
tyr.engr.ucsb.edu:/local/home/class      13T  9.4T  3.7T  72% /fs/class
hal1.engr.ucsb.edu:/local/home/faculty   11T  6.0T  5.1T  55% /fs/faculty
tyr.engr.ucsb.edu:/local/home/group      13T  9.4T  3.7T  72% /fs/group
tyr.engr.ucsb.edu:/local/home/guest      13T  9.4T  3.7T  72% /fs/guest
tyr.engr.ucsb.edu:/local/home/research   13T  9.4T  3.7T  72% /fs/research
hal1.engr.ucsb.edu:/local/home/staff     11T  6.0T  5.1T  55% /fs/staff
tyr.engr.ucsb.edu:/local/home/student    13T  9.4T  3.7T  72% /fs/student
none                                    492K  4.0K  488K   1% /dev
efivarfs                                128K   38K   86K  31% /sys/firmware/efi/efivars
tmpfs                                   504G     0  504G   0% /dev/shm
tmpfs                                   202G   12M  202G   1% /run
tmpfs                                   5.0M     0  5.0M   0% /run/lock
tmpfs                                   101G     0  101G   0% /run/user/22885
tmpfs                                   101G     0  101G   0% /run/user/0
pconrad@dokku-00:~$ 
```

## How can you free up disk space

Here are a few things to try

* Run `dokku cleanup`
* Shut down unnecessary apps.  Use `dokku apps:list` to list all of your apps.  Shut down ones that are not needed.
  (Be sure to communicate with your *entire team* before assuming that an app is not needed though!)
* Run `dokku repo:purge-cache appname` on all of your apps. (There's a script below to do this)


## Script to run `dokku repo:purge-cache appname` on all apps

Here's a script to run this on all of your apps:

```bash
#!/usr/bin/env bash
#
# purge-all-caches.sh
# Purge the dokku build cache for every app on this host.
#
# Usage:
#   ./purge-all-caches.sh          # purge all apps
#   ./purge-all-caches.sh -n       # dry run: show what would be purged
#
set -euo pipefail

DRY_RUN=false
if [[ "${1:-}" == "-n" || "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi

# `dokku apps:list` prints a header line ("=====> My Apps") before the
# app names, so filter to lines that look like app names only.
apps=$(dokku apps:list | grep -v '^=====>' || true)

if [[ -z "$apps" ]]; then
  echo "No apps found."
  exit 0
fi

echo
echo "Disk usage before purge:"
df -h /

echo "Found $(wc -l <<< "$apps") app(s)."
echo

for app in $apps; do
  if $DRY_RUN; then
    echo "[dry-run] would run: dokku repo:purge-cache $app"
  else
    echo "=====> Purging cache for: $app"
    if dokku repo:purge-cache "$app"; then
      echo "       done."
    else
      echo "       WARNING: purge failed for $app (continuing)." >&2
    fi
  fi
done

echo
echo "Disk usage after purge:"
df -h /
```
