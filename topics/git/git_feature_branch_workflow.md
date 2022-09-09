---
parent: Git
grand_parent: Topics
layout: default
title: "git: feature branch workflow"
description:  "One branch per feature/issue/story"
indent: true
---

This article describes a more advanced workflow than the [Git: Basic Workflow](/topics/git_basic_workflow/) where all work is done on the `main` branch.

You should be completely comfortable with the [Git: Basic Workflow](/topics/git_basic_workflow/) before diving into this more advanced topic.

# A quick refresher: create a new branch off `main`

If you are already familiar with this topic, here's a brief refresher on how to create a new feature branch.  If this is your first time reading about this topic, don't worry if this doesn't entirely make sense yet.

To create a new feature branch, first decide on a name for your branch, e.g. `4pm-3-sortCoursesByQtr`.  We'll just call the new branch `4pm-3-newBranch`

```
git status
git fetch
git checkout main
git pull origin main
git checkout -b newBranch
```

An explanation of each of these comamnds:

| Command | Explanation |
|---------|-------------|
| `git status` | Be sure there is no unsaved work; if so, deal with it first. |
| `git fetch` | Update all of the local branch information in your repo |
| `git checkout main` | Put your repo on the `main` branch |
| `git pull origin main` | Update the local `main` branch to be synced with the `main` branch on the `origin` remote (i.e. GitHub) |
| `git checkout -b newBranch` | Create a new branch called `newbranch` that starts out pointing to the same commit as `main` |
{:.table .table-sm .table-striped .table-bordered}



# A workflow based on feature branches

In most "real-world" uses of git/github (e.g. at software companies), rather than working on the `master` branch being the common case,
it is far more often the case that you *never, ever, ever work directly on master!!!*

Instead, each time you start a new story, issue, feature or bug fix, you start by creating a "feature branch" as an alternative to the `master` branch.

When you are finished with the story, feature, bug fix, etc. you would do a pull request from the feature branch
to the `master` branch.  This could be a pull request within the same repository, or it could be a pull request from one fork of a repo to another.

# Using this workflow 

You will use this branch method to avoid accidentally making changes to pending/open pull requests while working on other issues. That might happen when you do all your work on master because pull requests don't use a snapshot of the code from the time that you made the pull request; instead, they point to the branch you are trying to pull from. This means if you push more changes to a branch after making a pull request from that branch, these changes will be reflected in the pull request immediately. And the goal here is to submit each issue you resolve in a separate pull request.

Every pull request should be from a feature branch.

This will also show you how many teams develop software **in the real
world**. In these environments, you **never, ever, ever** make changes
directly to the master branch. Master is for **production-ready
code**. Devvelopment teams use branches to keep in-development
projects/pieces separate.

# How to

When beginning work on an issue, you should start clean from the master version. `git status` will tell you which branch you are on. If you are not on master, switch to master with `git checkout master` (your changes on the other branch will not be lost; they will still be there if you `git checkout` back to that branch). Make sure you are up-to-date by calling `git pull`, then create a new branch with `git checkout -b BRANCH_NAME`.

It is a good practice to start your branch name with the name
of your team, followed by a hyphen and then a brief description
of the feature you are working on.

```
$ git checkout -b teamName-text-color
Switched to a new branch 'teamName-text-color'
$
```

The `-b` means to create a new branch; if you are switching to an existing branch, you can just leave off the `-b`. 

As you work on this branch, you will use:

* `git push origin teamName-text-color` rather than `git push origin master`
* `git pull origin teamName-text-color` rather than `git pull origin master`

After you've committed all your changes on this feature branch, push it, and then open a new pull request repo from the branch you were working on and include the issue in the pull request description.
