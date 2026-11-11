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

### The starting point

Suppose we start with this situation:

<img width="1360" height="400" alt="image" src="https://github.com/user-attachments/assets/9047ca2e-3983-4323-a338-e6e7fe5d8cc2" />

In the diagram above 
* M is the commit that `main` pointed to before you started your work.
* A and B are the commits for your PR
* N1 and N2 are commits that have been added to the `main` branch in the meantime, so now `main` points to `N2`, not `M` anymore.

This means that CI/CD:
* has been tested on the combination of the changes in `M` (and everything before it), `A`, and `B`. 
* has *not* been tested on the combination of your code with `N1` and `N2`.  

### What do the buttons do

Neither button moves `main`. Both only move the `feature` pointer. The difference is which commit it ends up pointing to.

<img width="1360" height="420" alt="image" src="https://github.com/user-attachments/assets/f18da5f4-412f-4f15-8446-f88ed28aa20c" />

**Update with merge commit**
- GitHub creates one new commit, U, with two parents: B (your old tip) and N2 (current `main`).
- `feature` moves from B to U. Since U is a child of B, this is a normal forward move.
- A and B are unchanged and keep their SHAs. `old-main` (M) stays in your branch's history as the place where you forked.
- Local effect: a plain `git pull` on the branch fast-forwards to U.

<img width="1360" height="510" alt="image" src="https://github.com/user-attachments/assets/f657f707-bb9d-46b0-af24-7ac300bc0e13" />

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


```
Before                       Update with merge commit       Update with rebase
                                                            
M---N1---N2   <- main        M---N1---N2   <- main          M---N1---N2   <- main
 \                            \         \                              \
  A---B       <- feature       A---B-----U   <- feature                 A'---B'  <- feature
(M = old-main)                                              (old A---B still exist, but
                                                             no branch points to them)
```

### The *other* button: "Create a merge commit", "Squash and merge", "Rebase and merge"

The *Update branch* button only moves **your** branch pointer.  The big green button at the bottom of
the PR is different: it's the one that moves **`main`**.  Its dropdown can offer up to three merge methods.

### Where these are set

A repo admin turns them on or off under **Settings → General → Pull Requests**, with the checkboxes
*Allow merge commits*, *Allow squash merging*, and *Allow rebase merging*.  Only the methods that are
enabled show up in the dropdown.  If more than one is enabled, whoever clicks the button chooses.
Branch protection rules or rulesets can narrow this further.  For example, *Require linear history*
rules out merge commits.  If a repo uses a merge queue, the queue picks the method instead.

All three examples below start from the "Update with merge commit" picture above: `feature` points to U.

### Create a merge commit (the default)

```
M---N1---N2-------P    <- main
 \         \     /
  A---B-----U----      <- feature
```

GitHub makes a new commit P with two parents: N2 (the old `main`) and U (your branch).  `main` moves to P.
Every commit, including A, B and U, keeps its SHA and stays in `main`'s history.

* Pro: nothing is rewritten; `git log --first-parent main` shows one entry per PR.
* Con: history fills up with merge commits, including the "update branch" ones.

### Squash and merge

```
M---N1---N2---S        <- main
```

GitHub makes **one** new commit S whose parent is N2.  S contains all of your PR's changes together.
`main` moves to S.  A, B, and U are *not* in `main`'s history at all.

* Pro: a clean history with one commit per PR, and how you updated your branch doesn't matter.
* Con: the individual commits are gone from `main`.  Because your branch's commits are not ancestors
  of `main`, `git branch -d feature` will say the branch is "not fully merged".  If you keep working
  on the same branch and open another PR, the old commits reappear in it.
  **Delete the branch after a squash merge and start a new one from `main`.**

### Rebase and merge

```
M---N1---N2---A''---B''   <- main
```

GitHub replays each of your commits on top of N2 and moves `main` to the last one.  The history is
linear, with no merge commit.  These are *new* commits with new SHAs, even if you had already rebased,
because GitHub always rewrites the committer info.

* Pro: linear history that still keeps each individual commit.
* Con: SHAs in `main` don't match the ones on your branch, so the same "start a fresh branch" advice applies.




