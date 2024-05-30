---
parent: Pull Requests
grand_parent: Topics
layout: default
title: "Pull Requests: Simplifying"
description:  "Taking large complex PRs and turning them into smaller ones"
indent: true
---

# {{page.title}}

## {{page.description}}

Suppose you have a large PR that does several things:
* Introduces new backend code for an API call in `<FooController>` along with tests
* Introduces a new React component `<FooComponent>`, along with storybook entries and fixtures
* Introduces a new page in the front end `<FooPage>` that uses the `<FooController>` calls and the `<FooComponent>` to do some cool new thing in the app.

That's a lot of code to review and merge all at once. 

A better approach might be:
* PR1: just the new backend code for an API call in `<FooController>` along with tests
* PR2: just the new react component, with fixtures, storybook entry, and tests
* PR3: the page that brings it all together.

Fine. But what if you already have all three of these all in one branch? What's the easiest way to turn your one PR into three?

Here's a straightforward approach.  This should work with any PR where you:
* Have changes to many files
* But you want to create a new branch with *only* the changes to a subset of those files.

The one downside of the approach I'm going to show you here is that you lose the detailed commit history.  But often that's not a problem; in fact, it may give you the opportunity to rewrite the commit messages
so that they are actually more meaningful.  

So let's get started.  Let's assume your branch is called `AaronR-addStudentTable` and has changes to thirteen (13) files.   We want to create a new branch that only has the changes in exactly four of these files.
Those files are called:
* `frontend/src/fixtures/studentsFixtures.js`
* `frontend/src/main/components/Students/StudentsTable.js`
* `frontend/src/stories/components/Students/StudentsTable.stories.js`
* `frontend/src/tests/components/Students/StudentsTable.test.js`

In this case, we are creating a new branch that's just a new react component along with it's stories, but you could use this for any subset of the files.  
Also note that we are going to *leave the original branch unchanged* so that we have something to fall back on, and are not afraid of losing any work.  If/when we succesfully create
multiple new branches that cover all of the changes in the original branch, then we close the PR for the first one, and proceed with the three smaller ones.

### Step 1: Get a clean copy of our branch

```
git fetch origin   # update all branch pointers
git checkout AaronR-addStudentTable   #  get on our branch
git pull origin AaronR-addStudentTable  # make sure we have an up to date copy of the branch
```

### Step 2: Find the place where our branch started

Our next task is to find the sha (i.e. the hexadecimal hash code) of the commit before all of our changes started.

We can find this in one of two ways: (1) `git log` (2) looking at a PR on Github.

**(1) `git log` approach**

First, lets try the `git log` approach. We can use the `git log` command to look at all of the commits in this branch starting with the most recent.  We are looking back for the last commit right *before* we started making our changes.   When using `git log`, you may have to press enter a few times to scroll through all of the commits.  Use `q` to quit (or press control-C).

Type this:

```
git log
```

Here's what the output of that looks like: 

**(2) Githubn PR approach**

