---
parent: Git
grand_parent: Topics
layout: default
title: "git: cherry-pick"
description:  "When you want to construct a branch from specific commits"
indent: true
---

# {{page.title}} 

## {{page.description}}

We advise to [always start with a fresh copy of main](/topics/git/git_feature_branch_workflow.html#more-detail-about-creating-feature-branches) when creating a feature branch, so that each feature branch is independent of all of the others.

But what if you accidentally create a "branch off a branch" when you didn't intend to do so?

For example, consider this commit history:

<img width="651" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/76d21e3f-82d3-4d89-a194-c32f438dc045">

This appeared on a PR where only the final commit actually pertained to the issue being addressed, i.e. the one with SHA `feffce0` and commit message:

```
jl - Added feature so that swagger UI link shows depending on env
```

The previous two commits were actually for an entirely different PR.

What we want is a branch that only has the final commit in it.  

## How to use `git cherry-pick` 

Fortunately, there's an easy way to do this using `git cherry-pick`.

Here's the sequence:

```
git fetch origin           # update the local repos pointers
git checkout main          # get on the main branch
git pull origin main       # make sure local main is up-to-date
git checkout new-branch    # give this an entirely new name
git cherry-pick feffce0    # pull in the sha of the specific commit(s) you want
                           # if there are multiple ones, in order oldest to most recent
git push origin new-branch # now you can make a PR from the new branch
```

## Or, ane even braver way to use git cherry-pick


Or, if you want to  *keep the same PR*  and you are feeling brave, you can work directly on your old branch as shown below. 

This is riskier, in the sense that if you get it wrong, you may lose your work, but
if you are brave, it means you don't have to make a new PR:

```
git fetch origin
git checkout old-branch
git reset --hard origin/main  # set the branch old-branch back to where main now points
git cherry-pick feffce0       # pull in the sha of the specific commit(s) you want
                              # if there are multiple ones, in order oldest to most recent
git push origin old-branch -f # this "force pushes" the branch since it's history is now different
```
