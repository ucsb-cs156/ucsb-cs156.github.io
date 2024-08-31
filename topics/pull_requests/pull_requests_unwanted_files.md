---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: unwanted files"
description:  "when you accidentally include many unwanted files in your PR (e.g. node_modules, stryker tmp, etc."
indent: true
---

# {{page.title}} - {{page.description}}

One thing that's very common among those that are new to git/github is the pull request that accidentally contains dozens (or hundreds or even thousands) of unwanted files.

There are a few commons cases:
* for Mac users, `.DS_Store` files 
* for anyone: the `node_modules` subdirectory
* for anyone: the stryker temporary files

# The root cause: being careless with `git add .`

The root cause here is that you typed `git add .` without actually *looking* to see what that added to your commit.

That's bad.  Don't do that.

# The solution: ALWAYS type `git status` immmediately after `git add .`

You will avoid this problem if you establish one simple habit:
* ALWAYS type `git status` immmediately after `git add .`
* ALWAYS type `git status` immmediately after `git add .`
* ALWAYS type `git status` immmediately after `git add .`

I've repeated this three times to emphasize how important it is.  

# But how do I clean it up?

There's a simple fix here.  You basically roll back time to before you did the `git add .`, and this time, you are more careful about what you add.

To "roll back time", you do this:

| command | explanation |
|---------|-------------|
| `git fetch origin`          | Make sure local branch pointers are up to date. |
| `git checkout my-branch`    | Get on your branch (the one with too many files. |
| `git pull origin my-branch` | Be sure local branch is up to date.              |
| `git log`                   | Look at all of the commits. Find the commit that's *before* the stray files were committed |
| `git reset --soft abcd123`  | Move the branch back to the commit before the bad stuff happened; but use `--soft` so that the files don't change and you don't lose your work. |
| `git status`                | You'll see the files that you need to commit. |
| `git add dir1/dir2/file1`   | Now you add the files you want. Here's how to add a specific file.|
| `git add dir/dir2`          | You can add a whole directory, but be sure you want *everything* in that directory that showed up in red on the `git status` |
| `git status`                | The *crucial* part; make sure you are committing exactly and only what you want. |
| `git commit -m "message"`    | Make a new commit; one that has what you want and excludes what you don't want.  Be sure the message reflects all of the changes (you might be replacing several old commits with one now.)|
| `git push origin my-branch --f`  | The `-f` is because Github is expecting something very different; you are rewriting history, so you have to let Github know that you really do want to completely change where the branch points. |

# Why not just a new commit that deletes all of the files

Note that you *could* do this. But if you do, and your PR gets merged into main, from now on, every future developer on this project will *curse* you.

Just *deleting them in a new commit* leave all of the add / deletes of those file are part of the
github history.  *Permanently*.

Doing it that way makes it so that everytime, from now on, someone clones this repo, all of those files
are are part of its history.  That means the download of the repo will be *much, much slower* and the disk
space it takes up will be *much, much larger*, and *for absolutely no benefit*.

Doing the git surgery necessary to clean that up after the fact is *much* harder than fixing it *now*.

So, do it the right way. Roll things back instead so that commit doesn't end up in the main branch in the first place.

# Shouldn't `.gitignore` handle this?

In a perfect world, yes.  In a perfect world, everything you don't want to commit (i.e. include in a `git add .`) would be excluded by the specifications in the `.gitignore`.

But no `.gitignore` can cover 100% of the ways things can go sideways.  

For example, you can end up with a node_modules directory in your root directory (where the .gitignore isn't expecting it) instead of the `frontend` directory, if you were to type something like  
`npm install package-name --save`  in the root directory instead of the `frontend` directory.
