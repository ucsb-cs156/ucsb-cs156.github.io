---
topic: "github: pull requests"
desc: "working with pull requests (PRs) in github"
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

When submitting a PR, it is considered good practice to write a brief description of the PR.

Sometimes this may seem redundant with the description that is associated with the issue.  The difference is that
the description on a PR is often written more from the standpoint of how the PR affects the product, i.e. 
* how will the changes in this PR affect the end user
* what does the product team need to know about what this PR does to the code base?

PRs are often used later as a kind of documentation of how to go about making a particular kind of change to the code base;
for example, a PR that adds a new kind of CRUD operation to an application might be used as a kind of "road map" the next time
a developer wants to add a CRUD operation to the same product.   So having a good description, along with good commit messages is 
key to helping the next wave of developers understand the changes that were made to the product.

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

