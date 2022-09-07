---
parent: Topics
layout: default
title: "Spring/React: package-lock.json Merge Conflicts"
description:  "How to resolve these"
category_prefix: "Spring React: "
indent: true
---

When you get a merge conflict in `package-lock.json`, the best way to resolve it is to simply regenerate the `package-lock.json`.

Steps:

1. Do a `git fetch`.  Here's what this done: your local repo has cached values for the branch pointers on the remotes (e.g. `origin`, which is typically the repo on GitHub).   `git fetch` updates these branch pointers.
2. Checkout your feature branch `git checkout feature-branch`
3. Update your feature branch: `git pull origin feature-branch`
4. `cd javascript` to move into the JavaScript subdirectory.
5. Delete the old `package-lock.json` with `rm package-lock.json`
6. Regenerate it with `npm install`
7. Add it to a new commit with `git add package-lock.json`
8. Commit: `git commit -m "your-initials update package-lock.json"`
9. Push: `git push origin feature-branch`

This should resolve the merge conflict.   If it doesn't, you can ask the course staff for help.
