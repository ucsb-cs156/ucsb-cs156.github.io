---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: excessive whitespace changes"
description:  "Don't include excessive whitespace changes to unrelated code"
indent: true
---

# {{page.title}} 
## {{page.description}}

A problem that arises occasionally in PRs is when the developer has done lots of "white space changes" in code unrelated to the PR.

This can be well-intentioned: perhaps it is reformatting the code to meet a particular indentation standard.

The problem is that this clutters up the "diff" on the PR, making the code review really challenging.

Example: This PR that has changes to 25 files, most of which are just whitespace.

<img width="1000" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/2b20c3e5-3845-4114-8d79-c004f76c5273">


## Is this really a big deal?

In CS156, we generally take a pragmatic approach to this when it's just a very small amount of white space changes, e.g. a single blank line here, a small indentation change there.

If the code review is still easy to read, and the reviewer can just easily disregard the clutter and easily find the code that was changed, we let it slide.

Having said that:
* There are software developer organizations out there, or individual code reviewers, that take a zero-tolerance policy to this.  If you have even a single line of unrelated white space, you'll be asked to fix it.  
* There are times when the number of whitespace changes is so excessive that it seriously impairs the ability of the code reviewer.

So it's important to know how to fix this.

## But what if the whitespace *really, really* needs to be fixed?

No doubt, there are times when we need to fix formatting issues!

But the best approach is to make a *separate PR* that focuses *only* on fixing formatting issues.  That way, the code reviewer can put themselves in the frame of mind where they are scanning *only* to make sure that the changes
are *only* to whitespace.  That's much easier to review, especially when the size of the changes is large.

## Ok, how do I fix it?

There are at least two approaches:

* Fix the branch to have only the changes to the files that are needed for the new functionality, OR
* Make a new PR that has only those changes.

One way to do the first approach is this:

```
git fetch
git checkout my-branch
git pull origin my-branch
git reset --soft origin/main
git status
```

You should now see all of the files that were modified, showing up in "red" as files that have been modified by not yet commited.  Now, go through, and for each file that does NOT pertain to the PR, restore it to it's original version.  For example:

```
git checkout frontend/.babelrc
git status
git checkout frontend/.eslintrc.json
git status
```
etc.   Each time you do the `git checkout filename` it should restore that file to what is in the main branch, discarding the changes.  DO NOT do this for the files that actually HAVE changes that are important to the PR.   Instead, for those files, use:

```
git add frontend/src/main/components/Courses/CourseForm.js
git status
```

For each, you should see that the file turns "green" because it's going to be added to the next commit.

When done, `git status` should show you ONLY the files that you want in the PR.
Then, do a new commit:

```
git commit -m "xy - I added the foobar feature and fixed the fiddle screen"
```

Then you need to do:

```
git push origin my-branch -f
```

The `-f` is needed because you are "rewriting history".



