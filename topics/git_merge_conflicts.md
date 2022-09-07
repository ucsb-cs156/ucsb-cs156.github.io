---
parent: Topics
layout: default
title: "git: merge conflicts"
description:  "Not nearly as scary as you may have been told"
indent: true
category_prefix: "git: "
---

Sometimes you are going to merge a pull request, and you see this:

<img width="1014" alt="image" src="https://user-images.githubusercontent.com/1119017/154364581-a88d01e5-665d-45ef-911d-9dba6903aae4.png">

This indicates a merge conflict that must be resolved before you can merge the PR.

In this case, it is a merge conflict in the file `package-lock.json`, which, as we'll see, is a bit of a special case. 

It is so much a special case, that we are going to devote a whole separate page to it, here:
* <https://ucsb-cs156.github.io/topics/node_package_lock_json_merge_conflicts/>

This video illustrates how to resolve a basic merge conflict: <https://youtu.be/gVQd3jTEUwU>


