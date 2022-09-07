---
parent: Topics
layout: default
title: "git: fixup commit"
description:  "Fixing an error you made in a previous commit"
indent: true
category_prefix: "git: "
---


See also, this video: <https://youtu.be/sgW9_D0vK5A>

Inevitably, you discover as you work in a feature branch, that you made a mistake in an earlier commit.

Of course you can just fix it with a new commit, but then you end up with a commit history like this:

```
0a89f pc - add students controller to support CRUD operations for students
34s9c pc - add front end React form component for student CRUD operations
3240a pc - fix spelling error in parameter name in students controller
7bd40 pc - add yet another missing HTTP header in controller
d0240 pc - add missing HTTP header in students controller
```

The last three commits are just fixing errors that are in the controller; the new file added in the first commit.

And those commits are now separated from the original commit by one dealing with a React form; an entirely separate concern.

Wouldn't it be nice if you just fix up the original commit?  Now you can.

The technique is explained in:
* This video by P. Conrad: <https://youtu.be/sgW9_D0vK5A>
* This web page by Florent Lebreton <https://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html>

But here's the short version:

1. Use `git log` to identify sha of commit you want to fix up (call this abcd1234), and the sha of the commit immediately before that one (e.g. dcba5678)

2. Use `git add` to add the files you want to add to your fixup commit
3. `git commit --fixup abcd1234` (sha of commit you want to fix up)
4. `git rebase -i --autosquash dcba5678` (sha of commit right before the one you want to fix up)
5. Exit the editor window (you don't have to change anything; the `--autosquash` has taken care of that).  For vim, it's type escape key, then `:wq`
6. force push your branch, e.g. `git push origin my-branch-name`
