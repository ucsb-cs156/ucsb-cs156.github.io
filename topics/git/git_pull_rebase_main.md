---
parent: Git
grand_parent: Topics
layout: default
title: "git: pull rebase main"
description:  "How to rebase your branch on main using git pull"
indent: true
category_prefix: "git: "
---


You start a feature branch with a fresh copy of `main`.  

But by the time you are ready to do your pull request, you may find that your branch is a bit behind the times.

You may even find that GitHub is showing that your branch cannot be merged becuase it is so far behind.

In that case *rebasing on main* can be useful.

# What does it mean to *rebase on main*

The idea is this: assume that the last three commits on main before you made your feature branch were `A->B->C`

Then, you make a feature branch, and you add commits `X->Y->Z`

Your branch now looks like this:

```
A->B->C->X->Y->Z
```

But in the meantime, others have made commits `J->K->L` and merged them into main. So main now looks like this:

```
A->B->C->J->K->L
```

Rebasing on main means that you'll take all of the commits that you made on top of the *old* main (`X->Y->Z`) and *replay* them on top of the new main.

The result is this:

```
A->B->C->J->K->L->X->Y->Z
```

Keep in mind, though that this is a "rewriting of history'.  So when you do it, you need to do something a little bit scary called a *force push*.

Now that we understand what's going on, here's how to do it.

# Doing a rebase on main

Doing a rebase on main is only possible if you are on a branch other than main. We'll assume your feature branch is called `xy-my-branch`

There are many ways to accomplish the task; here's one:

Start by doing:

```
git pull --rebase origin main
```

This starts a rebase.  

Note: this is the stage where there can be merge conflicts:
* If there are merge conflicts, a rebase is a *multi-step process*
* If you get back a message indicating there are merge conflicts, you are *not finished*.  You need to read the message and do what it says.
* Once you start, you have to either see it through to completion, or you have to abort.
* If you want to abort, the command is `git rebase --abort`; this will put things back as they were.

If you get back an immediate response, though, and no errors show, then the rebase was successful.  You can check by doing `git log` to see
that the commits you did show up on top of the other ones.  

Keep in mind though that this rebased branch stil exists *only on your local system*.  To update GitHub, you now need to do a force push:

```
git push origin xy-my-branch -f
```

This final step rewrites the branch on github with your commits as the *last* thing on the branch, with them replayed on top of 
the most up-to-date version of the `main` branch.

