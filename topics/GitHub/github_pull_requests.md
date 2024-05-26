---
parent: GitHub
grand_parent: Topics
layout: default
title: "github: pull requests"
description:  "working with pull requests (PRs) in github"
indent: true
category_prefix: "github: "
---

Pull Requests are a feature of GitHub that allows a developer to request that work in one branch into another branch.

Pull Requests can be made:
* between any two branches of the same repo
* between branches that are in different repos if they are forks of the same repo

However, the usual use case for pull requests in this course
* From a feature branch of a repo
* Into the `main` branch of the repo

A PR is typically associated with one or more issues (see: <https://ucsb-cs156.github.io/topics/github_issues/>)

# PR Descriptions

See also: <https://ucsb-cs156.github.io/topics/pull_requests/#pr-descriptions>

When submitting a PR, it is considered good practice to write a brief description of the PR.

Sometimes this may seem redundant with the description that is associated with the issue.  The difference is that
the description on a PR is often written more from the standpoint of how the PR affects the product, i.e. 
* how will the changes in this PR affect the end user
* what does the product team need to know about what this PR does to the code base?

PRs are often used later as a kind of documentation of how to go about making a particular kind of change to the code base;
for example, a PR that adds a new kind of CRUD operation to an application might be used as a kind of "road map" the next time
a developer wants to add a CRUD operation to the same product.   So having a good description, along with good commit messages is 
key to helping the next wave of developers understand the changes that were made to the product.

# What should be in a PR description?

It depends on the type of PR, but here are a few specifics:

## Backend only changes

If you are adding a new API endpoint for the backend, include the urls and HTTP methods for the new endpoints.

One easy way to do that is to put in a screenshot of the Swagger endpoint.  For example:

<img width="1256" alt="image" src="https://user-images.githubusercontent.com/1119017/172028100-192f4b87-9ca5-4df5-976a-d5ec71e7eaab.png">

It is also helpful to have a test plan. For example:

1. Go to Personal Schedules List, and make sure there is at least one personal schedule.  If not, add one, and remember the id.
2. to Courses List and make sure there are a couple of courses for that personal schedule id.
3. Go to the endpoint in the screenshot above and enter the personal schedule id.  You should see the information for the course.s

## New React Components (not yet available in the app)

If the change is to add some new React components that have not yet been integrated into the app, then a good thing to put in the PR description is some screenshots, and links to the Storybook for the component.

## Other Cases

There are many cases, but there are a few things that are generally helpful where applicable:
* "before and after" screenshots, or animated gifs produced with a tool such as [Licecap](https://www.cockos.com/licecap/) 
* a test plan with step by step instructions 

# PR Description Examples

From: <https://github.com/ucsb-cs156-w21/proj-ucsb-courses-search/pull/132>

>It's time to register for Spring classes! This short PR adds the S21 option for the Basic Course Search on the main page and sets it as the default option.
>
> This change is only being made in `BasicCourseSearchForm` for now, since the MongoDB archive doesn't have anything for S21 yet. I'll make a separate PR for the dropdowns of the archived course searches, which we can merge in when the MongoDB archive is made.

# PR Description Prompts

At a minimum, you can write something like this 

For new features:

```
In this PR, we implement the following user story:

(Cut and paste user story from issue here)
```

For bug reports:

```
In this PR, we fix the following bug:

(Cut and paste Steps to reproduce, Observed and Desired behaviors here)
```

For refactorings:

```
In this PR, we refactor the code so that (describe the refactoring here, and what benefits it is intended to acheive)
```

# "This branch is out-of-date with the base branch"

When you get this message, what do you do?

<img width="921" alt="image" src="https://user-images.githubusercontent.com/1119017/170527624-909695cf-dfcb-48f1-ba3a-bbda9d97f208.png">

Often, you can just do this:

<img width="426" alt="image" src="https://user-images.githubusercontent.com/1119017/170527721-a7454ea5-ac8a-438e-9d36-e3f9f10ec845.png">

Keep in mind that after you do this, if you continue working on the branch locally, you'll need to do another pull from github:

```
git pull origin my-branch
```

