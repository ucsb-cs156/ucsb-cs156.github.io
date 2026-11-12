---
parent: "Code Reviews"
grand_parent: Topics
layout: default
title: "Code Reviews: Checking  Deployment, and Testing the PR"
description:  "Code review is more than just the code"
---

# {{page.title}}
## {{page.description}}

There are a variety of practices regarding the relationship between two things:
* reviewing the source code for style, patterns/anti-patterns, etc.
* reviewing the deployed app for correctness by actually running it and testing it.

In some organizations, these are entirely separate, done by separate people at separate times.

In others, these are considered part of the same activity, i.e. **code review includes reviewing the deployed code for correctness by testing it**.

**In this course, we adopt the second practice**.

That means that except in a very few corner cases (described below):
* **every PR needs a dokku deployment**
* **every PR needs a test plan**, i.e. a description of a series of steps to take on the deployment to show that the PR works properly
* every code reviewer needs to **check that the deployment is on the same SHA as the PR**
* every code reviewer needs to **actually run the code** on this deployment before marking it LGTM and approving it.

## Checking that the SHA matches

All of our legacy code apps have a feature called "Admin/Developer Info" to show the SHA of the commit that is being run.  

To access this feature, login as an admin, go to the admin menu, and find "Developer Info".

Then, check that the SHA matches the one on the PR.

