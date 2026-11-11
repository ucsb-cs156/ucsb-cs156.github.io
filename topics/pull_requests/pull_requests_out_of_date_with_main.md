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

The impact is that your PR isn't mergeable in it's current form, because CI/CD has only tested your code on top of the "old version" of `main`, which isn't 
what we will actually *get* after merging your PR.   

The basic problem is that two PRs can each pass on their own and still break `main` when they're combined.  

So the branch protection rules for `main` specify that we need an updated version of the commit history that combines your changes with the current version of `main`, and *that* has to pass CI/CD before we are permitted to merge the code.  This is part of the "continuous integration" (CI) part of CI/CD; we need to be continuously integrating new changes with the `main` branch and testing them thoroughly before merging them.

So, to get it mergable, we need to either do a "merge" or a "rebase".

## Ok, what's the short version of what I need to do?

Typically, you just click the button, take the default (`merge`) wait for CI/CD to run again, and then the problem is solved.

That's usually enough, but it you want to *understand* what's happening, and the difference between "merge" and "rebase", read on.

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

Full disclosure: this page was hand written up to this point.  I asked Claude for help with this part, using the following prompt:
```
Please read over this page: 

https://github.com/ucsb-cs156/ucsb-cs156.github.io/blob/main/topics/pull_requests/pull_requests_out_of_date_with_main.md

Then, help me construct an explanation of the difference between what happens when you click 
"Update with merge commit" vs. "Update with rebase" in terms of the branch pointers for your branch, 
the old place that main pointed before you started (call this old-main) the current value of main and the new value of main.

If you can make diagrams to explain it, even better!
```

### What each button does to the pointers

Neither button moves `main`. Both only move the `feature` pointer. The difference is which commit it ends up pointing to.

**Update with merge commit**
- GitHub creates one new commit, U, with two parents: B (your old tip) and N2 (current `main`).
- `feature` moves from B to U. Since U is a child of B, this is a normal forward move.
- A and B are unchanged and keep their SHAs. `old-main` (M) stays in your branch's history as the place where you forked.
- Local effect: a plain `git pull` on the branch fast-forwards to U.

**Update with rebase**
- GitHub replays your changes on top of N2. This creates new commits A′ and B′. They have the same diffs and messages as A and B but different SHAs, because their parents are different.
- `feature` moves from B to B′. B is not an ancestor of B′, so this is a force-push style update.
- A and B still exist, but no branch points to them anymore. M is no longer special for your branch. As far as `feature` is concerned, it's just an ordinary commit in `main`'s history.
- Local effect: your laptop's `feature` still points to B, so the two copies have diverged. A plain `git pull` will either complain or create a messy merge. Students need `git fetch` followed by `git reset --hard origin/feature`, or `git pull --rebase`. In practice, this is the main reason to tell students to prefer the merge option.

**Either way,** N2 (current `main`) is now an ancestor of `feature`, and that's what makes GitHub stop saying "out of date." CI then re-runs on a commit whose content includes your work plus N1 and N2.

### The new value of `main` (after the PR is merged)

Which of these you get depends on the repo's merge button setting, not on how the branch was updated:

| | After "update with merge" | After "update with rebase" |
|---|---|---|
| **Create a merge commit** | new `main` = P, parents N2 and U | new `main` = P, parents N2 and B′ |
| **Squash and merge** | new `main` = S, parent N2 | new `main` = S, parent N2 |
| **Rebase and merge** | linear history, with no merge commits | linear: M–N1–N2–A′–B′ |

The squash row is a good teaching point. If the course repos squash-merge, the choice of update button leaves no trace in `main`. It only affects the PR branch and the students' local clones.

```
Before                       Update with merge commit       Update with rebase
                                                            
M---N1---N2   <- main        M---N1---N2   <- main          M---N1---N2   <- main
 \                            \         \                              \
  A---B       <- feature       A---B-----U   <- feature                 A'---B'  <- feature
(M = old-main)                                              (old A---B still exist, but
                                                             no branch points to them)
```





