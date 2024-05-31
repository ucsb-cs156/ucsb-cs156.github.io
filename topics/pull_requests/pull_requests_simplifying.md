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

### Step 2: Create a new branch from this one

Next, we are going to create our new branch.  Let's call it `AaronR-StudentTable-v2`

```
git checkout -b AaronR-StudentTable-v2
```

But we are *not* going to push this branch yet.  We need to do the surgery on this branch so that it point where we want.

### Step 3: Use `git reset --soft origin/main` to go back in time

Next, we use this command which takes the branch point back to `origin/main`, which means
the place that Github (`origin`) thinks is the latest commit on the main branch.

```
git reset --soft origin/main
git status
```

Let's explore what happened here:
* The branch we are on, `AaronR-StudentTable2` has been reset to point to the commit asociated with the `main` branch on Github.
* HOWEVER, because we used `--soft`, the files in our directory *did not change*. They still have all of our code changes in them!
* The files in green in your `git status` output now represent all of the differences between your branch and `main`.
  
When we do a `git status` we see, in green, all of the files that we changed.

### Step 4: Do a `git restore --staged .` to make everything red instead of green

Now, type the following commands:

```
git restore --staged .
git status
```

You should see all of your changed files, but now they are all red instead of green on the `git status` output,
meaning that they are not staged for the next commit.  So, now you can choose *only the files you want to include* in
the next commit.

### Step 5: `git add` on *only* the files we want

Now is the magic part: we only commit the changes to the files that we want, very carefully:

```
git add frontend/src/fixtures/studentsFixtures.js
git add frontend/src/main/components/Students/StudentsTable.js
git add frontend/src/stories/components/Students/StudentsTable.stories.js
git add frontend/src/tests/components/Students/StudentsTable.test.js
```

### Step 6: `git commit... ` on *only* the files we want, and push the branch

Now we commit:

```
git commit -m "ar - create StudentTable component with fixtures, stories, and tests"
```

And now we push:

```
git push origin AaronR-StudentTable-v2
```

### Step 7: Make a new PR for this branch

You can now make a new PR for this new simplified branch, copying over the parts of the description that make sense.

### What next

If you have other branches you want to create from the other files, you can now repeat the steps for those branches.

If you just want to get back to the main branch or some other branch, you can use the following commands to clean things up so
that you can return to your normal workflow:

```
git stash       # throw away changes to files git knows about
git clean -f    # throw away changes to files git does *not* know about
git checkout main  # or git checkout my-branch
git pull origin main  # or git pull origin my-branch
```

* More information about `git clean` is here:  [`git clean`](https://ucsb-cs156.github.io/topics/git/git_clean.html)







