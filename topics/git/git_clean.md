---
parent: Git
grand_parent: Topics
layout: default
title: "git: clean"
description:  "throw away untracked files easily"
indent: true
---

How to remove local untracked files from the current Git branch ([source](https://koukia.ca/how-to-remove-local-untracked-files-from-the-current-git-branch-571c6ce9b6b1))


* To see what files will be removed, use `git clean -n`
* To remove files, run `git clean -f ` 
* To remove files and directories, run `git clean -f -d` or `git clean -fd`
* To remove ignored files, run `git clean -f -X` or `git clean -fX`
* To remove ignored and non-ignored files, run `git clean -f -x` or `git clean -fx`
  
(Note the case difference on the `-x` and `-X` for the two latter commands.)  

To see other options, use:
* `git clean -h` (short version of help text)
* `git clean --help` (longer version of help text)

*CAUTION!* When using the commands the remove ignored files, you may end up removing files such as the following
that are typically in the `.gitignore` and contain your application configuration secrets:
* `temp-configuration.txt`
* `secrets-localhost.properties`
* `secrets-heroku.properties`
* `javascript/.env.local`

So proceed with caution.

