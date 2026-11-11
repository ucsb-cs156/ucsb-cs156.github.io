---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: Out of Date with Main"
description:  "What that message means on GitHub"
---

# {{page.title}}
## {{page.description}}

Sometimes you see this pop up on a PR:

<img width="808" height="99" alt="image" src="https://github.com/user-attachments/assets/b3a41e0d-f5a6-40f3-8423-021ef5658ef4" />

The dropdown options are these:

<img width="329" height="164" alt="image" src="https://github.com/user-attachments/assets/0043932f-a25d-47b4-a7f6-b66ef8847950" />

If other PRs have been merged, where the `main` pointer points is different from where it used to point.  That's what we mean when we say "`main` has moved".

The impact is that your PR isn't mergeable in it's current form, because it would cause the project to drop some commits.  To get it mergable, we need to either
do a "merge" or a "rebase".

## Ok, what's the short version of what I need to do?

Typically, you just click the button, wait for CI/CD to run again, and then the problem is solved.

That's usually enough, but it you want to *understand* what's happening, read on.

## The mental model of "commits"

Before we can talk about why this is happening, and what the difference is between a merge and rebase, we have to make sure
we understand what we mean by "branch".

Developers that are new to working with branches often have a very incorrect mental model about what a branch *is*.

* A branch is a "pointer to a commit".  

It is nothing more, and nothing less.

When the message above arises, it is because the `main` branch pointer has "moved" since the time you created this branch; it points to a different commit than the one
that is the parent of the commits in your branch.

## But isn't the branch "all of the commits"?

No.  To repeat: a branch is just a pointer (literally in the data structures and algorithms sense of "pointer") to a *single commit*.

The word *branch* sounds like it refers to a whole "collection of commits", and sometimes it is informally used to mean this.

In this sense of the word, it typically means: 
* start from the commit the branch points to
* follow parent links (keeping in mind that merge commits can have more than one parent)
* until you reach some other commit (often `main`, or what `main` used to be when the branch was created)

But this is not, technically, the definition of branch, or how it is implemented, and this mental model can interfere with understanding how commands such as the following work:
* `git merge`
* `git rebase`
* `git reset`

To understand these command properly, you need to start with the mental model that: *a branch is a pointer to a commit, identified by it's SHA*. 

It's really just a handy name that we give to a SHA, the same way in a C++ program, we might have `p` or `head` or `tail` be a variable that stores the
address in memory of some piece of dynamically allocated memory, or a reference in a Java program is handy name for the location of some instance of `java.lang.Object`.

## Ok, so what's merge vs. rebase

