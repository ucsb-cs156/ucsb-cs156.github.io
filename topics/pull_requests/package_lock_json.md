---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: package-lock.json"
description:  "Don't include in PRs unless package.json changed"
indent: true
---

# {{page.title}} - {{page.description}}

A problem frequently observed on PRs in CMPSC 156 is that the student will include changes to `package-lock.json` when there has been no change to `package.json`.

When there has been no change to `package.json`<br />
changes to `package-lock.json` *should not be included* in a PR.

## How do I fix it?

Suppose you have a PR where `package-lock.json` is included, but there has been no change to `package.json`.

There are two ways to fix this.

## Approach one: Update from main branch

This is the most straightforward way that doesn't involve learning any new `git` commands.

1. Go to the github.com site for your repo, and make sure that the `main` branch is selected:
   <img width="153" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/2db4160b-1d5c-4b60-9424-8609e03be370">
2. Navigate to the `frontend/package-lock.json`; it will look something like this:
   <img width="1082" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/e8382ea7-98ad-4a31-b6f3-64a39e15474c">
3. Download the `package-lock.json file` by clicking the button at upper right for `Download raw file`:
   <img width="182" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/ec14364a-8bdf-4a24-abc0-c2ed16aa1066">
4. Copy the downloaded file over the top of the `package-lock.json` for your branch.
5. Commit that version of the file:
   ```
   git add frontend/package-lock.json
   git commit -m "ab - restore package-lock.json to version from main branch"
   ```
6. Push that commit to your branch: <code>git push origin <i>branch-name</i></code>
7. Check the PR on Github: the `package-lock.json` file should no longer be there.

Note that after doing this, you may still need to run `npm install` to get a `package-lock.json` that's appropriate for your platform before you 
can run the software.  If you make sure that you are using the correct version of node (e.g. with <code>nvm use <i>version-number</i></code>, currently: `nvm use 16.20.0` as of this writing)
that will help.  But it may not 100% remove the necessity to have a `package-lock.json` that is different from the one
on Github.

Just be careful when you use `git add .` that you do *not* accidentally scoop up `package-lock.json` into the commit *unless* you are also changing
`package.json` (e.g. to add a new dependency.)

## The fancy git way with `git reset --soft ...`

The fancy git way to do this is to rebuild the commit history but without the changes to package-lock.json.

In this approach, we unwind all of the commits right back to where you started building on the main branch, and then 
read the changed files.  This will lose the detailed commit history, but in the case of a very small PR, this be ok.

1. Get on your branch: `git checkout branch-name`
2. Update your branch from github: `git pull origin branch-name`
3. Reset the branch back to the local version of main, but without changing the file system (that's the `--soft` part)
   ```
   git reset --soft main
   ```
4. Do `git status`.  You should see that none of your files are changed, i.e. you have all of the changes you made in the branch,
   but now, none of them have been committed; they all show as "red".
5. Do `git add` commands to all of the files you want to commit, but *not* `package-lock.json`.
6.
7. You can do files one at a time, like this (though it may be tedious):
   ```
   git add filename1
   git add filename2
   etc.
   ```

   Or, you can add whole directories (just don't add and path that includes `frontend/package-lock.json`):
   ```
   git add src
   git add frontend/src
   ```
9. Do a `git status` command to ensure that the files you want in your commit are green, and the ones you don't want are red.
   In particular, `package-lock.json` should be red.
9. Do a new commit and push to your branch.
9. Check the resulting PR on github.  The `package-lock.json` should be removed.

   
